//
//  ContentView.swift
//  planner
//
//  Created by ISSD on 26/09/2021.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var taskStore = TaskStore()
    @State var newToDo : String = ""
    
    var searchBar : some View {
        HStack{
            TextField("Enter in a new task", text: self.$newToDo)
            Button(action: self.addNewToDo, label: {
                Text("Add New")
            })
        }
    }
    
    
                func addNewToDo(){
                    taskStore.tasks.append(Task(id: String(taskStore.tasks.count + 1), toDoItem: newToDo))
                    self.newToDo = ""
                }
    @State var selectedDate: Date = Date()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        NavigationView{
            VStack{
                searchBar.padding()
                DatePicker("Select a date", selection: $selectedDate).padding()
                List {
                    ForEach(self.taskStore.tasks){ task in
                    Text(task.toDoItem)
                        Text(dateFormatter.string(from: selectedDate))
                    Text("")
                    }.onMove(perform: self.move)
                        .onDelete(perform: self.delete)
                }.navigationBarTitle("Schedule")
                    .navigationBarItems(trailing: EditButton())
            }
        }
    }
    func move(from source : IndexSet, to destination : Int){
        taskStore.tasks.move(fromOffsets: source, toOffset: destination)
    }
    
    func delete(at offsets : IndexSet){
        taskStore.tasks.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
