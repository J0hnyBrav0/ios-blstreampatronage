// Playground - noun: a place where people can play

import UIKit
import Foundation
import Accelerate

struct Address {
    var street:String
    var city:String
    var country:String
    
    func toString() -> String{
        return "\(street),\(city),\(country)"
    }
}

struct Coordinate{
    var latitude:Double
    var longtitude:Double
    func toString() -> String{
        return "\(latitude), \(longtitude) "
    }
    
    static func distanceBetweenCoordinates(aCoordinate: Coordinate,bCoordinate: Coordinate) -> Double {
        
        return haversine(aCoordinate.latitude, bCoordinate.latitude, aCoordinate.longtitude,bCoordinate.longtitude)
        
        
    }
}


class PointOfInterest {
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


//helpers

enum MeasurementUnit:Double{
    case kilometers = 1000.0
    case landMiles = 1609.344
    
}

extension Double {
    
    func deg2rad() -> Double{
        let toRad = M_PI/180
        
        return self * toRad;
    }
    
    func convertMetersTo(unit: MeasurementUnit) -> Double{
        return self/unit.rawValue
    }
    
}

/*
http://en.wikipedia.org/wiki/Earth_radius
Mean radius
The International Union of Geodesy and Geophysics (IUGG) defines the mean radius (denoted R_1) to be:

a = 6,378.1370 //equatorial raidus in km
b = 6,356.7523 // polar radius in km

R_1 = (2a+b)/3
R_1 =  6371.009

*/
func R(λ:Double) -> Double {
    var sin2λ = sin(λ)*sin(λ)
    
    
    var R_2 = 6378 - 21 * sin(λ)
    var R_1 = 6371.009
    return R_1
    //return R_2
}
/*
http://www.movable-type.co.uk/scripts/gis-faq-5.1.html
*/
func haversine(Φ1:Double,Φ2:Double,λ1:Double,λ2:Double) -> Double {
    var d = 0.0
    
    
    var dλ = (λ2-λ1).deg2rad()
    var dΦ = abs(Φ2-Φ1).deg2rad()
    var λ1inRad = λ1.deg2rad()
    var λ2inRad = λ2.deg2rad()
    
    var a = pow(sin(dλ/2),2) + cos(λ1inRad)*cos(λ2inRad) * pow(sin(dΦ/2),2)
    
    var c = 2 * asin(min(1,sqrt(a)))
    
    d = c * R(λ1inRad)
    return d
}



/******************** Usage Example  *********************************/


var importantPoints:[PointOfInterest] = [
    PointOfInterest(name:"BLStream Office", coordinates:Coordinate(latitude: 53.429204,  longtitude: 14.556324), address:Address(street: "Małopolska 10", city: "Szczecin", country: "PL")),
    PointOfInterest(name:"TechnoPark Pomerania", coordinates:Coordinate(latitude: 53.449227,  longtitude: 14.537591), address:Address(street: "Niemierzynska 17", city: "Szczecin", country: "PL")),
    PointOfInterest(name:"CH Kaskada", coordinates:Coordinate(latitude: 53.428494, longtitude: 14.551453), address:Address(street: "Niepodległości 36", city: "Szczecin", country: "PL")),
    PointOfInterest(name:"MakKwak", coordinates:Coordinate(latitude: 53.428878, longtitude: 14.554291), address:Address(street: "Plac Żołnierza Polskiego 17", city: "Szczecin", country: "PL"))
]


var rangeInMeters:Double = 500.0

//closure
var inMyRange = importantPoints.filter({(point:PointOfInterest) -> Bool in
    
    return (Coordinate.distanceBetweenCoordinates(point.coordinates, bCoordinate: importantPoints[0].coordinates) < rangeInMeters.convertMetersTo(.kilometers) && point.name != importantPoints[0].name)
})

for poi in inMyRange{
    print("You can go to \(poi.name) at \(poi.address.toString()) \n")
}
