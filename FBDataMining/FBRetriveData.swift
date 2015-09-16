//
//  FBRetriveData.swift
//  FBDataMining
//
//  Created by Mohsin on 16/09/2015.
//  Copyright (c) 2015 Mohsin. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import FBSDKCoreKit


class FBRetriveData {
    
    
    class func getUserBasicInfoFromFB(complete: (myUser: User?, errorDesc: String?) -> Void)
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, user, error) -> Void in
            
            var tempUser = User()
            
            if ((error) != nil)
            {
                // Process error
                println("Error : \(error.localizedDescription)")
                complete(myUser: nil, errorDesc: error.localizedDescription)
            }
            else
            {
                
                println("User get info ")
                
                tempUser.name = user["name"] as? String
                tempUser.fbId = user["id"] as? String
                
                //callBack
                complete(myUser: tempUser, errorDesc: nil)
                
            }
        })
    }
    
    
    
    class func getUserPermision(user: User){
    
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "\(user.fbId)/permissions", parameters: nil, HTTPMethod: "GET")
        
        
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            println("permissions : \(result)")
        
        })
        
    }
    
    class func getUserFullInfo(user: User, complete: (result : AnyObject) -> Void){
        let params = ["fields": "picture, email"]
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: user.fbId! , parameters: params, HTTPMethod: "GET")
    
        
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            println("Full Info : \(result)")
            
            if result != nil {
                complete(result: result)
            }
        })
        
    }
    
    
    class func getUserLikes(user: User, complete: (result : AnyObject)->Void){
        let params = ["fields": "url"]
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "/me/likes", parameters: nil, HTTPMethod: "GET")
        
        
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if result != nil {
                complete(result: result)
            }
        })
        
    }
    

    
}