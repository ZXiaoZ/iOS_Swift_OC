//
//  ViewController.swift
//  XZSceneKit
//
//  Created by zxz on 16/1/11.
//  Copyright © 2016年 zxz. All rights reserved.
//

import UIKit
import SceneKit
protocol TapRecognizerDelegate{
    func didTapped(tapRecognizer:UITapGestureRecognizer,scnView:SCNView)
}
class ViewController: UIViewController {

    var delegate:TapRecognizerDelegate?
    func tapped(tap:UITapGestureRecognizer){
        let scnView = self.view as! SCNView
        delegate?.didTapped(tap, scnView: scnView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let scnView = self.view as! SCNView
        scnView.backgroundColor = UIColor.grayColor()
        let scene = self.scene()
        scnView.scene = scene
        let cameraNode = self.createCameraNode()
        scene.rootNode.addChildNode(cameraNode)
        let capsuleNode = self.createCapsuleNode()
        scene.rootNode.addChildNode(capsuleNode)
        let ambientLightNode = self.createAmbientLightNode()
        let omniLightNode = self.omniLightNode()
        scene.rootNode.addChildNode(ambientLightNode)
        scene.rootNode.addChildNode(omniLightNode)
        
        //动画
        let moveUpDownAnimation = self.moveUpDownAnimation()
        capsuleNode.addAnimation(moveUpDownAnimation, forKey: "updown")
        
        //文本
        let textNode = self.textNode()
        scene.rootNode.addChildNode(textNode)
        let rotateAnimation = self.rotateAnimation()
        textNode.addAnimation(rotateAnimation, forKey: "rotation")
        
        //增加点击发亮
        let tap = XZTapRecognizer()
        tap.addTapRecognizer(self, view: scnView)
        
        //增加约束
        let pyramid = XZGeometryConstraint.pyramid()
        XZGeometryConstraint.addConstrain(pyramid, toNode: capsuleNode)
        scene.rootNode.addChildNode(pyramid)
        
        //增加Dae文件
        let critterNode = XZDaeNode.nodeInDae()
        scene.rootNode.addChildNode(critterNode!)
        
        //增加物理效果
        let pBody = XZPhysicBody.XZPhysicBody(critterNode!)
        critterNode?.physicsBody = pBody
        
        //
        XZFloor.addFloor(scene)
    }

    func scene()->SCNScene{
        let scene = SCNScene()
        return scene
        
    }
    //:MARK 创建camera
    func createCamera()->SCNCamera{
        let camera = SCNCamera()
        camera.xFov = 45
        camera.yFov = 45
        return camera
    }
    //:MARK 创建camera 节点
    func createCameraNode()->SCNNode{
        let cameraNode = SCNNode()
        let camera = self.createCamera()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(0,0,20)
        return cameraNode
    }
    //:MARK 创建胶囊
    func createCapsule()->SCNCapsule{
        let capsule = SCNCapsule(capRadius: 2.5, height: 10)
        let material = XZMaterial()
        material.textureMaterial()
        capsule.materials = [material]
        return capsule
    }
    func createCapsuleNode()->SCNNode{
        let capsule = self.createCapsule()
//        capsule.materials = [self.colorMaterial()]
        let capsuleNode = SCNNode(geometry: capsule)
        capsuleNode.position = SCNVector3(0,0,-20)
        
        return capsuleNode
        
    }
    //:MARK 创建环境光源
    func createAmbientLight()->SCNLight{
        let light = SCNLight()
        light.color = UIColor(white: 0.25, alpha: 1.0)
        return light
    }
    func createAmbientLightNode()->SCNNode{
        let ligthNode = SCNNode()
        ligthNode.light = self.createAmbientLight()
        ligthNode.position = SCNVector3(0,0,20)
        return ligthNode
    }
    //:MARK 创建泛光源
    func createOmniLight()->SCNLight{
        let light = SCNLight()
        light.type = SCNLightTypeOmni
        light.color = UIColor(white: 1, alpha: 1.0)
        return light
    }
    func omniLightNode()->SCNNode{
        let node = SCNNode()
        node.light = self.createOmniLight()
        node.position = SCNVector3(-40,0,0)
        return node
    }
    //:MARK 动画: move up down
    func moveUpDownAnimation()->CAAnimation{
        let animation = CABasicAnimation(keyPath: "position")
        animation.byValue = NSValue(SCNVector3: SCNVector3(0,5,0))
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        return animation
    }
    //:MARK 文字
    func text()->SCNText{
        let text = SCNText(string: "中共中央", extrusionDepth: 0.2)
        text.font = UIFont.systemFontOfSize(2)
        return text
    }
    func textNode()->SCNNode{
        let node = SCNNode(geometry:self.text())
        node.position = SCNVector3(-6,5,0)
        return node
    }
    //:MARK 合并动画-为文本加旋转动画
    func rotateAnimation()->CAAnimation{
        let rotate = CABasicAnimation(keyPath: "eulerAngles")
        rotate.byValue = NSValue(SCNVector3:SCNVector3(0, Float(M_PI*2.0), 0))
        rotate.repeatCount = Float.infinity
        rotate.duration = 4
        return rotate
    }
    //:MARK 向胶囊添加材质,金属表面
    func colorMaterial()->SCNMaterial{
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.redColor()
        material.specular.contents = UIColor.whiteColor()
        material.shininess = 1.0
        return material
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

