//
//  XZPhysicBody.swift
//  XZSceneKit
//
//  Created by zxz on 16/1/11.
//  Copyright © 2016年 zxz. All rights reserved.
//

import UIKit
import SceneKit
class XZPhysicBody: NSObject {
    static func XZPhysicBody(node:SCNNode)->SCNPhysicsBody{
        var shape:SCNPhysicsShape?
        if let geometry = node.geometry{
            shape = SCNPhysicsShape(geometry: geometry, options: nil)
        }
        let pBody = SCNPhysicsBody(type: SCNPhysicsBodyType.Dynamic, shape: shape)
        return pBody
    }
}
