//
//  PlainFileService.swift
//  Goldbar
//
//  Created by Joel Ashworth on 2020-01-20.
//  Copyright © 2020 Joel Ashworth. All rights reserved.
//

import Foundation


func saveTextFileToDocumentsDirectory(FileContents : String, FileName: String, FileExtension : String) {
    
    let fullFileName = FileName + "." + FileExtension
    let filename = getDocumentsDirectory().appendingPathComponent(fullFileName)
    
    do {
	  try FileContents.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
	  print ("worked")
    } catch {
	  print("Something went wrong trying to write testing.txt file.")
    }
}

func getDocumentsDirectory()-> URL {
    
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
    
}

func FileExistsInDocumentDirectory(FileName: String, FileExtension: String) -> Bool {
	var returnValue : Bool
	
	let filemgr = FileManager.default
	
	let databasePath = GetFilePathForFileInDocumentDirectory(FileName: FileName, FileExtension: FileExtension)
	
	if !filemgr.fileExists(atPath: databasePath) { returnValue = false } else { returnValue = true }
	
	return returnValue
}

func GetFilePathForFileInDocumentDirectory(FileName: String, FileExtension: String) -> String {
	
	let filemgr = FileManager.default
	let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
			
	let databasePath = dirPaths[0].appendingPathComponent(FileName + FileExtension).path
	
	return databasePath
	
}

func GetApplicationDatabasePath() -> String {
	
	let filemgr = FileManager.default
	let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
			
	let databasePath = dirPaths[0].appendingPathComponent("AncestryMyHeritage.db").path
	
	return databasePath
	
}
