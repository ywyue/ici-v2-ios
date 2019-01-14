//
//  Px.swift
//  map-test
//
//  Created by Blanketzzz on 2019/1/9.
//  Copyright © 2019 Blanketzzz. All rights reserved.
//

import Foundation

extension Double {
    func px() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/750*SCREEN_WIDTH)
    }
}
extension Float {
    func px() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/750*SCREEN_WIDTH)
    }
}
extension Int {
    
    func px() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/750*SCREEN_WIDTH)
    }
}
extension CGFloat {
    
    func minus() -> CGFloat{
        return 0 - self
    }
    
}

