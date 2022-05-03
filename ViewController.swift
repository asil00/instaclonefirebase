//
//  ViewController.swift
//  instaCloneFirebase
//
//  Created by Asilcan Çetinkaya on 21.03.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore

class ViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func singUpClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if error != nil {
                    self.makeAlert(titleInPut: "Error!", messageInPut: error?.localizedDescription ?? "Error!")
                    
                }else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                    
            }
            
        }else {
           makeAlert(titleInPut: "Error", messageInPut: " Username / Password ")
        }
        
        
    }
    @IBAction func signInClicked(_ sender: Any) {
        
        if emailText.text! != "" && passwordText.text! != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) {  (authdata , error) in
                if error != nil {
                    self.makeAlert(titleInPut: "Error!", messageInPut: error?.localizedDescription ?? "Error!")
                    
                }else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                
        }
            
        }  else {
            makeAlert(titleInPut: "Error", messageInPut: " Username / Password ")
            
        }
    
    }
    
    func makeAlert (titleInPut : String , messageInPut : String) {
        let alert = UIAlertController(title:titleInPut , message: messageInPut, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    

}

