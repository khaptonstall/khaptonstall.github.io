// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
import Ignite

/// A custom layout used for Articles (i.e. Markdown files within the Content/articles directory)
struct Article: ContentPage {
    func body(content: Content, context _: PublishingContext) -> [any BlockElement] {
        Text(content.title)
            .font(.title1)
            .margin(.top)

        if !content.hasAutomaticDate {
            Text(DateFormatter.articleDateFormatter.string(from: content.date))
        }

        Text(content.body)
            .margin(.bottom)
    }
}
