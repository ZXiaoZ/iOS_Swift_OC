//
//  XZDropBehavior.swift
//  dropit
//
//  Created by zxz on 16/1/12.
//  Copyright © 2016年 zxz. All rights reserved.
//

import UIKit

class XZDropBehavior: UIDynamicBehavior {
    let gravity = UIGravityBehavior()
    lazy var collider:UICollisionBehavior = {
        let lazilyCollider = UICollisionBehavior()
        lazilyCollider.translatesReferenceBoundsIntoBoundary = true
        return lazilyCollider
    }()
    lazy var dropBehavior:UIDynamicItemBehavior = {
        let lazilyDropBehavior = UIDynamicItemBehavior()
        lazilyDropBehavior.allowsRotation = false
        lazilyDropBehavior.elasticity = 0.75
        return lazilyDropBehavior
    }()
    
    override init(){
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(dropBehavior)
    }
    func addBarrier(path: UIBezierPath, named name: String){
        collider.removeBoundaryWithIdentifier(name)
        collider.addBoundaryWithIdentifier(name, forPath: path)
    }
    func addDrop(drop:UIView) {
        dynamicAnimator?.referenceView?.addSubview(drop)
        gravity.addItem(drop)
        collider.addItem(drop)
        dropBehavior.addItem(drop)
    }
    func removeDrop(drop:UIView) {
        gravity.removeItem(drop)
        collider.removeItem(drop)
        drop.removeFromSuperview()
    }
    
}
