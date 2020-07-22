//
//  Entry.swift
//  JournalCloudKit
//
//  Created by adetokunbo babatunde on 6/29/20.
//  Copyright © 2020 adetokunbo babatunde. All rights reserved.
//

import Foundation
import CloudKit

struct EntryConstants {
    static let recordKeyType = "Entry"
    static let titleKey = "title"
    static let bodyKey = "body"
    static let timestampKey = "timestamp"
}

class Entry {
    var title: String
    var body: String
    var timestamp: Date
    var ckRecordID: CKRecord.ID
    
    init(title: String, body: String, timestamp: Date = Date(), ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }
}

extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: EntryConstants.recordKeyType)
        
        self.setValuesForKeys([
            EntryConstants.bodyKey : entry.body,
            EntryConstants.titleKey : entry.title,
            EntryConstants.timestampKey : entry.timestamp
        
        ])
    }
}

extension Entry {
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryConstants.titleKey] as? String, let body = ckRecord[EntryConstants.bodyKey] as? String, let timestamp = ckRecord[EntryConstants.timestampKey] as? Date else {return nil}
        
        self.init(title : title, body : body, timestamp : timestamp)
    }
}
