//
//  SQLGenerator.swift
//  Goldbar
//
//  Created by Joel Ashworth on 2020-01-20.
//  Copyright © 2020 Joel Ashworth. All rights reserved.
//

import Foundation



class SQLGeneratorForTable {
	
	func SELECTFromTableDefinition(tableDefinition : TableDefinition) -> String {
		var FieldNames : [String] = []
		
		let AllFields = tableDefinition.Fields
		
		for thisField in AllFields {
			FieldNames.append(thisField.FieldEnum.rawValue)
		}
		
		var SQL : String = "SELECT "
		
		for (index,_) in FieldNames.enumerated() {
			
			if index < FieldNames.count-1 { SQL += FieldNames[index] + ", " } else { SQL += FieldNames[index]  }
		}
		
		SQL += " FROM \(tableDefinition.Name)"

		return SQL
		
	}

	func CreateTable(tableDefinition : TableDDL) -> String {
		var FieldNames : [String] = []
		var FieldTypes : [String] = []
		var PrimaryKeyDataTypeENUM : SQLiteDataType?
		var PrimaryKeyDataType : String
		var PrimaryKeyName : String

		PrimaryKeyDataTypeENUM = .INTEGER
		let PrimaryKeyNameRawValue = tableDefinition.PK.rawValue.split(separator: ".")
		PrimaryKeyName = String(PrimaryKeyNameRawValue[1])
			
		let AllFields = tableDefinition.Fields

		for thisField in AllFields {
			FieldNames.append(thisField.FieldEnum.self.rawValue)

			switch thisField.SQLDataType {

			case .TEXT:
				FieldTypes.append("TEXT")
			case .NUMERIC:
				FieldTypes.append("NUM")
			case .BLOB:
				FieldTypes.append("BLOB")
			case .INTEGER:
				FieldTypes.append("INT")
			case .REAL:
				FieldTypes.append("REAL")
			}
		}

		if let PrimaryKeyDataTypeENUM = PrimaryKeyDataTypeENUM {

			switch PrimaryKeyDataTypeENUM {
			case .TEXT:
				PrimaryKeyDataType = "TEXT"
			case .INTEGER:
				PrimaryKeyDataType = "INTEGER"
			case .NUMERIC:
				PrimaryKeyDataType = "NUMERIC"
			case .BLOB:
				PrimaryKeyDataType = "BLOB"
			case .REAL:
				PrimaryKeyDataType = "REAL"
			}

		} else {
			PrimaryKeyDataType = "INTEGER"
		}

		var SQL : String = "CREATE TABLE IF NOT EXISTS \(tableDefinition.Name.rawValue) ("

		SQL += PrimaryKeyName + " " + PrimaryKeyDataType + " PRIMARY KEY"

		for (index, fieldName) in FieldNames.enumerated() {
			let SplitFieldName = fieldName.split(separator: ".")
			
			if PrimaryKeyName != SplitFieldName[1] {
		
			
			SQL += ", " + SplitFieldName[1] + " " + FieldTypes[index]
			}
		}

		SQL = SQL + ")"

		return SQL
	}

	func getDataValueByFieldName(FieldName : String, FlexibleRecord: FlexibleRecord) -> String? {
		var returnValue : String?


		for afield in FlexibleRecord.Field {
			if afield.name == FieldName { returnValue = afield.datavalue }
		}


		return returnValue

	}

}

