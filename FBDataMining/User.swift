//
//  User.swift
//  FBDataMining
//
//  Created by Mohsin on 16/09/2015.
//  Copyright (c) 2015 Mohsin. All rights reserved.
//

import Foundation


class User{
    var name: String?
    var fbId : String?
    

    func desc(){
        println(self.name)
        println(self.fbId)
    }
}