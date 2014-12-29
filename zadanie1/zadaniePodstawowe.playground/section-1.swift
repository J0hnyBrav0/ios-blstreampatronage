import UIKit



class PointOfInterest {
    var name:String
    var latitude:Float
    var longtitude:Float
    var address:String
    
    func poiDescription() -> String{
        return String("\(name) - \(latitude),\(longtitude) - \(address)")
    }
    
    init(name: String, address: String, latitude: Float, longtitude: Float ){
        self.longtitude = longtitude
        self.latitude = latitude
        self.address = address
        self.name = name
    }
    
}


var point1 = PointOfInterest(name: "BLStream Sp. z o.o.", address: "Plac Hołdu Pruskiego 9, Szczecin,PL", latitude: 53.429330,  longtitude: 14.556319)

point1.poiDescription()

