//
//  DatabaseConnection.swift
//  Goldbar
//
//  Created by Joel Ashworth on 2020-01-20.
//  Copyright © 2020 Joel Ashworth. All rights reserved.
//

import Foundation
import FMDB

class DatabaseConnection {
	
	private var DatabasePath : String
	private var SQLiteDatabase : FMDatabase
	
	init(Path: String) {
		DatabasePath = Path
		SQLiteDatabase = FMDatabase(path: Path)
		
	}
	
	func OpenConnection() {
		SQLiteDatabase.open()
	}
	
	func CloseConnection() {
		
		SQLiteDatabase.close()
	}
	
	func EnsureDatabaseFileExists() {
		SQLiteDatabase.open()
		SQLiteDatabase.close()
	}
	
	
	func executeUpdate(SQL : String) {
		
		self.OpenConnection()
		
		SQLiteDatabase.executeUpdate(SQL, withArgumentsIn: [])
		
		self.CloseConnection()
	}
	
	func executeUpdateWParameters(SQL : String, Parameters: [String:Any]) -> Bool {
		
		var returnValue : Bool
		
		self.OpenConnection()
		
		returnValue = SQLiteDatabase.executeUpdate(SQL, withParameterDictionary: Parameters)
	
		self.CloseConnection()
		
		return returnValue
	}
	
	
	func executeQueryForResultSet(SQL : String) -> FMResultSet? {
		var returnResultSet : FMResultSet?
		
		self.OpenConnection()

		do {
			returnResultSet = try SQLiteDatabase.executeQuery(SQL, values: nil)
		} catch {
			print("Error : \(error.localizedDescription)")
		}
		
		return returnResultSet
		
	}
	
	
	func executeQuery(SQL : String, QueryOutputDefinition : TableDefinition) -> FlexibleTable? {

		var FTable : FlexibleTable?
		
		var ListOfRecords : [FlexibleRecord] = []
		var FieldBuffer : [FlexibleField] = []
		
		self.OpenConnection()
		
		do {
			let results:FMResultSet? = try SQLiteDatabase.executeQuery(SQL, values: nil)
			print(results?.columnCount)
			while results?.next() == true {

				for (index, f) in QueryOutputDefinition.Fields.enumerated() {
					var fieldValueInString : String = ""
					if f.SQLDataType == .INTEGER { let fieldvalue = (results?.int(forColumn: f.FieldEnum.rawValue) ?? 999999)
						let Buffer = FlexibleField(name: f.FieldEnum.rawValue, datavalue: String(fieldvalue))
						FieldBuffer.append(Buffer)
					}
					if f.SQLDataType == .NUMERIC { let fieldvalue = (results?.int(forColumn: f.FieldEnum.rawValue) ?? 999999)
						let Buffer = FlexibleField(name: f.FieldEnum.rawValue, datavalue: String(fieldvalue))
						FieldBuffer.append(Buffer)
					}
					if f.SQLDataType == .TEXT { let fieldvalue = (results?.string(forColumn: f.FieldEnum.rawValue) ?? "")
						let Buffer = FlexibleField(name: f.FieldEnum.rawValue, datavalue: fieldvalue)
						FieldBuffer.append(Buffer)
					}
					
					
				}
				let RecordBuffer = FlexibleRecord(Field: FieldBuffer)
				ListOfRecords.append(RecordBuffer)
				FieldBuffer.removeAll()
				
			}
			FTable = FlexibleTable(Record: ListOfRecords, Name: "Temp", Definition: QueryOutputDefinition)
			
			
		} catch {
			print("Error: \(error.localizedDescription)")
		
		}

		self.CloseConnection()

		return FTable
	}
	
	
	func executeQueryUsingDictionaryParameters(SQL: String, Parameters: [String:Any]) {
			let defaults = UserDefaults.standard
		      let DatabasePath = defaults.string(forKey: "DatabasePath")
			
		let Database = FMDatabase(path: DatabasePath)
			
		self.OpenConnection()
		self.CloseConnection()
		

		}
	
}


