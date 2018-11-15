//
//  GameConfig.swift
//  MathsMaster
//
//  Created by roy on 2018/7/23.
//  Copyright © 2018年 roy. All rights reserved.
//

import UIKit

let uGameMusic = "isGameMusic"
let uGameSound = "isGameSound"

class GameConfig: NSObject {
    static let shared = GameConfig()
    
    private var _highScore: Int = 0
    var highScore: Int {
        get {
            let gameLevelStr = "Sorce"
            
            return UserDefaults.standard.integer(forKey: gameLevelStr)
        }
        
        set {
            _highScore = newValue
            let gameLevelStr = "Sorce"
            
            UserDefaults.standard.set(newValue, forKey: gameLevelStr)
            UserDefaults.standard.synchronize()
        }
    }
    
    var isGameMusic = UserDefaults.standard.object(forKey: uGameMusic) as? Bool ?? true {
        didSet {
            UserDefaults.standard.set(isGameMusic, forKey: uGameMusic)
            UserDefaults.standard.synchronize()
        }
    }
    var isGameSound = UserDefaults.standard.object(forKey: uGameSound) as? Bool ?? true {
        didSet {
            UserDefaults.standard.set(isGameSound, forKey: uGameSound)
            UserDefaults.standard.synchronize()
        }
    }
    
}
