// Copyright © 2024 Kyle Haptonstall. All rights reserved.

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
            self.class("rounded float-left")
        case .center:
            self.class("rounded mx-auto d-block")
        case .trailing:
            self.class("rounded float-right")
        }
    }
}
