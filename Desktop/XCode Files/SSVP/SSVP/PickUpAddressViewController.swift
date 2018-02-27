//
//  PickUpAddressViewController.swift
//  SSVP
//
//  Created by Trudy Sih Shu Min on 1/2/18.
//  Copyright © 2018 Trudy Sih Shu Min. All rights reserved.
//

import UIKit

class PickUpAddressViewController: UIViewController {

    @IBOutlet weak var pickupAddress: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func ConfirmPickup(_ sender: Any) {
        
        let number = UserDefaults.standard.string(forKey: "number")
        let address = pickupAddress.text
        let pickup = "yes"
        let accepted = "no"
        let description = UserDefaults.standard.string(forKey: "description")
        let image = UserDefaults.standard.string(forKey: "image")
        let username = UserDefaults.standard.string(forKey: "username")
        uploadImageHttp(imageString : image!, address: address!,description:description!,  pickup: pickup, username:username!, accepted: accepted, number: number! )
        
    }
    
    func uploadImageHttp(imageString : String, address : String, description: String,pickup: String, username: String, accepted: String, number: String) {
        
        let parameters = ["image": imageString, "description": description, "pickup": pickup, "username":username,"address":address, "accepted": accepted, "number" : number]
        
        guard let url = URL(string: "http://localhost:3000/api/listings") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
