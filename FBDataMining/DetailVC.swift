//
//  DetailVC.swift
//  FBDataMining
//
//  Created by Mohsin on 16/09/2015.
//  Copyright (c) 2015 Mohsin. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    

    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var txtView: UITextView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var selectedPage = ("","","")
    var pageUrl : NSURL!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lblDesc.text = "\(self.selectedPage.1)\n\(self.selectedPage.0)\n \(self.selectedPage.2)"
        
        self.pageUrl = NSURL(string: "https://facebook.com/pages/-/\(self.selectedPage.0)?sk=app_973079729379918")
        var error : NSError?
    
        
        // make a another thread for update the thumb image
        let priority = DISPATCH_QUEUE_PRIORITY_BACKGROUND
        dispatch_async(dispatch_get_global_queue(priority, 0)){
            // background thread
            let myHTMLString = String(contentsOfURL: self.pageUrl, encoding: NSUTF8StringEncoding, error: &error)
            
        
            dispatch_sync(dispatch_get_main_queue()) {
                // main thread
                
                if let error = error {
                    println("Error : \(error)")
                    self.txtView.text = error.localizedDescription
                } else {
                    println("HTML : \(myHTMLString)")
                    self.txtView.text = myHTMLString
                }
                self.activityIndicator.stopAnimating()
                
            }
        }

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

    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
