//
//  XZDaeNode.swift
//  XZSceneKit
//
//  Created by zxz on 16/1/11.
//  Copyright © 2016年 zxz. All rights reserved.
//

import UIKit
import SceneKit
class XZDaeNode: NSObject {
    static func daeDataFromResource(name:String,type:String)-> SCNSceneSource{
        let url = NSBundle.mainBundle().URLForResource(name, withExtension: type)
        let daeSource = SCNSceneSource(URL: url!, options: nil)
        return daeSource!
    }
    static func nodeInDae()->SCNNode?{
        let dae = XZDaeNode.daeDataFromResource("Critter", type: "dae")
        let node = dae.entryWithIdentifier("Critter", withClass: SCNNode.self)
        if node != nil{
            node?.position = SCNVector3(5,0,0)
            return node
        }else {
            return nil
        }
    }
}
