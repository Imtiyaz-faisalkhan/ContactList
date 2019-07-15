//
//  ContactInfo.swift
//  ContactList
//
//  Created by Faisal Khan on 15/07/2019.
//  Copyright © 2019 Faisal. All rights reserved.
//

import Foundation

struct ContactInfo : Codable {
    let results:[Contact]
    
}

struct Contact :Codable {
    let gender :String
    let name:ContactName
    let location:ContactLocation
    let email:String
    let phone:String
    let cell:String
    let picture:ContactImage
    
}
struct ContactName:Codable{
    let title:String
    let first:String
    let last:String
}

struct ContactLocation:Codable {
    let street:String
    let city:String
}
struct ContactImage:Codable {
    let large:String
    let thumbnail:String
    
}
