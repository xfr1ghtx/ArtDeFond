//
//  Coordinator.swift
//  ArtDeFond
//
//  Created by developer on 11.08.2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject{
    var childCoordinators: [Coordinator] {get set}
    
    var rootViewController: UINavigationController {get set}
    
    func start()
    
    func removeAllChildCoordinatorsWithType<T: Coordinator>(_ type: T.Type)
}

extension Coordinator{
    func removeAllChildCoordinatorsWithType<T: Coordinator>(_ type: T.Type){
        childCoordinators = childCoordinators.filter{ $0 is T == false }
    }
}

extension Coordinator where Self: Equatable {
    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
}
