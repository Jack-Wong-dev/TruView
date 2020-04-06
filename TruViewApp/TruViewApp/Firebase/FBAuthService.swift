import Foundation
import FirebaseAuth


class FirebaseAuthService {
    static let manager = FirebaseAuthService()

    private let auth = Auth.auth()

    var currentUser: User? {
        return auth.currentUser
    }

  
    func createNewUser(email: String, password: String, completion: @escaping (Result<User,Error>) -> ()) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let createdUser = result?.user {
              completion(.success(createdUser))
            } else if let e = error {
                completion(.failure(e))
            }
        }
    }
  
  
    func updateUserFields(userName: String? = nil, completion: @escaping (Result<(),Error>) -> ()){
        let changeRequest = auth.currentUser?.createProfileChangeRequest()
        if let userName = userName {
            changeRequest?.displayName = userName
        }
        changeRequest?.commitChanges(completion: { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
          })
    }
  

    func loginUser(email: String, password: String, completion: @escaping (Result<(), Error>) -> ()) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let user = result?.user {
                completion(.success(()))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }

  
    func logOutUser(completion: @escaping (Result<(), Error>) -> ()) {
          do{ try auth.signOut()}
          catch {
              print(error)
          }
      }
  
  
    private init () {}
  }
