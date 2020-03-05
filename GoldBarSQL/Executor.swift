//
//  Executor.swift
//  Goldbar
//
//  Created by Joel Ashworth on 2020-02-21.
//  Copyright © 2020 Joel Ashworth. All rights reserved.
//

import Foundation

enum exectuorStatus {
	case Busy
	case Free
}

class Executor {
	
	static let sharedInstance = Executor()
	var status : exectuorStatus = .Free
	
	var DatabaseConn : DatabaseConnection
	
	private init() {
		
		let defaults = UserDefaults.standard
		let databasePath = defaults.string(forKey: "DatabasePath")
		
		DatabaseConn = DatabaseConnection(Path: databasePath!)
		
		NotificationCenter.default.addObserver(self, selector: #selector(ExecutePoke), name: .QueHasData, object: nil)
		print("Executor has been initialized !!!")
	}
	
	func run(after seconds : Int, completion: @escaping () -> Void) {
		let deadline = DispatchTime.now() + .seconds(seconds)
		DispatchQueue.main.asyncAfter(deadline: deadline) {
			completion()
		}
		
	}
	
	
	func ExecuteNextSet() {
		status = .Busy
		
		run(after: 0) {
			var numberOfErrors : Int = 0
			
			
			if let NextSQLQue = DatabaseQue.sharedInstance.GetNextSet() {
				
				for (index,NextSQLRequest) in NextSQLQue.enumerated() {
					
					if self.DatabaseConn.executeUpdateWParameters(SQL: NextSQLRequest.SQL, Parameters: NextSQLRequest.Parameters) == false {
						
						numberOfErrors += 1
			
					}
				}
				
				if numberOfErrors > 0 {
					self.status = .Free
					DatabaseQue.sharedInstance.ErrorExecutingFirstInQue()
					
				} else {
					self.status = .Free
					DatabaseQue.sharedInstance.successExecutingFirstInQue()
				}
				
			}
			NotificationCenter.default.post(name: .ViewControllerTableRefresh, object: nil)
		}
		
		
		print("should have refreshed !")
			
	}
	
	func Poke() {
		
		if status == .Free { ExecuteNextSet() }
		
	}
	
	@objc func ExecutePoke() {
		
		self.Poke()
		
	}
	
	func ensureInitialization() {
		
	}
	
	
}
