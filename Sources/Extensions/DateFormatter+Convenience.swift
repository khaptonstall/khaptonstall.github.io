// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation

extension DateFormatter {
    /// A date formatted used for published dates of articles. Formats dates in the style “November 23, 1937”.
    static let articleDateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
}
