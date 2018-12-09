//
//  UIStoryboard+.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 09/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import UIKit

public enum StoryboardName: String {
    case main = "Main"
}

public extension UIViewController {
    static func instantiate(from name: StoryboardName) -> Self? {
        let sb = UIStoryboard(name: name.rawValue,
                              bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "\(self)ID")
        
        return dynamicCast(vc,
                           as: self)
    }
}

private func dynamicCast<T>(_ object: Any,
                            as: T.Type) -> T? {
    return object as? T
}
