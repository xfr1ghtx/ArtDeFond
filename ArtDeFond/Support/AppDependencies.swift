//
//  AppDependencies.swift
//  ArtDeFond
//
//  Created by developer on 14.08.2022.
//

import Foundation
import FirebaseFirestore

protocol Dependencies{
    var firestore: Firestore { get }
}

struct AppDependencies: Dependencies{
    
    let firestore: Firestore
}
