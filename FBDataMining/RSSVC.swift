//
//  RSSVC.swift
//  FBDataMining
//
//  Created by Mohsin on 04/10/2015.
//  Copyright (c) 2015 Mohsin. All rights reserved.
//

import UIKit

class RSSVC: UIViewController , NSXMLParserDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
                getRSS(NSURL(string: "http://ptwc.weather.gov/ptwc/feeds/ptwc_rss_indian.xml")!, { (data) -> Void in
                    println(data)
                })
        
//        let parser = NSXMLParser(contentsOfURL: NSURL(string: "http://ptwc.weather.gov/ptwc/feeds/ptwc_rss_indian.xml"))
//        parser?.delegate = self
//        parser?.parse()
        
        
        
        
    }

    func parserDidEndDocument(parser: NSXMLParser) {
        println("end")
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        println("elementName: \(elementName)")
        println("namespaceURI: \(namespaceURI)")
        println("qName: \(qName)")
        println("attributeDict: \(attributeDict)")

    }
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        println("character: \(string)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


func getRSS(url : NSURL ,complete : (data: NSString?) -> Void){
    
    
    
    //    var error : NSError?
    //
    //    let string = String(contentsOfURL: url, encoding: NSUTF8StringEncoding, error: &error)
    //    println(string)
    
    
    
    var request = NSMutableURLRequest(URL: url)
    var session = NSURLSession.sharedSession()
    var err: NSError?
    
//    request.HTTPMethod = "GET"
//
//    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    
//    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    


    

//    let task1 = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
//        
//        var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
//    println(strData)
//    })
//    task1.resume()
    
    
    
//    var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//        
//        var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
//        
//        println("Body: \(strData)")
//        
//        
//        //      if response is not found nil
//        if data != nil && strData != ""{
//            complete(data: strData)
//            
//        }
//            
//        else{
//            complete(data: nil)
//        }
//    })
//    
//    task.resume()
}