//
//  XZTapRecognizer.swift
//  XZSceneKit
//
//  Created by zxz on 16/1/11.
//  Copyright © 2016年 zxz. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

class XZTapRecognizer: NSObject,TapRecognizerDelegate{
    func didTapped(tapRecognizer: UITapGestureRecognizer, scnView: SCNView) {
        if tapRecognizer.state == UIGestureRecognizerState.Ended{
            let hits = scnView.hitTest(tapRecognizer.locationInView(tapRecognizer.view), options: nil)
            for hit in hits{
                if let material = hit.node.geometry?.materials[0]{
                    let highlightAnimation = CABasicAnimation(keyPath: "contents")
                    highlightAnimation.fromValue = UIColor.blackColor()
                    highlightAnimation.fromValue = UIColor.yellowColor()
                    highlightAnimation.duration = 1
                    material.emission.addAnimation(highlightAnimation, forKey: "highlight")
                }
            }
        }
    }
    func addTapRecognizer(viewController:ViewController,view:SCNView){
        let tapRecognizer = UITapGestureRecognizer(target: viewController, action: "tapped:")
        view.addGestureRecognizer(tapRecognizer)
        view.userInteractionEnabled = true
        viewController.delegate = self
    }
}
