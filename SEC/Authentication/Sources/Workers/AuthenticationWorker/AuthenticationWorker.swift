import UIKit
import Firebase

public protocol AuthenticationWorkerProtocol {
    /// Starts the phone number authentication flow by sending a verification code to the specified phone number.
    /// - Parameters:
    ///   - phoneNumber: The phone number to be verified.
    ///   - success: The verification ID
    ///   - failure: Error
    func verifyPhoneNumber(
        phoneNumber: String,
        success: @escaping (String) -> Void,
        failure: @escaping (Error) -> Void)
    
    /// Asynchronously signs in to Firebase after creating credentials from provided verificationID and received verificationCode
    /// - Parameters:
    ///   - verificationID: The verification ID
    ///   - verificationCode: The verification code obtained from the user.
    ///   - success: Auth result
    ///   - failure: Error
    func signIn(
        verificationID: String,
        verificationCode: String,
        success: @escaping (AuthDataResult?) -> Void,
        failure: @escaping (Error) -> Void)
    
    /// Signs out the current user.
    /// - Parameters:
    ///   - success: Called when signs successfuly
    ///   - failure: Error
    func signOut(
        success: @escaping () -> Void,
        failure: @escaping (Error) -> Void)
    
    /// Get current user, or null if there is none
    var user: User? { get }
    
    /// The verification ID stored in UserDefaults. Should be obtained from invoking verifyPhoneNumber. Returns nill when any ID is stored.
    var verificationID: String? { get set }
}

public final class AuthenticationWorker: NSObject, AuthenticationWorkerProtocol {
    
    // MARK: - Private Properties
    
    private lazy var auth = Auth.auth()
    
    // MARK: - Public Properties
    
    public var user: User? {
        auth.currentUser
    }
    
    public var verificationID: String? {
        set(verificationID) {
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
        }
        get {
            UserDefaults.standard.string(forKey: "authVerificationID")
        }
    }
    
    // MARK: - Public Methods
    
    public func verifyPhoneNumber(
        phoneNumber: String,
        success: @escaping (String) -> Void,
        failure: @escaping (Error) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                failure(error)
            }
            
            if let verificationID = verificationID {
                success(verificationID)
            }
        }
    }
    
    public func signIn(
        verificationID: String,
        verificationCode: String,
        success: @escaping (AuthDataResult?) -> Void,
        failure: @escaping (Error) -> Void) {
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            failure(error)
          } else {
           success(authResult)
          }
        }
    }
    
    public func signOut(
        success: @escaping () -> Void,
        failure: @escaping (Error) -> Void) {
        do {
            try auth.signOut()
        } catch let error {
            failure(error)
        }
        success()
    }
    
}
