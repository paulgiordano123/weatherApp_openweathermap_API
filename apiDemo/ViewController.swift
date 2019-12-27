//
//  ViewController.swift
//  apiDemo
//
//  Created by paulgiordano on 12/26/19.
//  Copyright © 2019 paulgiordano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cityTextField: UITextField!
    
    @IBAction func submit(_ sender: AnyObject) {
        
        // Do any additional setup after loading the view.
        
        print(cityTextField.text)
        
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=" + cityTextField.text! + "&appid=1ff07de74f2a657d3bf1d135f2d47ef8") {
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if error != nil {
                
                print(error)
                
            } else {
        
                if let urlContent = data {
                    
                    do {
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                                    
                        print(jsonResult)
                        print(jsonResult["name"])
                        
                        if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                            
                            DispatchQueue.main.sync {
                                self.resultLabel.text = description
                                
                            }
                        }
                        
                    } catch {
                        
                        print("there was an error")
                    }
                    
                }
                
            }
            
        }
        task.resume()
        
        } else {
            
            resultLabel.text = "Could not find the weather for the city entered"
        }
        
    }
    
    @IBOutlet var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

