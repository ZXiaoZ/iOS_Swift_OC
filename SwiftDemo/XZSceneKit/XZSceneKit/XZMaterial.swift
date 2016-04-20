//
//  XZMaterial.swift
//  XZSceneKit
//
//  Created by zxz on 16/1/11.
//  Copyright © 2016年 zxz. All rights reserved.
//

import UIKit
import SpriteKit
import SceneKit

class XZMaterial: SCNMaterial {
    func textureMaterial(noiseTexture:SKTexture? = SKTexture(noiseWithSmoothness: 0.25, size: CGSize(width: 512, height: 512), grayscale:true)){
        let normalTexture = noiseTexture?.textureByGeneratingNormalMapWithSmoothness(0.1, contrast: 1)
        self.normal.contents = normalTexture
        self.diffuse.contents = noiseTexture
    }

}
