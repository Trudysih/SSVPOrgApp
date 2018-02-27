//
//  DonationImageViewController.swift
//  SSVP
//
//  Created by Trudy Sih Shu Min on 17/1/18.
//  Copyright © 2018 Trudy Sih Shu Min. All rights reserved.
//

import UIKit

class DonationImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var testImage: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemDescription: UITextField!
    var imageString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func chooseImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: " Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title:"Camera",style: .default,handler: {(action: UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController,animated: true, completion: nil)
            }else {
                print ("Camera not available")
            }
        }))
        
        
        actionSheet.addAction(UIAlertAction(title:"Photo Library",style: .default,handler: {(action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController,animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title:"Cancel",style: .cancel,handler: nil))
        
        self.present(actionSheet,animated: true,completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        self.uploadImage(image: image)
        picker.dismiss(animated: true, completion: nil)

        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:true, completion: nil)
    }
    
    
    
    func uploadImage(image: UIImage) {
        
        let imageData:NSData = UIImagePNGRepresentation(image.resized(withPercentage: 0.04)!)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        //uploadImageHttp(imageString: strBase64)
        self.imageString = strBase64
    }

//    func uploadImageHttp(imageString : String) {
//
//        let parameters = ["image": imageString, "description": "a", "pickup": "a", "username":"a","address":"a"]
//
//            guard let url = URL(string: "http://localhost:3000/api/listings") else { return }
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
//            request.httpBody = httpBody
//        
//            let session = URLSession.shared
//            session.dataTask(with: request) { (data, response, error) in
//                if let response = response {
//                    print(response)
//                }
//                
//                if let data = data {
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: [])
//                        print(json)
//                    } catch {
//                        print(error)
//                    }
//                }
//                
//                }.resume()
//            
//    }
    

    
    @IBAction func StoreDescription(_ sender: Any) {
        
        let description = itemDescription.text
        let image = imageString
        
        let preferences = UserDefaults.standard
        preferences.set(description, forKey: "description")
        preferences.set(image, forKey: "image")


    }
    //    @IBAction func GoBack(_ sender: Any) {
//        
//        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
//        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        
//        appDelegate.window?.rootViewController = secondViewController
//    }
    
   
    
}

