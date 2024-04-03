import Foundation
import Ignite

@main
struct IgniteWebsite {
    static func main() {
        let site = ExampleSite()

        do {
            try site.publish()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ExampleSite: Site {    
    var name = "Kyle Haptonstall"
    var titleSuffix: String = " - Kyle Haptonstall"
    var url = URL("khaptonstall.github.io")
    var builtInIconsEnabled = true
    var syntaxHighlighters: [SyntaxHighlighter] = [
        .bash,
        .swift,
        .yaml,
    ]

    var author = "Kyle Haptonstall"
    var robotsConfiguration = Robots()

    var homePage = Home()
    var theme = MyTheme()

    var layouts: [any ContentPage] {
        Article()
    }
}


