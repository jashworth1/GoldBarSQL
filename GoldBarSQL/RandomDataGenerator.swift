//
//  RandomDataGenerator.swift
//  GoldBar_V2ForGithub
//
//  Created by Joel Ashworth on 2020-03-03.
//  Copyright © 2020 Joel Ashworth. All rights reserved.
//

import Foundation

struct RandomDataGenerator {
	
	func getRandomFirstName() -> String {
	
		let MostPopularBabyNames2019 = ["Liam","Noah","William","James","Oliver",
							  "Benjamin","Elijah","Lucas","Mason","Logan",
							  "Alexander","Ethan","Jacob","Michael","Daniel",
							  "Henry","Jackson","Sebastian","Aiden","Matthew",
							  "Samuel","David","Joseph","Carter","Owen",
							  "Wyatt","John","Jack","Luke","Jayden",
							  "Dylan","Grayson","Levi","Issac","Gabriel",
							  "Julian","Mateo","Anthony","Jaxon","Lincoln",
							  "Joshua","Christopher","Andrew","Theodore","Caleb",
							  "Ryan","Asher","Nathan","Thomas","Leo",
							  "Emma","Olivia","Ava","Isabella","Sophia",
							  "Charlotte","Mia","Amelia","Harper","Evelyn",
							  "Abigail","Emily","Elizabeth","Mila","Ella",
							  "Avery","Sofia","Camila","Aria","Scarlett",
							  "Victoria","Madison","Luna","Grace","Chloe",
							  "Penelope","Layla","Riley","Zoey","Nora",
							  "Lily","Elenor","Hannah","Lillian","Addison",
							  "Aubrey","Ellie","Stella","Natalie","Zoe",
							  "Leah","Hazel","Violet","Aurora","Savannah",
							  "Audrey","Brooklyn","Bella","Claire","Skylar"]

		
		let randomNumber = Int.random(in: 0...99)
		
		return MostPopularBabyNames2019[randomNumber]
		
	}
	
	func getRandomLastName() -> String {
		
		let MostCommonSurnamesInCanada = ["Smith","Brown","Tremblay","Martin","Roy",
							    "Wilson","Macdonald","Gagnon","Johnson","Taylor",
							    "Cote","Campbell","Anderson","Leblanc","Lee",
							    "Jones","White","Williams","Miller","Thompson",
							    "Gauthier","Young","Van","Morin","Bouchard",
							    "Scott","Stewart","Belanger","Reid","Pelletier",
							    "Moore","Lavoie","King","Robinson","Levesque",
							    "Murphy","Fortin","Gagne","Wong","Clark",
							    "Johnson","Clarke","Ross","Walker","Thomas",
							    "Boucher","Landry","Kelly","Bergeron","Davis",
							    "Mitchell","Murray","Poirier","Mcdonald","Richard",
							    "Wright","Girard","Lewis","Baker","Roberts",
							    "Simard","Graham","Caron","Harris","Jackson",
							    "Green","Beaulieu","Fraser","Fournier","Kennedy",
							    "Hall","Hill","Chan","Wood","Lapointe",
							    "Ouellet","Bell","Dube","Allen","Adams",
							    "Cloutier","Bennett","Lefebvre","Watson","Robertson",
							    "Walsh","Collins","Evans","Hebert","Hamilton",
							    "Cameron","Desjardins","Russell","Nadeau","Cook",
							    "Michaud","Morrison","Singh","Grant","Parsons"]
		
		let randomNumber = Int.random(in: 0...99)
		
		return MostCommonSurnamesInCanada[randomNumber]
	}
	
	func getRandomMajor() -> String {
		
		let popularMajors = ["Engineering","Computer Science","Biology","Physics","Business Administration","Communications","Fine Arts"]
		
		let randomNumber = Int.random(in: 0...6)
		
		return popularMajors[randomNumber]
		
		
	}
	
}
