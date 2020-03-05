//
//  DatabaseQue.swift
//  Goldbar
//
//  Created by Joel Ashworth on 2020-02-21.
//  Copyright © 2020 Joel Ashworth. All rights reserved.
//

import Foundation

struct SQLRequest {
	var SQL : String
	var Parameters : [String:Any]
}

enum DatabaseQueOnError {
	case retry
	case discard
	case sendToBackOfQue
}

class DatabaseQue {
    static let sharedInstance = DatabaseQue()

    var Que : [[SQLRequest]] = []
    var onError : DatabaseQueOnError = .retry
    
    private var suspendPoke : Bool = false
	
    private init() { }

	func PrintStatus() {
		
		print("Que has \(Que.count) que sets !")
		
		for (index,x) in Que.enumerated() {
			print("Que at \(index) - currently has \(x.count) statments in it.")
		}
	}
	
	func AddToQue(_ NewSQLRequest : SQLRequest) {
		
		Que.append([NewSQLRequest])
		
		PokeExecutor_IfOn()
		
	}
	
	func AddSetToQue(_ NewArraySQLRequests : [SQLRequest]) {
		
		Que.append(NewArraySQLRequests)
		
		PokeExecutor_IfOn()
	}
	
	func SetOnErrorBehavior(_ OnErrorBehaviour : DatabaseQueOnError) {
		
		onError = OnErrorBehaviour
	}
	
	func GetNextSet() -> [SQLRequest]? {
		
		var returnValue : [SQLRequest]?
		
		if Que.count > 0 { returnValue = Que[0] }
		
		return returnValue
	}
	
	func ErrorExecutingFirstInQue() {
		
		print("ERROR Detected")
		
		switch onError {
			
		case .discard :
			
			Que.removeFirst()
			PokeExecutor_IfOn()
			
		case .retry :
			
			PokeExecutor_IfOn()
			
		case .sendToBackOfQue :
			
			let FirstSQLRequest = Que.removeFirst()
			Que.append(FirstSQLRequest)
			
			PokeExecutor_IfOn()
			
		}
	}
	
	func successExecutingFirstInQue() {

		Que.removeFirst()
		print("After removing successfully added data we have a Que.count = \(Que.count)")
		PokeExecutor_IfOn()
		
	}
	
	func PokeExecutor_IfOn() {
	
		if suspendPoke == false && Que.count > 0 {
			
			NotificationCenter.default.post(name: .QueHasData, object: nil)
		
	}
	}
	
	func PokeExecutor() {
		if Que.count > 0 { Executor.sharedInstance.Poke() }
	}
	
	func turnOFFPokeExecutor() {
		
		suspendPoke = true
	}
	
	func turnONPokeExecutor() {
		suspendPoke = false
	}
	
	func ensureInitialization() {
		
		
	}
	
}

