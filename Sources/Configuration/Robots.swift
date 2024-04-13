// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
import Ignite

struct Robots: RobotsConfiguration {
    var disallowRules: [DisallowRule]

    init() {
        self.disallowRules = [
            DisallowRule(robot: .chatGPT),
        ]
    }
}
