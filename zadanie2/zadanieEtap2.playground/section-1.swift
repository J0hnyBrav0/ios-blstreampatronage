// Playground - noun: a place where people can play

import UIKit


enum MeasurementUnit:Float{
    case kilometers = 1000.0
    case landMiles = 1609.344

}


extension Float {
     func convertMetersTo(unit: MeasurementUnit) -> Float{
        return self/unit.rawValue
    }



}


var distance:Float = 100.0
var kilometers = distance.convertMetersTo(.kilometers)
var miles = distance.convertMetersTo(.landMiles)
