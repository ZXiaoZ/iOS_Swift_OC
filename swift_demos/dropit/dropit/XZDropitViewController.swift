//
//  XZDropitViewController.swift
//  dropit
//
//  Created by zxz on 16/1/12.
//  Copyright © 2016年 zxz. All rights reserved.
//

import UIKit

class XZDropitViewController: UIViewController,UIDynamicAnimatorDelegate {

    @IBOutlet var gameView: UIView!
    let gravity = UIGravityBehavior()
    let collider = UICollisionBehavior()
    lazy var animator:UIDynamicAnimator = {
        let lazilyAnimator = UIDynamicAnimator(referenceView: self.gameView)
        lazilyAnimator.delegate = self
        return lazilyAnimator
    }()
    //:MARK XZDropBehavior
    let dropBehavior = XZDropBehavior()
    
    //:MARK UIAttachmentBehavior
    var attachment:UIAttachmentBehavior? {
        willSet {
            if attachment != nil {
            animator.removeBehavior(attachment!)
            }
        }
        didSet{
            if attachment != nil {
                animator.addBehavior(attachment!)
            }
        }
    }
    var dropPerRow = 10
    var dropSize:CGSize{
        let size = gameView.bounds.size.width / CGFloat(dropPerRow)
        return CGSize(width: size, height: size)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.animator = UIDynamicAnimator(referenceView: gameView)
//        self.animator.delegate = self
//        self.animator.addBehavior(gravity)
//        self.animator.addBehavior(collider)
//        collider.translatesReferenceBoundsIntoBoundary = true
//        
        self.animator.addBehavior(dropBehavior)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let barrierSize = dropSize
        let barrierOrigin = CGPoint(x: gameView.bounds.midX - barrierSize.width/2, y: gameView.bounds.midY - barrierSize.height/2)
        let path = UIBezierPath(ovalInRect: CGRect(origin: barrierOrigin, size: barrierSize))
        dropBehavior.addBarrier(path, named: "Middle Barrier")
        
    }
    //:MARK UIDynamicAnimatorDelegate
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        
    }
    
    @IBAction func grabDrop(sender: UIPanGestureRecognizer) {
        let gesturePoint = sender.locationInView(self.gameView)
        switch sender.state {
        case .Began:
            if let viewToAttachment = lastDroppedView {
                attachment  = UIAttachmentBehavior(item: viewToAttachment, attachedToAnchor: gesturePoint)
            }
        case .Changed: attachment?.anchorPoint = gesturePoint
        case .Ended: attachment = nil
        default: break
        }
    }
    var lastDroppedView: UIView?
    @IBAction func drop(sender: AnyObject) {
        drop()
    }
    func drop(){
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x =  self.randomCGFloat(dropPerRow) * dropSize.width
        let dropView = UIView(frame: frame)
        dropView.backgroundColor = self.randomColor
        gameView.addSubview(dropView)
        gravity.addItem(dropView)
        collider.addItem(dropView)
        
        lastDroppedView = dropView
        dropBehavior.addDrop(dropView)
    }
    
    func randomCGFloat(max:Int) -> CGFloat {
            return CGFloat(arc4random() % UInt32(max))
    }
    var randomColor:UIColor {
        switch random() % 5 {
        case 0: return UIColor.greenColor()
        case 1: return UIColor.blackColor()
        case 2: return UIColor.blueColor()
        case 3: return UIColor.redColor()
        case 4: return UIColor.purpleColor()
        default: return UIColor.grayColor()
        }
    }
    
    
    
    
    



}
