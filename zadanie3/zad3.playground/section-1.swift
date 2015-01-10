// Playground - noun: a place where people can play

import UIKit
import Foundation
import Accelerate

var str = "Hello, playground"


/***************************** 3 TASK ********************/

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


func R(lat:Double) -> Double {
    
    return 6378 - 21 * sin(lat) //good enough
}

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

func whichObjectsStoredIn(#array:[PointOfInterest],#from:PointOfInterest, #areInMyDistance:Double=500)->[PointOfInterest]{
    
    var closeEnough:[PointOfInterest] = []
    
    //closure
    var isClose = array.map({(point:PointOfInterest) -> Bool in
        var indexes:Bool = false
        
        if (point.coordinates.distanceBetweenCoordinates(point.coordinates, bCoordinate: from.coordinates) < areInMyDistance.convertMetersTo(.kilometers)) {
            indexes = true
        }
        return indexes
    })
    
    for i in 0...isClose.count-1 {
        if(isClose[i] && array[i].name != from.name){
            closeEnough.append(array[i])
        }
    }
    return closeEnough
}

/****************************** FROM 1 task ****************/
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
    
    func distanceBetweenCoordinates(aCoordinate: Coordinate,bCoordinate: Coordinate) -> Double {
        
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



/******************** Usage Example  *********************************/

var CenterOfUniverse = PointOfInterest(name:"BLStream Office", coordinates:Coordinate(latitude: 53.429204,  longtitude: 14.556324), address:Address(street: "Małopolska 10", city: "Szczecin", country: "PL"))

var EdgeOfWord = PointOfInterest(name:"TechnoPark Pomerania", coordinates:Coordinate(latitude: 53.449227,  longtitude: 14.537591), address:Address(street: "Niemierzynska 17", city: "Szczecin", country: "PL"))

var Where2SpendMoney = PointOfInterest(name:"CH Kaskada", coordinates:Coordinate(latitude: 53.428494, longtitude: 14.551453), address:Address(street: "Niepodległości 36", city: "Szczecin", country: "PL"))


var Food = PointOfInterest(name:"MakKwak", coordinates:Coordinate(latitude: 53.428878, longtitude: 14.554291), address:Address(street: "Plac Żołnierza Polskiego 17", city: "Szczecin", country: "PL"))

var importantPoints:[PointOfInterest] = [CenterOfUniverse,EdgeOfWord,Where2SpendMoney,Food]


var meters:Double = 500.0
var whereCanIGo:[PointOfInterest] = whichObjectsStoredIn(array:importantPoints,from:CenterOfUniverse,areInMyDistance:meters)

for poi in whereCanIGo{
    print("You can go to \(poi.name) at \(poi.address.toString())")
}

