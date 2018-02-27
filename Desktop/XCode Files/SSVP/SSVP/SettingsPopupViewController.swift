//
//  SettingsPopupViewController.swift
//  SSVP
//
//  Created by Trudy Sih Shu Min on 29/1/18.
//  Copyright © 2018 Trudy Sih Shu Min. All rights reserved.
//

import UIKit

class SettingsPopupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logOut(_ sender: Any) {
        //remove login details
        let preferences = UserDefaults.standard
        preferences.removeObject(forKey: "username")
        
        //change to log in page
        let signinViewController = self.storyboard?.instantiateViewController(withIdentifier: "SigninViewController") as! SigninViewController
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = signinViewController
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
