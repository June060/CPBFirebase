//
//  DataView.swift
//  CPBFirebase
//
//  Created by James Howard on 11/10/23.
//

import SwiftUI
import FirebaseDatabaseSwift
import FirebaseDatabase


struct DataView: View {
    var college:College
    var body: some View {
        Text("COLLEGE NAME = \(college.name)")
        Text("LOCATION = \(college.location)")
        Text("NUMBER OF STUDENTS = \(college.numberOfStudents)")
        Text("URL = \(college.url)")
        
    }
}
