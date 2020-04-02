//
//  ViewController.swift
//  quote with image
//
//  Created by grandmaster on 02/04/2020.
//  Copyright © 2020 istedik. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImg: UIImageView!
    
    @IBOutlet weak var quoteTextview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        backgroundImg.alpha = 0.6
        quoteTextview.backgroundColor = .clear
        quoteTextview.isEditable = false
        randomImage()
    }

    @IBAction func changeButtonPressed(_ sender: Any) {
          loadData(urlString: "https://api.kanye.rest")
    }
    
    
    public func loadData(urlString: String)
      {
          
          var url = URL(string: urlString)
          
          
          
          let task = URLSession.shared.dataTask(with: url!) {
              (data , response , error) in
              
              
              if error != nil
              {
                  print(error!)
                  
              }else{
                  
                  do{
                      
                     let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                        
                        print("json : \(json)")
                            // try to read out a string array
                            let quote = json["quote"] as? String
                    print("quote : \(String(describing: quote))")
                            
                    
                    DispatchQueue.main.async {
                        
                        self.quoteTextview.text = quote
                        
                        let titleColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
                        self.quoteTextview.doShadowText(color: titleColor, radius: 3, opacity: 0.25)
                        
                        self.randomImage()
                         
                    }
                    
                    
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                     
                       
              }
              
              
          }
          task.resume()
          
      }//
    
    
    func randomImage() {
    let loremPicsumURL = [ "https://picsum.photos/200/300?random=1?blur=5",
        "https://picsum.photos/seed/picsum/200/300"
        ]
         
        self.backgroundImg.sd_setImage(with: URL(string: loremPicsumURL.randomElement()!), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    
}
extension UITextView {
       func doShadowText(color: UIColor , radius: CGFloat, opacity: Float){
           self.textColor = color
           self.layer.masksToBounds = false
           self.layer.shadowRadius = radius
           self.layer.shadowOpacity = opacity

           self.layer.shadowOffset = CGSize(width: 1, height: 1)
           self.layer.shouldRasterize = true
           self.layer.rasterizationScale = UIScreen.main.scale
       }
   }

