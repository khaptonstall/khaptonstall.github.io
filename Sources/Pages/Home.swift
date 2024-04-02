import Foundation
import Ignite

struct Home: StaticPage {
    var title = "Home"

    func body(context: PublishingContext) -> [BlockElement] {
        Image("images/photos/headshot.png", description: "A headshot of the author")
            .resizable()
            .frame(width: 150, height: 150)
            .margin()
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
    }
}
