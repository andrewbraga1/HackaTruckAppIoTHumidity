//
//  ViewController.swift
//  AppIotHumidity
//
//  Created by student on 24/05/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var humidityValue: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.humidityValue.text = String(0)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func mainHumidityButton(_ sender: UIButton) {
        let endpoint: String = "https://iotprot1.mybluemix.net/getdata"
        guard let url = URL(string: endpoint) else {
            print("Erroooo: Cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            if error != nil {
                print("Error = \(String(describing: error))")
                return
            }
            
            let responseString = String(data: data!, encoding: String.Encoding.utf8)
            print("responseString = \(String(describing: responseString))")
            
            DispatchQueue.main.async() {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: AnyObject]] {
                        
                        let umidade = json[json.count-1]
                        //let umidadeSelect = umidade.first?
                        let umidadeValue = umidade["payload"]
                        //sleep(5)
                        //print(umidadeValue)
                        self.humidityValue.text = (umidadeValue) as? String
                        
                      
                        
                    }else {
                        
                        print("fudeuuuu")
                    }
                } catch let error as NSError {
                    print("Error = \(error.localizedDescription)")
                }
            }
            
            
        })
        
        task.resume()
    }

}

