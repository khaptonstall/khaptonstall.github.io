//
//  Article.swift
//
//
//  Created by Kyle Haptonstall on 4/2/24.
//

import Foundation
import Ignite

/// A custom layout used for Articles (i.e. Markdown files within the Content/articles directory)
struct Article: ContentPage {
    func body(content: Content, context: PublishingContext) -> [any BlockElement] {
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
