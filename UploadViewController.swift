//
//  UploadViewController.swift
//  instaCloneFirebase
//
//  Created by Asilcan Çetinkaya on 21.03.2022.
//

import UIKit
import Firebase
import SwiftUI

class UploadViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectImage.isUserInteractionEnabled = true
        let imageTabRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickedImage))
        selectImage.addGestureRecognizer(imageTabRecognizer)
        

        
    }
    
    func makeAlert (titleInPut : String , messageInPut : String) {
        let alert = UIAlertController(title: titleInPut, message: messageInPut, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func clickedImage () {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = selectImage.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid=UUID().uuidString
            
            let imageReference  = mediaFolder.child("\(uuid).jpeg")
            imageReference.putData(data , metadata :  nil){(data , error )in
                if error != nil {
                    self.makeAlert(titleInPut: "Error", messageInPut: error?.localizedDescription ?? "Error" )
                }else {
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            print(imageUrl)
                            
                            
                            
                            //DATABASE
                            
                        let firestoreDatabase = Firestore.firestore()
                                                        
                        var firestoreReference : DocumentReference? = nil
                                                        
                        let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email!, "postComment" : self.commentText.text!,"date" : FieldValue.serverTimestamp(), "likes" : 0 ] as [String : Any]

                        firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                        if error != nil {
                                                                
                            self.makeAlert(titleInPut: "Error!", messageInPut: error?.localizedDescription ?? "Error")
                                                                
                        } else {
                                                                
                        self.selectImage.image = UIImage(named: "select.png")
                        self.commentText.text = ""
                        self.tabBarController?.selectedIndex = 0
                                                                
                                }
                                                            
                            })
                                                        
                                                        
                         }
                                                    
                                                    
                    }
                                                
                }
                
            }
                                        
        }
                                    
    }
                                
}
    
