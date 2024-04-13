// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
import Ignite

struct NavBar: Component {
    func body(context _: PublishingContext) -> [any PageElement] {
        NavigationBar(logo: "Kyle Haptonstall") {
            // Note: NavigationBar doesn't allow hiding the according, so just provide
            // an explicit option to go back home
            Link("Home", target: "/")
        }
        .position(.fixedTop)
        .backgroundColor(.darkSlateGray)
        .navigationBarStyle(.dark)
    }
}
