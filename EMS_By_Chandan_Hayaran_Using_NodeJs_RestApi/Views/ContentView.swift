//
//  ContentView.swift
//  EMS_By_Chandan_Hayaran_Using_NodeJs_RestApi
//
//  Created by Chandan on 09/05/22.
//

import SwiftUI
import Foundation

struct ContentView: View {

    @EnvironmentObject var viewModel: ViewModel
    
    @State var isPresentedCreateEmployee = false
    @State var emp_firstName = ""
    @State var emp_lastName = ""
    @State var emp_contactNumber = ""
    @State var emp_gender = "Male"
    
    
    var plusCircleButton: some View {
        Button(action: { print("plusCircleButton Pressed.")
            isPresentedCreateEmployee.toggle()
        },
               label: { Image(systemName: "plus.circle")})
    }
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items, id: \.emp_id  ) { item in
                    NavigationLink(
                        destination: UpdateEmployeeView(item: item),
                        label: {                                RowView(employee: item)
                        })
                }
                .onDelete(perform: deleteEmployee)
                
            }
            .listStyle(.inset)
            .navigationBarTitle("Employees")
            .navigationBarItems(trailing: plusCircleButton)
        }
        .sheet(isPresented: $isPresentedCreateEmployee, content: {
            CreateEmployeeView(isPresentedCreateEmployee: $isPresentedCreateEmployee, emp_firstName: $emp_firstName, emp_lastName: $emp_lastName, emp_contactNumber: $emp_contactNumber, emp_gender: $emp_gender)
        })
    }
    
    private func deleteEmployee(indexSet: IndexSet) {
        let emp_id = indexSet.map {viewModel.items[$0].emp_id }
    
        DispatchQueue.main.async {
            let parameters: [String: Any] = ["emp_id": emp_id[0]]
            self.viewModel.deleteEmployee(parameters: parameters)
            self.viewModel.getAllEmployees()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
