//
//  Robots.swift
//
//
//  Created by Kyle Haptonstall on 4/2/24.
//

import Foundation
import Ignite

struct Robots: RobotsConfiguration {
    var disallowRules: [DisallowRule]

    init() {
        disallowRules = [
            DisallowRule(robot: .chatGPT)
        ]
    }
}

