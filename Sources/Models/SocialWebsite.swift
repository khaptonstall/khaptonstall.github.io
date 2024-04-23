// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation

enum SocialWebsite: String, CaseIterable {
    case linkedIn = "https://www.linkedin.com/in/khaptonstall"
    case github = "https://github.com/khaptonstall"
    case medium = "https://medium.com/@Khaptonstall"

    var displayName: String {
        switch self {
        case .linkedIn:
            "LinkedIn"
        case .github:
            "GitHub"
        case .medium:
            "Medium"
        }
    }

    // Source: https://icons.getbootstrap.com/
    var systemImageName: String {
        switch self {
        case .linkedIn:
            "linkedin"
        case .github:
            "github"
        case .medium:
            "medium"
        }
    }
}
