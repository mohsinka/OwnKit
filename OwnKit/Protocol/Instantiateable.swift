//
//  Instantiateable.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 2/1/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

import UIKit

public protocol Instantiateable: class {
    static var nibName: String { get }
    static var nibBundle: NSBundle { get }
}

public extension Instantiateable where Self: UIViewController {
    static var nibBundle: NSBundle {
        return .mainBundle()
    }
    
    @warn_unused_result
    static func instantiate() -> Self {
        return UIStoryboard.instantiateInitialViewController(nibName, bundle: nibBundle)
    }
}

public extension Instantiateable where Self: UIView {
    static var nibBundle: NSBundle {
        return .mainBundle()
    }
    
    @warn_unused_result
    static func instantiate() -> Self {
        return UINib.instantiateFirstView(nibName, bundle: nibBundle)
    }
}