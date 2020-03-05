//
//  TableResources.swift
//  Goldbar
//
//  Created by Joel Ashworth on 2020-02-19.
//  Copyright © 2020 Joel Ashworth. All rights reserved.
//

import Foundation

enum tableNameEnum : String {
	
	case Student = "STUDENT"
	case Class = "CLASS"
	case Professor = "PROFESSOR"
	case ClassRegistration = "CLASSREGISTRATION"
}

enum fieldNameEnum : String {
	
	case Student_ID = "STUDENT.ID"
	case Student_FirstName = "STUDENT.FIRSTNAME"
	case Student_LastName = "STUDENT.LASTNAME"
	case Student_Major = "STUDENT.MAJOR"
	
	case Class_ID = "CLASS.ID"
	case Class_Code = "CLASS.CODE"
	case Class_Name = "CLASS.NAME"
	case Class_Description = "CLASS.DESCRIPTION"
	case Class_ProfessorID = "CLASS.PROFESSORID"
	
	case Professor_ID = "PROFESSOR.ID"
	case Professor_FirstName = "PROFESSOR.FIRSTNAME"
	case Professor_LastName = "PROFESSOR.LASTNAME"
	case Professor_TenureDate = "PROFESSOR.TENUREDATE"
	
	case ClassRegistration_ID = "CLASSREG.ID"
	case ClassRegistration_StudentID = "CLASSREG.STUDENTID"
	case ClassRegistration_Semester = "CLASSREG.SEMESTER"
	case ClassRegistration_ClassID = "CLASSREG.CLASSID"
	
}


struct TableResources {
	
	func getAllTableDDL() -> [TableDDL] {
		var List : [TableDDL] = []
		
		List.append(getTableDDL(.Class))
		List.append(getTableDDL(.ClassRegistration))
		List.append(getTableDDL(.Professor))
		List.append(getTableDDL(.Student))
		
		return List
		
	}
	
	
	func getTableDDL(_ tableName : tableNameEnum) -> TableDDL  {
		
		switch tableName {
//		case .Student :
//			return TableDDL(Name: .Student, PK: .Student_ID,  Fields: [lookupFieldDDL(.Student_ID),
//												     lookupFieldDDL(.Student_FirstName),
//												     lookupFieldDDL(.Student_LastName),
//												     lookupFieldDDL(.Student_RegistrationDate)])
			
		case .Student :
		return TableDDL(Name: .Student, PK: .Student_ID,  Fields: [lookupFieldDDL(.Student_ID),
											     lookupFieldDDL(.Student_FirstName),
											     lookupFieldDDL(.Student_LastName),
											     lookupFieldDDL(.Student_Major)])
		case .Professor :
			return TableDDL(Name: .Professor, PK: .Professor_ID , Fields: [lookupFieldDDL(.Professor_ID),
													   lookupFieldDDL(.Professor_LastName),
													   lookupFieldDDL(.Professor_FirstName),
													   lookupFieldDDL(.Professor_TenureDate)])
			
			
		case .Class :
			return TableDDL(Name: .Class,
					    PK: .Class_ID,
					    FK: [ForeignKey(Name: .Class_ProfessorID, ToTable: .Professor, ToField: .Professor_ID, Relationship: .ManyToOne)],
					    Fields: [lookupFieldDDL(.Class_ID),
									   lookupFieldDDL(.Class_Code),
									   lookupFieldDDL(.Class_Name),
									   lookupFieldDDL(.Class_Description),
									   lookupFieldDDL(.Class_ProfessorID)])
			
		case .ClassRegistration :
			return TableDDL(Name: .ClassRegistration,
					    PK: .ClassRegistration_ID,
					    FK: [ForeignKey(Name: .ClassRegistration_StudentID, ToTable: .Student, ToField: .Student_ID, Relationship: .ManyToOne),
						   ForeignKey(Name: .ClassRegistration_ClassID, ToTable: .Class, ToField: .Class_ID , Relationship: .OneToOne)],
					    Fields: [lookupFieldDDL(.ClassRegistration_ID),
											   lookupFieldDDL(.ClassRegistration_ClassID),
											   lookupFieldDDL(.ClassRegistration_Semester),
											   lookupFieldDDL(.ClassRegistration_StudentID)])
			
		}
	}
	
	func lookupFieldDDL(_ fieldName : fieldNameEnum) -> FieldDDL {
		
		var returnValue : FieldDDL
		
		switch fieldName {
		case .Student_ID : returnValue = FieldDDL(FieldEnum: .Student_ID, SQLDataType: .INTEGER)
		case .Student_FirstName : returnValue = FieldDDL(FieldEnum: .Student_FirstName, SQLDataType: .TEXT)
		case .Student_LastName : returnValue = FieldDDL(FieldEnum: .Student_LastName, SQLDataType: .TEXT)
		case .Student_Major : returnValue = FieldDDL(FieldEnum: .Student_Major, SQLDataType: .TEXT)
			
		case .Professor_ID : returnValue = FieldDDL(FieldEnum: .Professor_ID, SQLDataType: .INTEGER)
		case .Professor_LastName : returnValue = FieldDDL(FieldEnum: .Professor_LastName, SQLDataType: .TEXT)
		case .Professor_FirstName : returnValue = FieldDDL(FieldEnum: .Professor_FirstName, SQLDataType: .TEXT)
		case .Professor_TenureDate : returnValue = FieldDDL(FieldEnum: .Professor_TenureDate, SQLDataType: .TEXT)
			
		case .Class_ID : returnValue = FieldDDL(FieldEnum: .Class_ID, SQLDataType: .INTEGER)
		case .Class_Code : returnValue = FieldDDL(FieldEnum: .Class_Code, SQLDataType: .INTEGER)
		case .Class_Name : returnValue = FieldDDL(FieldEnum: .Class_Name, SQLDataType: .TEXT)
		case .Class_Description : returnValue = FieldDDL(FieldEnum: .Class_Description, SQLDataType: .TEXT)
		case .Class_ProfessorID : returnValue = FieldDDL(FieldEnum: .Class_ProfessorID, SQLDataType: .INTEGER)
			
		case .ClassRegistration_ID : returnValue = FieldDDL(FieldEnum: .ClassRegistration_ID, SQLDataType: .INTEGER)
		case .ClassRegistration_ClassID : returnValue = FieldDDL(FieldEnum: .ClassRegistration_ClassID, SQLDataType: .INTEGER)
		case .ClassRegistration_Semester : returnValue = FieldDDL(FieldEnum: .ClassRegistration_Semester, SQLDataType: .TEXT)
		case .ClassRegistration_StudentID : returnValue = FieldDDL(FieldEnum: .ClassRegistration_StudentID, SQLDataType: .INTEGER)
		
		}
		return returnValue
	}
}
