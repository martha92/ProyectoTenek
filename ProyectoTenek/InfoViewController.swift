//
//  InfoViewController.swift
//  ProyectoTenek
//
//  Created by Martha Garcia Contreras on 11/05/15.
//  Copyright (c) 2015 Martha Garcia Contreras. All rights reserved.
//

import UIKit
class InfoViewController: UIViewController, NSXMLParserDelegate, LoginViewControllerProtocol {
    
    var login:LoginViewController!
    var numEmpleado : String = ""
    @IBOutlet var txtNumEmp: UITextField!
    @IBOutlet var txtNombre: UITextField!
    @IBOutlet var txtPerfil: UITextField!
    @IBOutlet var txtPuesto: UITextField!
    @IBOutlet var txtDireccion: UITextField!
    @IBOutlet var txtIdMensajeria: UITextField!
    @IBOutlet var txtTelefono: UITextField!
    @IBOutlet var txtCorreo: UITextField!
    @IBOutlet var txtFechaNac: UITextField!
    func setData(controller: LoginViewController, text: String) {
        numEmpleado = text;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.login = LoginViewController()
        self.login.delegate = self
        println("SOY EL NUM EMPLEADO" + numEmpleado)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        [self.cargaInfoEmpleado()]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var mutableData:NSMutableData  = NSMutableData.alloc()
    var currentElementName = ""
    var timer = NSTimer()
    var connection = NSURLConnection()
    var transicion:Bool = false;
    func cargaInfoEmpleado(){
        var soapMessage = "<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><TraeEmpleado xmlns='http://tempuri.org/'><numeroEmpleado>\(numEmpleado)</numeroEmpleado></TraeEmpleado></soap:Body></soap:Envelope>"
        let urlString:String = "http://servicios.tenek.biz/Services.asmx?op=TraeEmpleado"
        var url: NSURL = NSURL(string: urlString)!
        var theRequest = NSMutableURLRequest(URL: url)
        var msgLength = String(count(soapMessage))
        theRequest.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        theRequest.addValue(msgLength, forHTTPHeaderField: "Content-Length")
        theRequest.HTTPMethod = "POST"
        theRequest.HTTPBody = soapMessage.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) // or false
        
        
        connection = NSURLConnection(request: theRequest, delegate: self, startImmediately: true)!
        connection.start()
        
        if (connection == true) {
            var mutableData : Void = NSMutableData.initialize()
        }

    }
    
    func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        mutableData.length = 0;
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        mutableData.appendData(data)
        
    }
    
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        var xmlParser = NSXMLParser(data: mutableData)
        xmlParser.delegate = self
        xmlParser.parse()
        xmlParser.shouldResolveExternalEntities = true
        
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        currentElementName = elementName
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        if (currentElementName == "NumeroEmpleado"){
            if (string != nil){
                self.txtNumEmp.text = string
            }
        }
        else if (currentElementName == "ApellidosEmpleado"){
            if (string != nil){
                self.txtNombre.text = string
            }
        }
        else if (currentElementName == "NombresEmpleado"){
            if (string != nil){
                self.txtNombre.text = string! + " " + self.txtNombre.text
            }
            
        }
        else if (currentElementName == "FechaNacimiento"){
            if (string != nil){
                var dateFormatter = NSDateFormatter()
                dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
                var date = dateFormatter.dateFromString(string!)
                println(date)
                self.txtFechaNac.text = string
            }
        }
        else if (currentElementName  == "Direccion"){
            if (string != nil){
                self.txtDireccion.text = string
            }
        }
        else if (currentElementName == "Correo"){
            if (string != nil){
                self.txtCorreo.text = string
            }
        }
        else if (currentElementName == "Telefono"){
            if (string != nil){
                self.txtTelefono.text = string
            }
        }
        else if (currentElementName == "Mensajeria"){
            if (string != nil){
                self.txtIdMensajeria.text = string
            }
        }
        else if (currentElementName == "Perfil"){
            if (string != nil){
                self.txtPerfil.text = string
            }
        }
        else if (currentElementName == "Puesto"){
            if (string != nil){
                self.txtPuesto.text = string
            }
        }
        
        transicion = true;
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if (!transicion){
            return false;
        }
        
        return true;
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
