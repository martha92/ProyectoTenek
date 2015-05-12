//
//  LoginViewController.swift
//  Proyecto
//
//  Created by Martha Garcia Contreras on 11/04/15.
//  Copyright (c) 2015 Martha Garcia Contreras. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, NSXMLParserDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var txtContra: UITextField!
    @IBOutlet weak var txtNumEmp: UITextField!
    var mutableData:NSMutableData  = NSMutableData.alloc()
    var currentElementName = ""
    var timer = NSTimer()
    var connection = NSURLConnection()
    @IBAction func btnEntrarClicked(sender: UIButton) {
        if(self.txtContra.text == "" || self.txtNumEmp.text == ""){
            let alertController = UIAlertController(title: "Error!", message:
                "Debes proporcionar todos los datos", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else{
            var soapMessage = "<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><Login xmlns='http://tempuri.org/'><username>\(self.txtNumEmp.text)</username><password>\(self.txtContra.text)</password></Login></soap:Body></soap:Envelope>"
            
            let urlString:String = "http://servicios.tenek.biz/Services.asmx?op=Login"
            
            
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
        println(currentElementName)
    }
   
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        println(string)
        if currentElementName == "LoginResponse" {
            println(string)
        }
    }
    
    
      /* func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: NSDictionary!) {
    currentElementName = elementName
    }
    
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
    print("Que traaaae" + (currentElementName as String))
    /*  if currentElementName == "CelsiusToFahrenheitResult" {
    txtFahrenheit.text = string
    }
    */
    }
    */
    
    
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
