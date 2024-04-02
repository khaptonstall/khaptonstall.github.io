//
//  SocialWebsite.swift
//  
//
//  Created by Kyle Haptonstall on 4/2/24.
//

import Foundation

enum SocialWebsite: String, CaseIterable {
    case linkedIn = "https://www.linkedin.com/in/khaptonstall"
    case github = "https://github.com/khaptonstall"
    case medium = "https://medium.com/@Khaptonstall"

    var relativeImagePath: String {
        return "\(imageFolderPath)\(imageName)"
    }

    var imageDescription: String {
        switch self {
        case .linkedIn:
            return "LinkedIn"
        case .github:
            return "GitHub"
        case .medium:
            return "Medium"
        }
    }

    private var imageFolderPath: String {
        return "/images/SocialIcons/"
    }

    private var imageName: String {
        switch self {
        case .linkedIn:
            return "linkedin_black.png"
        case .github:
            return "github_black.png"
        case .medium:
            return "medium_black.png"
        }
    }
}
