//
//  FirstViewController.swift
//  Camareros
//
//  Created by aleluis burguerMan on 26/1/18.
//  Copyright © 2018 aleluis burguerMan. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var etPass: UITextField!
    @IBOutlet weak var etUser: UITextField!
    @IBOutlet weak var bComprobar: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        bComprobar.isEnabled=false;
        //image

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func comprobar(_ sender: Any) {
        if ((etPass.text?.isEmpty)! || (etUser.text?.isEmpty)!){
            
        }else{lee()}
    }
    @IBAction func bAccept(_ sender: Any) {
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "data")
        self.present(viewController,animated: true, completion:nil)
        
    }
    func lee() {
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://192.168.1.139/restabar/querys/swiftCamarero.php")! as URL)
        request.httpMethod = "POST"
        
        
        let postString = ""
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            //  print("response = \(response)")
            
            //    let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            //   print("responseString = \(responseString)")
            self.parseJSON(data!)
        }
        task.resume()
        
        
        
    }
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        for i in 0 ..< jsonResult.count{
            
            jsonElement = jsonResult[i] as! NSDictionary
            //the following insures none of the JsonElement values are nil through optional binding
            if let cnom = jsonElement["cnomcam"] as? String,
                let pass = jsonElement["cpasscam"] as? String{
                if (cnom==etUser.text && pass==etPass.text) {
                    bComprobar.isEnabled=true;
                    print(cnom)
                }
            }
            
         
            
            
            
        }
        
        // en locations tenemos el resulado de la select
        print(locations)
    }

}

