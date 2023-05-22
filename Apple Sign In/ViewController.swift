//
//  ViewController.swift
//  Apple Sign In
//
//  Created by MD. SHAYANUL HAQ SADI on 22/5/23.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {
    
    var firstName = String()
    var lastName = String()
    var email = String()
    
    private let signInButton = ASAuthorizationAppleIDButton()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(signInButton)
        
        signInButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        signInButton.center = view.center
    }

    @objc func didTapSignInButton () {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

}


extension ViewController: ASAuthorizationControllerDelegate {
    
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("failed")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credintials as ASAuthorizationAppleIDCredential:
            firstName = (credintials.fullName?.givenName)!
            lastName = (credintials.fullName?.familyName)!
            email = credintials.email!
            
            print("firstName",firstName)
            print("lastName", lastName)
            print("email", email)
            
            break
        default:
            break
        }
    }
}


extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    
}
