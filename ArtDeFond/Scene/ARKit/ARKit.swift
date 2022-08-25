//
//  ARKit.swift
//  ArtDeFond
//
//  Created by Ivan Vislov on 25.08.2022.
//


import UIKit
import SceneKit
import ARKit

class ARKitViewController: UIViewController, ARSCNViewDelegate, ARCoachingOverlayViewDelegate {
    
    var sizeLabel = UILabel()
    var sceneView = ARSCNView()
    var grids = [Grid]()
    var placedImages = false
    var imageNode: SCNNode?
    var imageWidth = 0.7
    var imageHeight = 0.3
    //let deleteButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(removePainting))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSceneView()
        
        addCoaching()
        addSizeLabel()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        sceneView.addGestureRecognizer(gestureRecognizer)
        
        sceneView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:))))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .vertical
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func configureSceneView() {
        view.addSubview(sceneView)
        sceneView.frame = view.bounds

        sceneView.delegate = self
        
        let scene = SCNScene()
        
        sceneView.scene = scene
    }
    
    
    func addCoaching() {

        if #available(iOS 13.0, *) {
            let coachingOverlay = ARCoachingOverlayView()
        
            view.addSubview(coachingOverlay)
            coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                coachingOverlay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                coachingOverlay.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                coachingOverlay.topAnchor.constraint(equalTo: view.topAnchor),
                coachingOverlay.leftAnchor.constraint(equalTo: view.leftAnchor),
                coachingOverlay.rightAnchor.constraint(equalTo: view.rightAnchor),
                coachingOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

            coachingOverlay.goal = .verticalPlane

            coachingOverlay.session = sceneView.session

            coachingOverlay.delegate = self
        } else {
            return
        }
        
    }
    
    func addSizeLabel() {
        view.addSubview(sizeLabel)
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sizeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sizeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66),
            sizeLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65),
            sizeLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        sizeLabel.text = "размер \(imageWidth) x \(imageHeight)"
        sizeLabel.textAlignment = .center
        sizeLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        sizeLabel.textColor = .white
        sizeLabel.layer.shadowColor = UIColor.black.cgColor
        sizeLabel.layer.shadowOpacity = 0.5
        sizeLabel.layer.shadowRadius = 2.0
        sizeLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        sizeLabel.layer.masksToBounds = true
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor, planeAnchor.alignment == .vertical else { return }
        let grid = Grid(anchor: planeAnchor, transp: placedImages)
        self.grids.append(grid)
        node.addChildNode(grid)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor, planeAnchor.alignment == .vertical else { return }
        let grid = self.grids.filter { grid in
            return grid.anchor.identifier == planeAnchor.identifier
        }.first
        
        guard let foundGrid = grid else {
            return
        }
        
        foundGrid.update(anchor: planeAnchor)
    }
    
    @objc func tapped(gesture: UITapGestureRecognizer) {
        
        let touchPosition = gesture.location(in: sceneView)
        
        let hitTestResults = sceneView.hitTest(touchPosition, types: .existingPlaneUsingExtent)
        
        // Get hitTest results and ensure that the hitTest corresponds to a grid that has been placed on a wall
        guard let hitTest = hitTestResults.first, let anchor = hitTest.anchor as? ARPlaneAnchor, let gridIndex = grids.index(where: { $0.anchor == anchor }) else {
            return
        }
        addPainting(hitTest, grids[gridIndex])
    }
    
    @objc func panGesture(_ gesture: UIPanGestureRecognizer){
        guard let imageNode = imageNode else {
            return
        }
        
        let loc = gesture.location(in: self.view)
        let hitResult = self.sceneView.hitTest(loc, types: .existingPlane)
        if !hitResult.isEmpty{
            guard let hitResult = hitResult.last else { return }
            imageNode.position = SCNVector3Make(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
        }
    }
    
    
    
    func addPainting(_ hitResult: ARHitTestResult, _ grid: Grid) {
        if placedImages {
            return
        }

        let planeGeometry = SCNPlane(width: 0.7, height: 0.3)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "imageA")
        planeGeometry.materials = [material]
        
        let paintingNode = SCNNode(geometry: planeGeometry)
        imageNode = paintingNode
        paintingNode.transform = SCNMatrix4(hitResult.anchor!.transform)
        paintingNode.eulerAngles = SCNVector3(paintingNode.eulerAngles.x + (-Float.pi / 2), paintingNode.eulerAngles.y, paintingNode.eulerAngles.z)
        paintingNode.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
        sceneView.scene.rootNode.addChildNode(paintingNode)
        //grid.removeFromParentNode()
        placedImages = true
        if #available(iOS 13.0, *) {
            navigationItem.rightBarButtonItem =
            UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(removePainting))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(removePainting))
        }
        for node in grids {
            node.planeGeometry.materials[0].transparency = 0.0
        }
        
    }
    
    @objc func removePainting() {
        imageNode?.removeFromParentNode()
        navigationItem.rightBarButtonItem = nil
        placedImages = false
        for node in grids {
            node.planeGeometry.materials[0].transparency = 1.0
        }
    }
}
