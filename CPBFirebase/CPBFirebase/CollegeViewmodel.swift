//
//  CollegeViewmodel.swift
//  CPBFirebase
//
//  Created by James Howard on 11/6/23.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class TaskViewmodel: ObservableObject {
    @Published var colleges:[College] = []
    let db = Database.database().reference()
    init(){
        PullFromFirebase()
    }
    func AddCollege(currentCollege:College){
        colleges.append(currentCollege)
        AddToFirebase(college: currentCollege)
    }
    func AddToFirebase(college:College){
        let collegeRef = db.child("Colleges").child(college.name)
        collegeRef.child("Location").setValue(college.location)
        collegeRef.child("URL").setValue(college.url)
        collegeRef.child("Number of students").setValue(college.numberOfStudents)
    }
    func PullFromFirebase(){
        let databaseRef = db.child("Colleges")
        databaseRef.getData{ myError, myDataSnapshot in
            var newList:[College] = []
            for college in myDataSnapshot?.children.allObjects as! [DataSnapshot]{
                let nameOfCollege = college.key
                let dictionary = college.value as! [String:Any]
                guard let location = dictionary["Location"] else {return}
                guard let URL = dictionary["URL"] else {return}
                guard let numStudents = dictionary["Number of students"] else {return}
                
                let currentCollege =  College(name: nameOfCollege, url: URL as! String, location: location as! String,numberOfStudents: numStudents as! Int)
                newList.append(currentCollege)
            }
            self.colleges = newList
        }
    }
}
