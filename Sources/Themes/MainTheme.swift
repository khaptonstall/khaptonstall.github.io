// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
import Ignite

struct MyTheme: Theme {
    func render(page: Page, context: PublishingContext) -> HTML {
        HTML {
            Head(for: page, in: context)

            Body {
                if page.title != "Home" {
                    NavBar()
                }
                page.body
            }
            .padding(.vertical, 80)
        }
    }
}
