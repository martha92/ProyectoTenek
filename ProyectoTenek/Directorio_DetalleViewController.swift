//
//  Directorio_DetalleViewController.swift
//  ProyectoTenek
//
//  Created by Martha Garcia Contreras on 11/05/15.
//  Copyright (c) 2015 Martha Garcia Contreras. All rights reserved.
//

import UIKit

class Directorio_DetalleViewController: UIViewController {
    var correo : String?
    var ext : String?
    var puesto : String?
    var nombre : String?
    var nombreDepto : String?

    @IBOutlet var lblNomDepto: UILabel!
    @IBOutlet var lblCorreo: UILabel!
    @IBOutlet var lblExtension: UILabel!
    @IBOutlet var lblPuesto: UILabel!
    @IBOutlet var lblNombre: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblCorreo.text = correo
        self.lblNomDepto.text = nombreDepto
        self.lblNombre.text = nombre
        self.lblPuesto.text = "Manager"
        self.lblExtension.text = ext
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
