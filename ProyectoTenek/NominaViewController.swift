//
//  NominaViewController.swift
//  ProyectoTenek
//
//  Created by Martha Garcia Contreras on 11/05/15.
//  Copyright (c) 2015 Martha Garcia Contreras. All rights reserved.
//

import UIKit

class NominaViewController: UIViewController, NSXMLParserDelegate {
    var numEmpleado : String = ""
    var transicion:Bool = false
    var indice : Int = 0
    var percepciones = [AnyObject]()
    var retenciones = [AnyObject]()
    var total = [AnyObject]()
    var periodo = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        [self.cargaInfoEmpleado()]
    }

    @IBAction func btnDerechaClicked(sender: UIButton) {
        if (indice != (percepciones.count - 1)){
            indice = indice == percepciones.count ? indice : indice + 1
            self.txtPercepciones.text = percepciones[indice] as! String
            self.txtRetenciones.text = retenciones[indice] as! String
            self.txtTotal.text = total[indice] as! String
            self.txtPeriodo.text = periodo[indice] as! String
        }
    }
    
    @IBAction func btnIzquierdaClicked(sender: UIButton) {
        if (indice >= 0){
            indice = indice == 0 ? indice : indice - 1
            self.txtPercepciones.text = percepciones[indice] as! String
            self.txtRetenciones.text = retenciones[indice] as! String
            self.txtTotal.text = total[indice] as! String
            self.txtPeriodo.text = periodo[indice] as! String
        }
        
    }
    @IBOutlet var txtTotal: UITextField!
    @IBOutlet var txtRetenciones: UITextField!
    @IBOutlet var txtPercepciones: UITextField!
    @IBOutlet var txtPeriodo: UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var mutableData:NSMutableData  = NSMutableData.alloc()
    var currentElementName = ""
    var timer = NSTimer()
    var connection = NSURLConnection()
    func cargaInfoEmpleado(){
        var soapMessage = "<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><TraeNomina xmlns='http://tempuri.org/'><numeroEmpleado>\(numEmpleado)</numeroEmpleado></TraeNomina></soap:Body></soap:Envelope>"
        let urlString:String = "http://servicios.tenek.biz/services.asmx?op=TraeNomina"
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
    
    func parserDidEndDocument(parser: NSXMLParser) {
        println (percepciones)
        println (retenciones)
        println (total)
        indice = (percepciones.count) - 1
        println (periodo)
    }
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        if (currentElementName == "Percepciones"){
            if (string != nil){
                self.txtPercepciones.text = string
                percepciones.insert(string!, atIndex: 0)
            }
        }
        else if (currentElementName == "Retenciones"){
            if (string != nil){
                self.txtRetenciones.text = string
                retenciones.insert(string!, atIndex: 0)
            }
        }
        else if (currentElementName == "Total"){
            if (string != nil){
                self.txtTotal.text = string
                total.insert(string!, atIndex: 0)
            }
        }
        else if (currentElementName == "periodo"){
            if (string != nil){
                self.txtPeriodo.text = string
                periodo.insert(string!, atIndex: 0)
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
