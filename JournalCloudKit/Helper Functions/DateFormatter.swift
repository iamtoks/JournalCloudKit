//
//  DateFormatter.swift
//  JournalCloudKit
//
//  Created by adetokunbo babatunde on 7/21/20.
//  Copyright © 2020 adetokunbo babatunde. All rights reserved.
//

import Foundation

extension Date {
    func formatAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
