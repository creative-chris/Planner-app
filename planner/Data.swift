//
//  Data.swift
//  planner
//
//  Created by ISSD on 26/09/2021.
//

import Foundation
import SwiftUI
import Combine

struct Task : Identifiable {
    var id = String()
    var toDoItem = String()
}

class TaskStore : ObservableObject {
    @Published var tasks = [Task]()
}

struct CustomColor {
    static let myColor = Color("colorGreen")
}
