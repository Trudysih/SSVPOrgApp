//
//  RegisterViewController.swift
//  SSVP
//
//  Created by Trudy Sih Shu Min on 29/1/18.
//  Copyright © 2018 Trudy Sih Shu Min. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var firstname: UITextField!
    
    @IBOutlet weak var lastname: UITextField!
    
    @IBOutlet weak var number: UITextField!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Register(_ sender: Any) {
        
        //check if username already taken
        
        let username = self.username.text
        
        
        let urlstring = "http://localhost:3000/api/users?filter[where][username]="+username!
        
        guard let url = URL(string: urlstring) else { return }
        
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    print ((json as AnyObject).count)
                    let count = (json as AnyObject).count
                    if count == 0 {
                        self.createUserAccount()
                    }
                    else {
                        DispatchQueue.main.async(execute: {() -> Void in
                            let alert = UIAlertController(title: "Username Taken", message: "Please chose another username", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)
                            }))
                            self.present(alert, animated: true, completion: nil)

                        })
                    }
                
                } catch {
                    print(error)
                }
                
            }
            }.resume()
        
        
        
        
    }
    
    
    
    func createUserAccount() {
        
        let parameters = ["firstname": firstname.text, "lastname": lastname.text, "number": number.text, "username":username.text,"password": password.text ]
        
        guard let url = URL(string: "http://localhost:3000/api/users") else { return }
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
