//
//  SecondViewController.swift
//  Camareros
//
//  Created by aleluis burguerMan on 26/1/18.
//  Copyright © 2018 aleluis burguerMan. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource{
    //variables
    @IBOutlet weak var pickerPuestos: UIPickerView!
    @IBOutlet weak var etNombre: UITextField!
    @IBOutlet weak var etTelefono: UITextField!
    @IBOutlet weak var etCorreo: UITextField!
    @IBOutlet weak var etPass: UITextField!
    @IBOutlet weak var etCod: UITextField!
    
    var nombre=""
    var tlfno=""
    var correo=""
    var pass=""
    var puesto=""
    var cod=""
    var message=""
    //fin variables
    var pickerDatos = ["Barra", "Terraza", "Mesas"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.pickerPuestos.dataSource=self
        self.pickerPuestos.delegate=self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDatos.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDatos[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("elemento seleccionado: " + pickerDatos[row])
        puesto = pickerDatos[row]   //obtiene el puesto
    }
    //eventos
    @IBAction func actionInsert(_ sender: Any) {
        nombre = etNombre.text!
        tlfno = etTelefono.text!
        correo = etCorreo.text!
        pass = etPass.text!
        cod = etCod.text!
        insertarEnBD()
    }
    
    @IBAction func actionClean(_ sender: Any) {
        etNombre.text=""
        etTelefono.text=""
        etCorreo.text=""
        etPass.text=""
        etCod.text=""
    }
    
    func insertarEnBD() {
        let request = NSMutableURLRequest(url: NSURL(string: "http://192.168.1.139/restabar/querys/swiftInsertCamarero.php")! as URL)
        request.httpMethod="POST"
        
        let postString = "codcam=\(cod)&cnomcam=\(nombre)&cpuesto=\(puesto)&tfno=\(tlfno)&ccorreo=\(correo)&cpasscam=\(pass)"
        
        print(postString)
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                self.message = "Error 1"
                return
            }
            print("response =\(response)")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            if ((responseString?.isEqual(to: "1")))! {
                self.message = "Añadido"
                
            }
            else {
                self.message = "Error al añadir"
                
            }
            
            print("responseString = \(responseString)")
        }
        
        task.resume()
        let alert = UIAlertController(title: "Insertado!!!!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        
        
        print("ffff \(self.message)")
    }
    
    
}//fin de clase

