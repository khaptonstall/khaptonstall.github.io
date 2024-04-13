// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation

enum SocialWebsite: String, CaseIterable {
    case linkedIn = "https://www.linkedin.com/in/khaptonstall"
    case github = "https://github.com/khaptonstall"
    case medium = "https://medium.com/@Khaptonstall"

    var relativeImagePath: String {
        "\(imageFolderPath)\(imageName)"
    }

    var imageDescription: String {
        switch self {
        case .linkedIn:
            "LinkedIn"
        case .github:
            "GitHub"
        case .medium:
            "Medium"
        }
    }

    private var imageFolderPath: String {
        "/images/socialicons/"
    }

    private var imageName: String {
        switch self {
        case .linkedIn:
            "linkedin_black.png"
        case .github:
            "github_black.png"
        case .medium:
            "medium_black.png"
        }
    }
}
