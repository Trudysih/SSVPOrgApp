//
//  ViewController.swift
//  SSVPOrg
//
//  Created by Trudy Sih Shu Min on 7/2/18.
//  Copyright © 2018 Trudy Sih Shu Min. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate{
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    

    



    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createImageArray()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createImageArray() {
        
        let urlstring = "http://localhost:3000/api/listings?filter[where][accepted]=no"
        
        guard let url = URL(string: urlstring) else { return  }
        
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            
            if let data = data {
                do {
                    let imageWidth:CGFloat = 250
                    let imageHeight:CGFloat = 200
                    var yPosition:CGFloat = 0
                    var scrollViewSize:CGFloat=0
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let arraylistings = json as? [Any] {
                        for arraylisting in arraylistings {
                            if let dictionary = arraylisting as? [String: Any] {
                                
                                var myDescription : String = "nil"
                                var myUsername : String = "nil"
                                var myAddress : String = "nil"
                                var myPickup : String = "nil"
                                var myImage : String = "nil"
                                var myId : String = "nil"
                                var myNumber : String = "nil"

                                
                            
                                
                                if let image = dictionary["image"] as? String {
                                    myImage = image
                                    let dataDecoded : Data = Data(base64Encoded: image, options: .ignoreUnknownCharacters)!
                                    let decodedimage = UIImage(data: dataDecoded)
                                    
                                    
                                    
                                    DispatchQueue.main.async {
                                        
                                            let myImageView:UIImageView = UIImageView()
                                            myImageView.image = decodedimage
                                            
                                            
                                            myImageView.frame.size.width = imageWidth
                                            myImageView.frame.size.height = imageHeight
                                            myImageView.frame.origin.x = 0
                                            myImageView.frame.origin.y = yPosition
                                            
                                            self.scrollView.addSubview(myImageView)
                                            self.scrollView.showsHorizontalScrollIndicator = false
                                            yPosition += imageHeight
                                            scrollViewSize += imageHeight
                                        
                                        self.scrollView.contentSize = CGSize(width: imageWidth, height: scrollViewSize)
                                        
                                        
                                    }
                                    
                                }
                                
                                if let id = dictionary["id"] as? String {
                                   myId = id
                                }
                                if let pickup = dictionary["pickup"] as? String {
                                    myPickup = pickup
                                }
                                if let description = dictionary["description"] as? String {
                                    myDescription = description
                                }
                               
                                
                                if let username = dictionary["username"] as? String {
                                    myUsername = username

                                    DispatchQueue.main.async {
                                    let myLabel:UILabel = UILabel(frame: CGRect(x: 0, y: yPosition, width: 250, height: 21))
                                    
                                    myLabel.text = username
                                   
                                    self.scrollView.addSubview(myLabel)
                                    self.scrollView.showsHorizontalScrollIndicator = false
                                    yPosition += 21
                                    scrollViewSize += 21
                                    
                                    self.scrollView.contentSize = CGSize(width: imageWidth, height: scrollViewSize)
                                    }
                                    
                                }
                                
                                
                                if let number = dictionary["number"] as? String {
                                    myNumber = number
                                    
                                    DispatchQueue.main.async {
                                        let myLabel:UILabel = UILabel(frame: CGRect(x: 0, y: yPosition, width: 250, height: 21))
                                        
                                        myLabel.text = number
                                        
                                        self.scrollView.addSubview(myLabel)
                                        self.scrollView.showsHorizontalScrollIndicator = false
                                        yPosition += 21
                                        scrollViewSize += 21
                                        
                                        self.scrollView.contentSize = CGSize(width: imageWidth, height: scrollViewSize)
                                    }
                                }
                                
                                
                                
                                
                                
                                if let address = dictionary["address"] as? String {
                                    myAddress = address
                                    
                                    DispatchQueue.main.async {
                                        let myLabel:UILabel = UILabel(frame: CGRect(x: 0, y: yPosition, width: 250, height: 21))
                                        
                                        myLabel.text = address
                                        
                                        
                                        self.scrollView.addSubview(myLabel)
                                        self.scrollView.showsHorizontalScrollIndicator = false
                                        yPosition += 21
                                        scrollViewSize += 21
                                        
                                        self.scrollView.contentSize = CGSize(width: imageWidth, height: scrollViewSize)
                                        
                        
                                    }
                                }
                                
                                DispatchQueue.main.async {
                                    
                                    
                                    let acceptButton:SubclassButton = SubclassButton()
                                    let buttonHeight:CGFloat = 30
                                    
                                    acceptButton.frame = CGRect(x: 0, y: yPosition, width:250, height: buttonHeight)
                                    acceptButton.setTitle("Accept", for:[])
                                    acceptButton.setTitleColor(UIColor.white, for: [])
                                    acceptButton.backgroundColor = UIColor.blue
                                    
                                    acceptButton.addTarget(self,action:#selector(self.buttonAccept), for: .touchUpInside)
                                    
                                    acceptButton.username = myUsername
                                    acceptButton.image = myImage
                                    acceptButton.id = myId
                                    acceptButton.address = myAddress
                                    acceptButton.pickup = myPickup
                                    acceptButton.imageDescription = myDescription
                                    acceptButton.number = myNumber

                                    
                                    self.scrollView.addSubview(acceptButton)
                                    self.scrollView.showsHorizontalScrollIndicator = false
                                    yPosition += buttonHeight + 1
                                    scrollViewSize += buttonHeight + 1
                                    
                                    self.scrollView.contentSize = CGSize(width: imageWidth, height: scrollViewSize)
                                }
                                DispatchQueue.main.async {
                                    
                                    
                                    let rejButton:SubclassButton = SubclassButton()
                                    let buttonHeight:CGFloat = 30
                                    
                                    rejButton.frame = CGRect(x: 0, y: yPosition, width:250, height: buttonHeight)
                                    rejButton.setTitle("Reject", for:[])
                                    rejButton.setTitleColor(UIColor.white, for: [])
                                    rejButton.backgroundColor = UIColor.blue
                                    
                                    rejButton.addTarget(self,action:#selector(self.buttonReject), for: .touchUpInside)
                                    
                                    rejButton.username = myUsername
                                    rejButton.image = myImage
                                    rejButton.id = myId
                                    rejButton.address = myAddress
                                    rejButton.pickup = myPickup
                                    rejButton.imageDescription = myDescription
                                    rejButton.number = myNumber
                                    
                                    self.scrollView.addSubview(rejButton)
                                    self.scrollView.showsHorizontalScrollIndicator = false
                                    yPosition += buttonHeight + 10
                                    scrollViewSize += buttonHeight + 10
                                    
                                    self.scrollView.contentSize = CGSize(width: imageWidth, height: scrollViewSize)
                                }
           
                                
                            }
                            

                        }
                        
                        

                    }
                    
                    
                } catch {
                    print(error)
                }
                
            }
            }.resume()
        
    }
    

    

    @objc func buttonAccept (sender:SubclassButton!) {
        
        var username:String
        username = sender.username!
        var address : String
        address = sender.address!
        var pickup : String
        pickup = sender.pickup!
        var image : String
        image = sender.image!
        var id : String
        id = sender.id!
        var imageDescription : String
        imageDescription = sender.imageDescription!
        var number : String
        number = sender.number!


        let parameters = ["image": image, "description": imageDescription, "pickup": pickup, "username":username,"address":address, "accepted": "yes", "number": number]
        
        var urlstring = "http://localhost:3000/api/listings/" + id + "/replace"
        guard let url = URL(string:  urlstring) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            
            }.resume()
        
        if MFMessageComposeViewController.canSendText()
        {
            let controller = MFMessageComposeViewController()
            controller.body = "Hi thank you for your donation, we would love to accept it."
            controller.recipients = [number]
            controller.messageComposeDelegate = self
            self.present(controller,animated: true, completion: nil)
        }
}
    
    @objc func buttonReject (sender:SubclassButton!) {
        
        var username:String
        username = sender.username!
        var address : String
        address = sender.address!
        var pickup : String
        pickup = sender.pickup!
        var image : String
        image = sender.image!
        var id : String
        id = sender.id!
        var imageDescription : String
        imageDescription = sender.imageDescription!
        var number : String
        number = sender.number!
        
        
        let parameters = ["image": image, "description": imageDescription, "pickup": pickup, "username":username,"address":address, "accepted": "rejected","number": number]
        
        var urlstring = "http://ssvp.herokuapp.com/api/listings/" + id + "/replace"
        guard let url = URL(string:  urlstring) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    }
//
///*
// // MARK: - Navigation
//
// // In a storyboard-based application, you will often want to do a little preparation before navigation
// override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
// // Get the new view controller using segue.destinationViewController.
// // Pass the selected object to the new view controller.
// }
// */

}
