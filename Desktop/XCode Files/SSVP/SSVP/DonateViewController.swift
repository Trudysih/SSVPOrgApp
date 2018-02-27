//
//  SecondViewController.swift
//  SSVP
//
//  Created by Trudy Sih Shu Min on 19/12/17.
//  Copyright © 2017 Trudy Sih Shu Min. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Change(_ sender: Any) {
        
        let donationViewController = self.storyboard?.instantiateViewController(withIdentifier: "DonationImageViewController") as! DonationImageViewController
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = donationViewController
        
        
    }
    
}

