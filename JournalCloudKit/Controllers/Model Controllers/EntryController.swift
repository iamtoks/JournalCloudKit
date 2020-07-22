//
//  EntryController.swift
//  JournalCloudKit
//
//  Created by adetokunbo babatunde on 6/29/20.
//  Copyright © 2020 adetokunbo babatunde. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    // MARK: - Shared Instance
    static let shared = EntryController()
    
    // MARK: - Source Of Truth
    var entries: [Entry] = []
    
    // MARK: - Public Cloud Databse
    let privateDB = CKContainer.default().privateCloudDatabase
    
    // MARK: - CRUD Methods
    
    // Create
    func createEntryWith(title: String, body: String, completion: @escaping(_ result: Result<Entry?, EntryError>) -> Void) {
        
        let newEntry = Entry(title: title, body: body)
        
        return completion(.success(newEntry))
    }
    
    func save(entry: Entry, completion: @escaping(_ result: Result<Entry?, EntryError>) -> Void) {
        
        let entryRecord = CKRecord(entry: entry)
        privateDB.save(entryRecord) { (record, error) in
            if let error = error {
                print("There was an error saving the entry")
                return completion(.failure(.ckError(error)))
            }
            
            guard let record = record, let saveEntry = Entry(ckRecord: record) else {return completion(.failure(.couldNotUnwrap))}
            
            print("Entry Saved Successfully")
            
            self.entries.append(saveEntry)
            return completion(.success(saveEntry))
            
        }
    }
    // Read
    func fetchEntriesWith(completion: @escaping(_ result: Result<[Entry]?, EntryError>) -> Void) {
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: EntryConstants.recordKeyType, predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            
            if let error = error {
                print("There was an error fetching all the Entries - \(error) - \(error.localizedDescription)")
                return completion(.failure(.ckError(error)))
            }
            
            guard let records = records else {return completion(.failure(.couldNotUnwrap))}
            
            let fetchedEntries = records.compactMap {Entry(ckRecord: $0)}
            
            completion(.success(fetchedEntries))
        }
    }
    
    // Update
    
    
    // Delete
    
}
