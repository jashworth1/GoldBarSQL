//
//  FMResultProcessing.swift
//  Goldbar
//
//  Created by Joel Ashworth on 2020-02-24.
//  Copyright © 2020 Joel Ashworth. All rights reserved.
//

import Foundation
import FMDB

class FMResultProcessing {
	
	
	func ConvertResultsToStudentRecords(ResultSet : FMResultSet) -> StudentRecords {
		var StudentRecordArray : [StudentRecord] = []
		print("Started EncodeStudentTableToJSON")
		let QRS = QueryResultSet(ResultSet: ResultSet)
		
		while QRS.NextRecord() == true {

			let FirstName = QRS.returnString(FieldName: .Student_FirstName)
			let LastName = QRS.returnString(FieldName: .Student_LastName)
			let StudentID = QRS.returnInt64(FieldName: .Student_ID)
			let Major = QRS.returnString(FieldName: .Student_Major)
			
			StudentRecordArray.append(StudentRecord(ID: StudentID!, FirstName: FirstName!, LastName: LastName!, Major: Major!))
		}
		
		let SetOfStudentRecords = StudentRecords(Array: StudentRecordArray)
		
		return SetOfStudentRecords
		
	}
	
	func EncodeStudentTableToJSON(InputData : StudentRecords) -> Data {
	
		let encodedJSON = try! JSONEncoder().encode(InputData)

		let printdata = String(data: encodedJSON, encoding: .utf8)
		print(printdata!)
		
		print("Ended EncodeStudentTableToJSON")
		
		return encodedJSON
		
		
	}
	

}
