//
//  QueryResultSet.swift
//  Goldbar
//
//  Created by Joel Ashworth on 2020-02-24.
//  Copyright © 2020 Joel Ashworth. All rights reserved.
//

import Foundation
import FMDB


struct QueryResultSet {
	
	var ResultSet : FMResultSet
	
	func NextRecord() -> Bool {
		return ResultSet.next()
	}
	
	private func getFieldName(_ field : fieldNameEnum) -> String {
		let fieldName = String(field.rawValue)
		let SplitFieldName = fieldName.split(separator: ".")
		let returnValue : String = String(SplitFieldName[1])
		
		return returnValue
		
	}
	
	func returnInt32(FieldName: fieldNameEnum) -> Int32? {
		var returnValue : Int32?
		returnValue = ResultSet.int(forColumn: getFieldName(FieldName))
		return returnValue
	}
	
	func returnInt64(FieldName: fieldNameEnum) -> Int64? {
		var returnValue : Int64?
		returnValue = ResultSet.longLongInt(forColumn: getFieldName(FieldName))
		return returnValue
	}
	
	func returnDouble(FieldName: fieldNameEnum) -> Double? {
		var returnValue : Double?
		returnValue = ResultSet.double(forColumn: getFieldName(FieldName))
		return returnValue
	}
	
	func returnString(FieldName: fieldNameEnum) -> String? {
		var returnValue : String?
		
		
		returnValue = ResultSet.string(forColumn: getFieldName(FieldName))
		return returnValue
	}
	
}
