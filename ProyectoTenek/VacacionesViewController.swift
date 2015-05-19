//
//  VacacionesViewController.swift
//  ProyectoTenek
//
//  Created by Martha Garcia Contreras on 11/05/15.
//  Copyright (c) 2015 Martha Garcia Contreras. All rights reserved.
//

import UIKit

class VacacionesViewController: UIViewController, NSXMLParserDelegate {
    var numEmpleado : String = ""
    var transicion:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet var txtPeriodo: UITextField!
    @IBOutlet var txtVencimiento: UITextField!
    @IBOutlet var txtPrimaVac: UITextField!
    @IBOutlet var txtDisfrutados: UITextField!
    @IBOutlet var txtDisponibles: UITextField!
    @IBOutlet var txtDiasCorr: UITextField!
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
    func cargaInfoEmpleado(){
        var soapMessage = "<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><TraeVacaciones xmlns='http://tempuri.org/'><numeroEmpleado>\(numEmpleado)</numeroEmpleado></TraeVacaciones></soap:Body></soap:Envelope>"
        let urlString:String = "http://servicios.tenek.biz/Services.asmx?op=TraeVacaciones"
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
        /*else{
            let alertController = UIAlertController(title: "Error!", message:
                "Ocurrio un error al realizar la consulta", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }*/
        
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
        if (currentElementName == "Periodo"){
            if (string != nil){
                self.txtPeriodo.text = string
            }
        }
        else if (currentElementName == "DiasCorrespondientes"){
            if (string != nil){
                self.txtDiasCorr.text = string
            }
        }
        else if (currentElementName == "DiasDisponibles"){
            if (string != nil){
                self.txtDisponibles.text = string
            }
        }
        else if (currentElementName == "DiasDisfrutados"){
            if (string != nil){
                self.txtDisfrutados.text = string
            }
        }
        else if (currentElementName == "PorcentajePrima"){
            if (string != nil){
                self.txtPrimaVac.text = string
            }
        }
        else if (currentElementName == "Vencimiento"){
            if (string != nil){
                self.txtVencimiento.text = string
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
