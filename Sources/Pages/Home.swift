// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
import Ignite

struct Home: StaticPage {
    let title = "Home"
    let description = "Kyle Haptonstall's personal website and blog."

    func body(context: PublishingContext) -> [BlockElement] {
        Image("/images/photos/headshot.png", description: "A headshot of the author")
            .resizable()
            .frame(width: 150, height: 150)
            .margin(.bottom)
            .imageAlignment(.center)

        Text("Hello, I'm Kyle Haptonstall.")
            .font(.title1)
            .horizontalAlignment(.center)

        Text("I’m a software engineer that has been shipping products on Apple platforms since 2015.")
            .horizontalAlignment(.center)

        Text(markdown: """
        Most recently, I lead iOS engineering for Riva Health, [turning your iPhone into an FDA-approved blood pressure monitor.](https://techcrunch.com/2021/03/17/riva-health-wants-to-turn-your-smartphone-into-a-blood-pressure-monitor/)
        """)
        .horizontalAlignment(.center)

        Text("I’m also a big fan of craft coffee ☕ and English football ⚽.")
            .horizontalAlignment(.center)
            .margin(.bottom)

        Text {
            for socialWebsite in SocialWebsite.allCases {
                Link(target: socialWebsite.rawValue) {
                    Image(socialWebsite.relativeImagePath, description: socialWebsite.imageDescription)
                        .resizable()
                        .frame(width: 44, height: 44)
                }
                .margin()
            }
        }
        .horizontalAlignment(.center)

        Text("Recent Articles")
            .font(.title1)
            .horizontalAlignment(.center)
            .margin(.top, 80)

        Section {
            for article in context.content(ofType: "articles") {
                ContentPreview(for: article)
                    .horizontalAlignment(.center)
            }
        }
        .margin(.horizontal)
    }
}
