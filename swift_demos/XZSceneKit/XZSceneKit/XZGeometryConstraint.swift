//
//  XZGeometryConstraint.swift
//  XZSceneKit
//
//  Created by zxz on 16/1/11.
//  Copyright © 2016年 zxz. All rights reserved.
//

import UIKit
import SceneKit
class XZGeometryConstraint: NSObject {
    static func pyramid()->SCNNode{
        let pyramid = SCNPyramid(width: 0.5, height: 0.9, length: 4.0)
        let node = SCNNode(geometry: pyramid)
        node.position = SCNVector3(-5,0,0)
        return node
    }
    static func addConstrain(fromNode:SCNNode,toNode:SCNNode){
        let lookAtConstrain = SCNLookAtConstraint(target: toNode)
        lookAtConstrain.gimbalLockEnabled = true
        fromNode.constraints = [lookAtConstrain]
    }
}
