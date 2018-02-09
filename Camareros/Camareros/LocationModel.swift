//
//  LocationModel.swift
//  Camareros
//
//  Created by aleluis burguerMan on 29/1/18.
//  Copyright © 2018 aleluis burguerMan. All rights reserved.
//

import Foundation

class LocationModel: NSObject {
    
    //properties
    
    var cnom: String?
    var pass: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(cnom: String, pass: String) {
        
        self.cnom = cnom
        self.pass = pass
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "cod: \(cnom), cosa: \(pass)"
        
}

}
