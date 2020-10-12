//
//  RoutableComponent.swift
//  Core
//
//  Created by Wojciech Konury on 11/10/2020.
//

import Foundation
import NeedleFoundation
import UIKit

public protocol RoutesDefinition {}

public protocol RoutableBootstrapComponent: BootstrapComponent, RoutesDefinition {}

public protocol RoutableComponent: RoutesDefinition {
    var viewController: UIViewController { get }
}
