//
//  DirectorioTableViewController.swift
//  ProyectoTenek
//
//  Created by Martha Garcia Contreras on 11/05/15.
//  Copyright (c) 2015 Martha Garcia Contreras. All rights reserved.
//

import UIKit

class DirectorioTableViewController: UITableViewController, NSXMLParserDelegate {
    var nombreDepto = [AnyObject]()
    var jefeDepto = [AnyObject]()
    var telefonoDepto = [AnyObject]()
    var correoDepto = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        [self.cargaInfo()]
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewDidAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.nombreDepto.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = nombreDepto[indexPath.row] as? String
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    var mutableData:NSMutableData  = NSMutableData.alloc()
    var currentElementName : String?
    var timer = NSTimer()
    var connection = NSURLConnection()
    var transicion:Bool = false;
    func cargaInfo(){
        var soapMessage = "<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><TraeListaDirectorio xmlns='http://tempuri.org/' /></soap:Body></soap:Envelope>"
        let urlString:String = "http://servicios.tenek.biz/services.asmx?op=TraeListaDirectorio"
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
    func parserDidEndDocument(parser: NSXMLParser) {
        println (nombreDepto)
        println (jefeDepto)
        println (telefonoDepto)
        println (correoDepto)
        tableView.reloadData()
    }
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        currentElementName = elementName
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        if (currentElementName == "NombreDepartamento"){
            if (string != nil){
                nombreDepto.insert(string!, atIndex: 0)
            }
        }
        else if (currentElementName == "JefeDepartamento"){
            if (string != nil){
                jefeDepto.insert(string!, atIndex: 0)
            }
        }
        else if (currentElementName == "TelefonoDepartamento"){
            if (string != nil){
                telefonoDepto.insert(string!, atIndex: 0)
            }
            
        }
        else if (currentElementName == "CorreoDepartamento"){
            if (string != nil){
                correoDepto.insert(string!, atIndex: 0)
            }
        }
        
        transicion = true;
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            //println (index)
            var selectedRow : NSIndexPath = tableView.indexPathForSelectedRow()!
            //selectedRow : NSIndexPath = tableView.indexPathForSelectedRow()
           // NSIndexPath selectedRowIndex = [self.tableView indexPathForSelectedRow];
            var detalle = segue.destinationViewController as! Directorio_DetalleViewController
            detalle.nombreDepto = nombreDepto[selectedRow.row] as? String
            detalle.nombre = jefeDepto[selectedRow.row] as? String
            detalle.ext = telefonoDepto[selectedRow.row] as? String
            detalle.correo = correoDepto[selectedRow.row] as? String
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if (!transicion){
            return false;
        }
        
        return true;
    }

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
