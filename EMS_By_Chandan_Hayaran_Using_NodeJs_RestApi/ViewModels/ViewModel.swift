//
//  ViewModel.swift
//  EMS_By_Chandan_Hayaran_Using_NodeJs_RestApi
//
//  Created by Chandan on 09/05/22.
//

import Foundation
import Combine
import SwiftUI


class ViewModel: ObservableObject {
    
    @Published var items = [EmployeeModel]()
    
    @Published var isPresentedSearchBox = false
    
    @Published var searchText = ""
    @Published var isSearching = false
    
    @Published var isPresentedCreateEmployee = false
    
    @Published var emp_firstName = ""
    @Published var emp_lastName = ""
    @Published var emp_contactNumber = ""
    @Published var emp_gender = "Male"
    

    @Published var fieldValidationFirstNameIcon = ""
    @Published var fieldValidationLastNameIcon = ""
    @Published var fieldValidationContactNumberIcon = ""
    

    
    init() {
        getAllEmployees()
        
        $emp_firstName
            .map { $0.isEmpty ? "❗️" : "✅" }
            .assign(to: &$fieldValidationFirstNameIcon)

        $emp_lastName
            .map { $0.isEmpty ? "❗️" : "✅" }
            .assign(to: &$fieldValidationLastNameIcon)

        $emp_contactNumber
            .map { $0.isEmpty ? "❗️" : "✅" }
            .assign(to: &$fieldValidationContactNumberIcon)
        
    }
    
    

    

    func sortAZ() {
        items.sort(by: { $0.emp_firstName < $1.emp_firstName })
    }

    func sortZA() {
        items.sort(by: { $0.emp_firstName > $1.emp_firstName })
    }
    
    func sortLatest() {
        items.sort(by: { $0.emp_id > $1.emp_id })
    }

    func sortEarliest() {
        items.sort(by: { $0.emp_id < $1.emp_id })
    }

    
    
    let httpClient = HttpClient()
    
    
    //MARK: - get all employees
    func getAllEmployees() {
       
        httpClient.getAllEmployees { result in
            switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.items = data
                        self.sortLatest()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
        
    }

    
    //MARK: -  create employee
    func createEmployee(parameters: [String: Any]) {
        
        httpClient.createEmployee(parameters: parameters)  { result in
            switch result {
                case .success(let message):
                    DispatchQueue.main.async {
                        print(message)
                        self.getAllEmployees()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }

    
    //MARK: - update employee
    func updateEmployee(parameters: [String: Any]) {
        
        httpClient.updateEmployee(parameters: parameters) { result in
            switch result {
                case .success(let message):
                    DispatchQueue.main.async {
                        print(message)
                        self.getAllEmployees()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }

    
    //MARK: - delete employee
    func deleteEmployee(parameters: [String: Any]) {
        
        httpClient.deleteEmployee(parameters: parameters) { result in
            switch result {
                case .success(let message):
                    DispatchQueue.main.async {
                        print(message)
                        self.getAllEmployees()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }

    }
    
    
    func deleteEmployeeRow(indexSet: IndexSet) {
        let emp_id = indexSet.map {items[$0].emp_id }
    
        DispatchQueue.main.async {
            let parameters: [String: Any] = ["emp_id": emp_id[0]]
            self.deleteEmployee(parameters: parameters)
            self.getAllEmployees()
        }
    }

}
