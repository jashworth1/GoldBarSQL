//
//  DatabaseCommand.swift
//  Goldbar
//
//  Created by Joel Ashworth on 2020-01-20.
//  Copyright © 2020 Joel Ashworth. All rights reserved.
//

import Foundation
import FMDB


class DatabaseCommand {
	
	var DatabaseDefinitionCls = TableResources()
	var SQLGenerator = SQLGeneratorForTable()
	var SQLiteDBPath : String
	var DatabaseConn : DatabaseConnection
	
	
	init(SQLiteDBFileName: String) {
		

		SQLiteDBPath = GetFilePathForFileInDocumentDirectory(FileName: SQLiteDBFileName, FileExtension: ".db")
		
			if FileExistsInDocumentDirectory(FileName: SQLiteDBFileName, FileExtension: ".db") == false {
				DatabaseConn = DatabaseConnection(Path: SQLiteDBPath)
				DatabaseConn.EnsureDatabaseFileExists()
			} else {
				DatabaseConn = DatabaseConnection(Path: SQLiteDBPath)
			}
		}

	func CreateAllTables() {

		let ListOfTableDefinitions = DatabaseDefinitionCls.getAllTableDDL()
		
		for Table in ListOfTableDefinitions {
			
			let SQLStmt = SQLGenerator.CreateTable(tableDefinition: Table)
			DatabaseConn.executeUpdate(SQL: SQLStmt)
			
		}
	}
	
	func getPath() -> String {
		
		return SQLiteDBPath
	}
	
	func executeSelectQuery(SQL: String, QueryOutputDefinition: TableDefinition) -> FlexibleTable? {

		return DatabaseConn.executeQuery(SQL: SQL, QueryOutputDefinition: QueryOutputDefinition)

	}
	
	
	
	
}
