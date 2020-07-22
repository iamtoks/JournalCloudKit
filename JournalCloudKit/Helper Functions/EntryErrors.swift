//
//  EntryErrors.swift
//  JournalCloudKit
//
//  Created by adetokunbo babatunde on 6/29/20.
//  Copyright © 2020 adetokunbo babatunde. All rights reserved.
//

import Foundation

enum EntryError: LocalizedError {
    case ckError(Error)
    case couldNotUnwrap
}
