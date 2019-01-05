//
//  ModelsAndData.swift
//  7 Sides
//
//  Created by Ashish Sahota on 2017-04-15.
//  Copyright © 2017 Ashish Sahota. All rights reserved.
//


/////////////////////////// Sides and balls information/////////////////////////////
import Foundation
import SpriteKit
enum colorType{
    case Red
    case Orange
    case Pink
    case Blue
    case Yellow
    case Purple
    case Green
    
}
let colorWheelOrder: [colorType] = [
.Red,    //0
.Orange, //1
.Yellow, //2
.Green,  //3
.Blue,   //4
.Purple, //5
.Pink    //6
]

var sidePositions:[CGPoint] = []


///////////////////////////////////////Game State//////////////////////////////////////

enum gameState{
 case beforeGame
 case inGame
 case afterGame
    
}

///////////////////////////////////Physics Catergory//////////////////////////////////

struct PhysicsCatergories {
    static let None: UInt32 = 0    //0
    static let Ball: UInt32 = 0b1  //1
    static let Side: UInt32 = 0b10 //2
}

/////////////////////////////////////Score System/////////////////////////////////////////

var score: Int = 0

/////////////////////////////////////Level System////////////////////////////////////////

var ballMovementSpeed: TimeInterval = 2








