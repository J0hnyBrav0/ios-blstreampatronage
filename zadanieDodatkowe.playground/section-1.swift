// Playground - noun: a place where people can play

import UIKit

protocol pCoordinate{
    var latitude:Double {get set}
    var longtitude:Double {get set}
    mutating func toString() -> String
}

struct Coordinate: pCoordinate{
    var latitude:Double
    var longtitude:Double
    func toString() -> String{
        return "\(latitude), \(longtitude) "
    }
}

protocol pAddress{
    var street:String {get set}
    var city:String {get set}
    var country:String {get set}
    mutating func toString() -> String
}


struct Address:pAddress {
    var street:String 
    var city:String
    var country:String
    
    func toString() -> String{
        return "\(street),\(city),\(country)"
    }
}


protocol pComplex {
    var name:String {get set}
    var address:Address {get set}
    var coordinates:Coordinate {get set}
    
}

class PointOfInterest: pComplex {
    var name:String
    var coordinates: Coordinate
    var address:Address

    init(name: String, address: Address, coordinates: Coordinate){
        self.coordinates = coordinates
        self.address = address
        self.name = name
    }


    func poiDescription() -> String{
        return String("\(name) - \(coordinates.toString())- \(address.toString())")
    }
    
    init(name: String, coordinates: Coordinate, address: Address ){
        self.name = name
        self.coordinates = coordinates
        self.address = address
    }
    
}


/********************              Example              *********************************/

var sampleCoordinates =  Coordinate(latitude: 53.449213,  longtitude: 14.535491)

var sampleAddress = Address(street: "Niemierzynska 17", city: "Szczecin", country: "PL")

var point2 = PointOfInterest(name:"TechnoPark Pomerania", coordinates:sampleCoordinates, address:sampleAddress)

point2.poiDescription()



