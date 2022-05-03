//
//  SettingsViewController.swift
//  instaCloneFirebase
//
//  Created by Asilcan Çetinkaya on 21.03.2022.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        
        do{
        try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
            
            
        } catch {
            print("Error")
    
    

}
    
    }
}
