//
//  ViewController.swift
//  FBDataMining
//
//  Created by Mohsin on 16/09/2015.
//  Copyright (c) 2015 Mohsin. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit



var globleUser : User?

class ViewController: UIViewController, FBSDKLoginButtonDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var tableVIew: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    
    var logingBtn : FBSDKLoginButton!
    var likesPages = [(String,String,String)]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.logingBtn = FBSDKLoginButton()
        self.logingBtn.delegate = self
        self.logingBtn.readPermissions = ["public_profile","email","user_friends","user_likes"]

        logingBtn.center = self.view.center
        logingBtn.frame.origin.y += 400
        self.view.addSubview(logingBtn)
        
        
        if (FBSDKAccessToken.currentAccessToken() == nil)
        {
            println("user logout")
        }
        else{
            println("user login")
            FBRetriveData.getUserBasicInfoFromFB({ (myUser, errorDesc) -> Void in
                if myUser != nil {
                    myUser!.desc()
                    globleUser = myUser
                    self.addInTextView(globleUser?.name)
                    self.addInTextView(globleUser?.fbId)
                    
                    //
                    FBRetriveData.getUserLikes(globleUser!, complete: { (result) -> Void in
                        var dic = result as? NSDictionary
                        self.addInTextView(dic?.description)
                        self.loadUserGroups(dic!)
                    })
                    FBRetriveData.getUserFullInfo(globleUser!, complete: { (result) -> Void in
                        
                        var dic = result as? NSDictionary
                        self.addInTextView(dic?.description)
                    })
                }
            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    // facebook
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            FBRetriveData.getUserBasicInfoFromFB({ (myUser, errorDesc) -> Void in
                if myUser != nil {
                    myUser!.desc()
                    
                    globleUser = myUser
                    self.addInTextView(globleUser?.name)
                    self.addInTextView(globleUser?.fbId)
                    
                    //
                    FBRetriveData.getUserLikes(globleUser!, complete: { (result) -> Void in
                        var dic = result as? NSDictionary
                        self.addInTextView(dic?.description)
                        self.loadUserGroups(dic!)
                    })
                    FBRetriveData.getUserFullInfo(globleUser!, complete: { (result) -> Void in
                        var dic = result as? NSDictionary
                        self.addInTextView(dic?.description)
                    })
                }
            })
            
            println("fb login")

        }
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")

    }
    
    
    
    
    
    // table view func_s
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.likesPages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = self.likesPages[indexPath.row].1
        
        return cell
        
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showDetail", sender: self)
    }
    
    
    
    
    
    
    
    func loadUserGroups(data : NSDictionary){
        
        let jsonArray = JSON(data)["data"].array
        
        var index = 0
        for item in jsonArray! {
            //Do something you want
            println(item)
            var itemTuple = ("","","")
            
            itemTuple.0 = item["id"].stringValue
            itemTuple.1 = item["name"].stringValue
            itemTuple.2 = item["created_time"].stringValue
            
            self.likesPages.append(itemTuple)
            index++
        }
        println(jsonArray)
        
        
        self.tableVIew.reloadData()
        self.activityIndicator.stopAnimating()
    }
    
    
    
    
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetail" {
            if let desVC = segue.destinationViewController as? DetailVC{
                if let selectedRowIndex = self.tableVIew.indexPathForSelectedRow()?.row{
                    desVC.selectedPage = self.likesPages[selectedRowIndex]
                }
                
            }
        }
    }
    
    
    func addInTextView(text:String?){
        
        if text != nil {
                    self.txtView.text =  "\(self.txtView.text) \n \(text!)"
        }

    }
    
}

