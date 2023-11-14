//
//  ContentView.swift
//  CPBFirebase
//
//  Created by James Howard on 10/19/23.
//

import SwiftUI
import FirebaseDatabaseSwift
import FirebaseDatabase

struct ContentView: View {
    @ObservedObject var viewModel = TaskViewmodel()
    @State var enteredName = ""
    @State var enteredLocation = ""
    @State var enteredUrl = ""
    @State var enteredNumStu = 0

    @State var showAlert = false
    var body: some View {
        NavigationStack{
            List{
                ForEach(viewModel.colleges, id: \.name){ currentCollege in
                    NavigationLink(destination: DataView(college: currentCollege)) {
                        Text(currentCollege.name)
                    }

                }
                
            }
            .toolbar {
                Button("Add college"){
                    showAlert.toggle()
                }
                .alert("Add College", isPresented: $showAlert) {
                    
                    TextField("Name of college", text: $enteredName)
                    TextField("Enter a url", text: $enteredUrl)
                    TextField("Enter a location", text: $enteredLocation)
                    TextField("Number of students", value: $enteredNumStu, format: .number)
                    Button {
                        var newCollege  = College(name: enteredName, url: enteredUrl, location: enteredLocation, numberOfStudents: enteredNumStu)
                        viewModel.AddCollege(currentCollege: newCollege)
                        showAlert.toggle()
                        enteredName = ""
                        enteredUrl = ""
                        enteredLocation = ""
                        enteredNumStu = 0
                    } label: {
                        Text("Add College")
                    }

                }
            }
            
        }
        .navigationTitle("ToDoFirebase")
        
    }
}

#Preview {
    ContentView()
}
