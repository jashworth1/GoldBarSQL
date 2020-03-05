//
//  VCStudentDataAddOrEdit.swift
//  Goldbar
//
//  Created by Joel Ashworth on 2020-02-27.
//  Copyright © 2020 Joel Ashworth. All rights reserved.
//

import UIKit


class VCStudentDataAddOrEdit : UIViewController {
	@IBOutlet weak var FirstName: UITextField!
	@IBOutlet weak var LastName: UITextField!
	@IBOutlet weak var Major: UITextField!
	@IBOutlet weak var IDValue: UILabel!
	@IBOutlet weak var AddOrUpdateButton: UIButton!
	
	var StudentID : Int64?
	var previousViewController : ViewControllers?
	
	var originalFirstName : String?
	var originalLastName : String?
	var originalMajor : String?
	var originalID : Int64?
	var displayID : String?
	
	
	var labelForAddOrUpdateButton : String = "Add"
	
	override func viewDidLoad() {
		FirstName.text = originalFirstName
		LastName.text = originalLastName
		Major.text = originalMajor
		
		if let unwrappedOriginalID = originalID {
			originalID = unwrappedOriginalID
			displayID = String(unwrappedOriginalID)
		} else {
			displayID = "NA"
		}
		
		IDValue.text = displayID
	
		
		
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
			AddOrUpdateButton.setTitle(labelForAddOrUpdateButton, for: .normal)
	
	}

	
	@IBAction func AddButton(_ sender: Any) {
		
		let StudentTblDataManipulation = StudentTableDataManipulation()
		
		if labelForAddOrUpdateButton == "Add" {
			
			StudentTblDataManipulation.insert(firstName: FirstName.text ?? "", lastName: LastName.text ?? "", Major: Major.text ?? "")
			
			self.dismiss(animated: true, completion: {
				NotificationCenter.default.post(name: .ViewControllerTableRefresh, object: nil)
				
			})
		} else if labelForAddOrUpdateButton == "Commit Edit" {
			
			StudentTblDataManipulation.update(forID: originalID!, firstName: FirstName.text ?? "", lastName: LastName.text ?? "", Major: Major.text ?? "")
			
			self.dismiss(animated: true, completion: {
			NotificationCenter.default.post(name: .ViewControllerTableRefresh, object: nil)
		})
		}
	}
	
	
	@IBAction func ExitButton(_ sender: Any) {
		
		self.dismiss(animated: true, completion: nil)
	}
		
	func FilloutTextBoxWithExistingData(StudentRec : StudentRecord) {
		
		originalFirstName = StudentRec.FirstName
		originalLastName = StudentRec.LastName
		originalMajor = StudentRec.Major
		originalID = StudentRec.ID
		
		labelForAddOrUpdateButton = "Commit Edit"

	}
}
