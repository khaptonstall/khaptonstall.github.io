//
//  DateFormatter+Convenience.swift
//  
//
//  Created by Kyle Haptonstall on 4/2/24.
//

import Foundation

extension DateFormatter {
    /// A date formatted used for published dates of articles. Formats dates in the style “November 23, 1937”.
    static let articleDateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
}
