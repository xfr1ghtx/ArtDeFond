//
//  AuthManager.swift
//  ArtDeFond
//
//  Created by Someone on 20.08.2022.
//

import Foundation

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol AuthManagerDescription {
    
    func userID() -> String?
    
    func isAuthed() -> Bool

    func signIn(withEmail email: String, withPassword password: String, completion: @escaping (Result<Void, Error>) -> Void)
    
    func signUp(
        withEmail email: String,
        withPassword password: String,
        image: String,
        nickname: String,
        description: String,
        tags: [String],
        completion: @escaping (Result<Void, Error>) -> Void
    )
    
    func getUserInformation(for user_id: String, completion: @escaping (Result<User, Error>) -> Void)
    
//    func updateUserInformation(for user_id: String, completion: @escaping ()->())
    
    // user updater class??? for various types of updates (email, password, etc)
    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void)
    
    func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void)
}

final class AuthManager: AuthManagerDescription {
    
    private let database = Firestore.firestore()
    
    static let shared: AuthManagerDescription = AuthManager()
    
    private init() {}
    
    func isAuthed() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func userID() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    func signIn(withEmail email: String, withPassword password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                
                guard let user_id = Auth.auth().currentUser?.uid else {
                    return
                }
            
                print(user_id)
                
                self?.database.collection("users").document(user_id).getDocument { (document, err) in
                    if let err = err {
                        completion(.failure(err))
                    } else {
                        completion(.success(()))
                    }
                }
            }
        }
    }
    
    func signUp(
        withEmail email: String,
        withPassword password: String,
        image: String,
        nickname: String,
        description: String,
        tags: [String],
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let user_id = authResult?.user.uid else {
                    return
                }
                
                let user = User(id: user_id, email: email, nickname: nickname, description: description, tags: tags, avatar_image: "", account_balance: 0)
                
                try? self.database.collection("users").document(user_id).setData(from: user, encoder: Firestore.Encoder()) { error in
                    
                    if let error = error {
                        completion(.failure(error))
                    } else {
//                        WalletManager.shared.newWallet(for: user_id)
                        completion(.success(()))
                    }
                }
            }
        }
    }
    
    
    func getUserInformation(for user_id: String, completion: @escaping (Result<User, Error>) -> Void) {
        database.collection("users").document(user_id).getDocument { (document, err) in
            if let err = err {
                completion(.failure(err))
            } else {
                guard let document = document,
                      document.exists,
                      let data = document.data(),
                      let user = self.user(from: data)
                else {
                    completion(.failure(NetworkError.shitHappens))
                    return
                }
                completion(.success(user))
            }
        }
    }
    
    
    func updateUserInformation(for user_id: String, completion: @escaping () -> ()) {
        // updater
    }
    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void) {
        let user = Auth.auth().currentUser
        
        guard let user = user else {
            return
        }
        user.delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.database.collection("users").document(user.uid).delete() { err in
                    if let err = err {
                        completion(.failure(err))
                    } else {
                        completion(.success(()))
                    }
                }
            }
        }
    }
}


extension AuthManager {
    func user(from data: [String: Any]) -> User? {
        let result = try? Firestore.Decoder().decode(User.self, from: data)
        return result
    }
}


struct User: Codable {
    var id: String
    var email: String
    var nickname: String
    var description: String
    var tags: [String]
    var avatar_image: String
    var account_balance: Int
}



