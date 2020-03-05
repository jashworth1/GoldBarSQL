//
//  DataManipulationResources.swift
//  Goldbar
//
//  Created by Joel Ashworth on 2020-02-19.
//  Copyright © 2020 Joel Ashworth. All rights reserved.
//

import Foundation

enum DataManipulation_SQL {
	case InsertStudentRecord
	case DeleteStudentRecord
	case UpdateStudentRecord
	
}


class StudentTableDataManipulation {
	
	func delete(whereID : Int64) {
		let paramDict : [String:Any] = ["ID":whereID]
		let SQL = "DELETE FROM STUDENT WHERE ID = :ID"
		let deleteRequest = SQLRequest(SQL: SQL, Parameters: paramDict)
		
		DatabaseQue.sharedInstance.AddSetToQue([deleteRequest])
		
	}
	
	func insert(firstName: String, lastName : String, Major : String) {
		
		let paramDict : [String:Any] = ["FIRSTNAME":firstName,"LASTNAME":lastName,"MAJOR":Major]
		let SQL_Stmt = "INSERT INTO STUDENT (FIRSTNAME, LASTNAME, MAJOR) VALUES (:FIRSTNAME,:LASTNAME,:MAJOR)"
		
		let insertRequest = SQLRequest(SQL: SQL_Stmt, Parameters: paramDict)
		
		DatabaseQue.sharedInstance.AddSetToQue([insertRequest])
		
	}
	
	func getInsertSQLRequest(firstName: String, lastName : String, Major : String) -> SQLRequest {
			let paramDict : [String:Any] = ["FIRSTNAME":firstName,"LASTNAME":lastName,"MAJOR":Major]
			let SQL_Stmt = "INSERT INTO STUDENT (FIRSTNAME, LASTNAME, MAJOR) VALUES (:FIRSTNAME,:LASTNAME,:MAJOR)"
			let insertRequest = SQLRequest(SQL: SQL_Stmt, Parameters: paramDict)
			
		     return insertRequest
			
		}
	
	func update(forID: Int64, firstName: String, lastName: String, Major: String) {
		let paramDict : [String:Any] = ["FIRSTNAME":firstName,"LASTNAME":lastName,"MAJOR":Major,"ID":forID]
		let SQL_Stmt = "UPDATE STUDENT SET FIRSTNAME = :FIRSTNAME,LASTNAME = :LASTNAME,MAJOR = :MAJOR WHERE ID = :ID"
		let updateRequest = SQLRequest(SQL: SQL_Stmt, Parameters: paramDict)
		
		DatabaseQue.sharedInstance.AddSetToQue([updateRequest])
		
	}
	
}
