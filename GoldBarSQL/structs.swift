//
//  structs.swift
//  Goldbar
//
//  Created by Joel Ashworth on 2020-02-19.
//  Copyright © 2020 Joel Ashworth. All rights reserved.
//

import Foundation

enum SQLiteDataType {
	case TEXT
	case NUMERIC
	case INTEGER
	case REAL
	case BLOB
}





struct FlexibleField {
	var name : String
	var datavalue : String
	
}

struct FlexibleRecord  {
	var Field : [FlexibleField]
	
}

struct FieldDDL  {
	var FieldEnum : fieldNameEnum
	var SQLDataType : SQLiteDataType
}

struct TableDefinition {
	var Name : String
	
	var Fields : [FieldDDL]
}

struct FlexibleTable {
	
	var Record : [FlexibleRecord]
	var Name : String
	var Definition : TableDefinition
	
}

struct TableDDL {
	var Name : tableNameEnum
	var PK : fieldNameEnum
	var FK : [ForeignKey]?
	var Fields : [FieldDDL]
}

struct ForeignKey {
	var Name : fieldNameEnum
	var ToTable : tableNameEnum
	var ToField : fieldNameEnum
	var Relationship : TableRelationshipEnum
}

enum TableRelationshipEnum {
	case OneToOne
	case ManyToOne
}

