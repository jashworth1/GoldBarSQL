//
//  StudentDataSource.swift
//  Goldbar
//
//  Created by Joel Ashworth on 2020-02-24.
//  Copyright © 2020 Joel Ashworth. All rights reserved.
//

import Foundation


struct StudentRecords : Codable {
	var Array : [StudentRecord]
}

struct StudentRecord : Codable {
	var ID : Int64
	var FirstName : String
	var LastName : String
	var Major : String
}

class StudentDataSource {
	var Records : [StudentRecord] = []
	
	func loadDataset(dataset: [StudentRecord]) {
		
			Records = dataset
	}
	
	func refreshRecords(newRecords: [StudentRecord]) {
		
		Records = newRecords
	}
	
	func addNewRecord(_ newRecord: StudentRecord) {
		Records.append(newRecord)
	}
	
	func insertNewRecord(atIndex: Int, newRecord : StudentRecord) {
		Records.insert(newRecord, at: atIndex)
	}
	
	func updateRecord(ByID : Int64, UpdatedRec : StudentRecord) {
		if let RecordIndex = findIndex(ForID: ByID) {
			Records.remove(at: RecordIndex)
			
			if RecordIndex > 0 {
				Records.insert(UpdatedRec, at: RecordIndex - 1)
			} else {
				Records.insert(UpdatedRec, at: 0)
			}
		}
	}
	
	
	func deleteRecord(byRow: Int) {
		
		Records.remove(at: byRow)
		
	}
	
	func returnID(ofIndex : Int) -> Int64 {
		
		return Records[ofIndex].ID
	}
	
	
	func findIndex(ForID : Int64) -> Int? {
		var returnValue : Int?
		
		for (index, Record) in Records.enumerated() {
			if Record.ID == ForID { returnValue = index }
		}
		
	return returnValue
	}
	
	
	

	
}
