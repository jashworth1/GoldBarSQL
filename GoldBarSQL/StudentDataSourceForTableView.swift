//
//  StudentDataSourceForTableView.swift
//  Goldbar
//
//  Created by Joel Ashworth on 2020-02-25.
//  Copyright © 2020 Joel Ashworth. All rights reserved.
//

import UIKit
import FMDB

protocol RowSelectionDelegate {
	func StudentWasSelected(StudentInfo: StudentRecord)
}

class StudentDataSourceForTableView : NSObject, UITableViewDataSource, UITableViewDelegate {
	
	var StudentDS = StudentDataSource()
	var Delegate : RowSelectionDelegate!
	
	override init() {

	}
	
	func loadData() {
		
		if StudentDS.Records.count > 0 { StudentDS.Records.removeAll()}
		
		let defaults = UserDefaults.standard
		let dbpath = defaults.string(forKey: "DatabasePath")!
			
		let FMResultProc = FMResultProcessing()
		let databaseConnection = DatabaseConnection(Path: dbpath)
		
		let SQL = "SELECT FIRSTNAME, ID, LASTNAME, MAJOR FROM STUDENT ORDER BY ID DESC"
			
		let QueryResultSet = databaseConnection.executeQueryForResultSet(SQL: SQL)
		let StudentRecs = FMResultProc.ConvertResultsToStudentRecords(ResultSet: QueryResultSet!)
		
		StudentDS = StudentDataSource()
		StudentDS.loadDataset(dataset: StudentRecs.Array)
			
		
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return StudentDS.Records.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
		let celltext = String(StudentDS.Records[indexPath.row].ID) + " " + StudentDS.Records[indexPath.row].FirstName + " " + StudentDS.Records[indexPath.row].LastName
		
		cell.textLabel?.text = celltext
		
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		let StudentID = StudentDS.Records[indexPath.row].ID
		let StudentFirstName = StudentDS.Records[indexPath.row].FirstName
		let StudentLastName = StudentDS.Records[indexPath.row].LastName
		let StudentMajor = StudentDS.Records[indexPath.row].Major
		
		Delegate.StudentWasSelected(StudentInfo: StudentRecord(ID: StudentID, FirstName: StudentFirstName, LastName: StudentLastName, Major: StudentMajor))
		
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		
		if editingStyle == .delete {

			let StudentTblDataManipulation = StudentTableDataManipulation()
			let ID = StudentDS.returnID(ofIndex: indexPath.row)
			
			StudentTblDataManipulation.delete(whereID: ID )
			StudentDS.deleteRecord(byRow: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .left)
			
		}
	}
	
}



