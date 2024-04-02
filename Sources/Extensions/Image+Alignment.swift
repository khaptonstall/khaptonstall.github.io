//
//  Image+Alignment.swift
//
//
//  Created by Kyle Haptonstall on 4/2/24.
//

import Foundation
import Ignite

extension PageElement where Self == Image {
    /// Aligns this image using the specific alignment.
    /// - Parameter alignment: How to align this image.
    /// - Returns: A copy of the current image with the updated
    /// horizontal alignment applied.
    func imageAlignment(_ horizontalAlignment: HorizontalAlignment) -> Self {
        // Source: https://getbootstrap.com/docs/4.0/content/images/#aligning-images
        switch horizontalAlignment {
        case .leading:
            return self.class("rounded float-left")
        case .center:
            return self.class("rounded mx-auto d-block")
        case .trailing:
            return self.class("rounded float-right")

        }
    }
}
