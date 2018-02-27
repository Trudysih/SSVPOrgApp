//
//  TestScrollViewController.swift
//  SSVP
//
//  Created by Trudy Sih Shu Min on 5/2/18.
//  Copyright © 2018 Trudy Sih Shu Min. All rights reserved.
//

import UIKit

class TestScrollViewController: UIViewController {

    
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
        
        var imageArray: [UIImage] = []
        
        let username = UserDefaults.standard.string(forKey: "username")
        let urlstring = "http://localhost:3000/api/listings?filter[where][username]="+username!
        
        guard let url = URL(string: urlstring) else { return  }
        
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            
            if let data = data {
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let arraylistings = json as? [Any] {
                        for arraylisting in arraylistings {
                            if let dictionary = arraylisting as? [String: Any] {
                                if let image = dictionary["image"] as? String {
                                    let dataDecoded : Data = Data(base64Encoded: image, options: .ignoreUnknownCharacters)!
                                    let decodedimage = UIImage(data: dataDecoded)
                                    
                                    imageArray.append(decodedimage!)
                                    
                                }
                            }                        }
                        
                        print (imageArray.count)
                        let myImages = imageArray
                        
                                let imageWidth:CGFloat = 250
                                let imageHeight:CGFloat = 200
                                var yPosition:CGFloat = 0
                                var scrollViewSize:CGFloat=0
                        DispatchQueue.main.async {
                                for image in myImages {
                        
                                    
                                    let myImageView:UIImageView = UIImageView()
                                    myImageView.image = image
                        
                        
                                    myImageView.frame.size.width = imageWidth
                                    myImageView.frame.size.height = imageHeight
                                    myImageView.frame.origin.x = 0
                                    myImageView.frame.origin.y = yPosition
                        
                                    self.scrollView.addSubview(myImageView)
                                    self.scrollView.showsHorizontalScrollIndicator = false
                                    yPosition += imageHeight
                                    scrollViewSize += imageHeight
                                }
                        self.scrollView.contentSize = CGSize(width: imageWidth, height: scrollViewSize)
                        }
                    }
                    
                    
                } catch {
                    print(error)
                }
                
            }
            }.resume()
        
    }
//    func setScrollView(myImages: [UIImage]) {
//        let myImages = myImages
//        self.image1.image = myImages[0]
//        self.image2.image = myImages[1]
        
//        let imageWidth:CGFloat = 66
//        let imageHeight:CGFloat = 66
//        var yPosition:CGFloat = 0
//        var scrollViewSize:CGFloat=0
        
//        for image in myImages {
        
//            let myImageView:UIImageView = UIImageView()
//            myImageView.image = image
//
//
//            myImageView.frame.size.width = imageWidth
//            myImageView.frame.size.height = imageHeight
//            myImageView.frame.origin.x = 0
//            myImageView.frame.origin.y = yPosition
//
//            scrollView.addSubview(myImageView)
//            scrollView.showsHorizontalScrollIndicator = false
//            yPosition += imageHeight
//            scrollViewSize += imageHeight
//        }
//        scrollView.contentSize = CGSize(width: imageWidth, height: scrollViewSize)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
