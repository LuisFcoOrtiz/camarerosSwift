//
//  DataCamarer.swift
//  Camareros
//
//  Created by aleluis burguerMan on 29/1/18.
//  Copyright © 2018 aleluis burguerMan. All rights reserved.
//

import Foundation

import UIKit

class DataCamarer: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var array = [String]()
    var arrayPuestos = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lee()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count//RETORNO EL NUMERO DE ELEMENTOOOOOOOOS
    }
    //EN ESTE METODO DE AQUI ABAJO COLOCAS EL TEXTO CORRESPONDIENTE EN LOS ETNOMBRE Y ETPUESTO, SI QUIERES AGREGAR ALGO MAS
    //AL DISEÑO DE CADA ITEM HAZLO
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MiCeldaCollectionViewCell
        cell.etNombre.text=array[indexPath.row]
        cell.etPuesto.text=arrayPuestos[indexPath.row]
        return cell
        
        //ese cell entre comillas
        //es el nombre que le he puesto yo a cada celda que conforma el collectionView
    }
    
    /*leer de mySQL*/
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
            
            self.parseJSON(data!)
        }
        task.resume()
        
        
        
    }
    /*-------*/
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
                let puesto = jsonElement["cpuesto"] as? String{
                //rellenar la lista
                array.append(cnom)
                arrayPuestos.append(puesto)
                
            }         
            
        }
        
        // en locations tenemos el resulado de la select
        print(locations)
    }
    /**/
    
    @IBOutlet weak var goBack: UIButton!
    @IBAction func goToBack(_ sender: Any) {
        
    }
    
}//fin de clase
