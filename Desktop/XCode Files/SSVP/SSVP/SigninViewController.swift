//
//  SigninViewController.swift
//  SSVP
//
//  Created by Trudy Sih Shu Min on 16/1/18.
//  Copyright © 2018 Trudy Sih Shu Min. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var _username: UITextField!
    @IBOutlet var _password: UITextField!
    @IBOutlet var _login_button: UIButton!
    
    
           
    

    
    
    
    override func viewDidLoad() {
        
        self._password.delegate = self
        
        let preferences = UserDefaults.standard

        
        if(preferences.object(forKey: "username") != nil)
        {
            LoginDone()
        }
        else
        {
            LoginToDo()
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _password.resignFirstResponder()
        return(true)
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        
        
        
        
        let username = _username.text
        let password = _password.text
        
        if(username == "" || password == "")
        {
            return
        }
        
    
        let urlstring = "http://localhost:3000/api/users?filter[where][username]="+username!+"&filter[where][password]=" + password!
        
        guard let url = URL(string: urlstring) else { return }
        
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                    if((json as AnyObject).count == 1){
                        self.DoLogin(username: username!)
                    }
                    
                    
                } catch {
                    print(error)
                }
                
            }
            }.resume()
        
        
        
        
        //DoLogin(username!, password!)
    }
    
    
    func DoLogin(username: String)
    {
        let urlstring = "http://localhost:3000/api/users?filter[where][username]=" + username
        
        guard let url = URL(string: urlstring) else { return  }
        
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let arraylistings = json as? [Any] {
                        for arraylisting in arraylistings {
                            if let dictionary = arraylisting as? [String: Any] {
                                
                                
                                if let number = dictionary["number"] as? String {
                                    let preferences = UserDefaults.standard
                                    preferences.set(number, forKey: "number")
                                    
                                }
                                
                            }
                        }
                    }
                    
                    
                    
                } catch {
                    print(error)
                }
                
            }
            }.resume()
            let preferences = UserDefaults.standard
            preferences.set(username, forKey: "username")
            
            DispatchQueue.main.async (
                execute:self.LoginDone
            )
        
    }
    
    
    func LoginToDo()
    {
        _username.isEnabled = true
        _password.isEnabled = true
        
    }
    
    func LoginDone()
    {
        
        let myTabBar = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = myTabBar
    }
    
    
   
    
    
}




