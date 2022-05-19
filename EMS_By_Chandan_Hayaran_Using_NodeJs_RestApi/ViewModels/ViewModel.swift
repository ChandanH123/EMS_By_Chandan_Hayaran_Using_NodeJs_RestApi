//
//  ViewModel.swift
//  EMS_By_Chandan_Hayaran_Using_NodeJs_RestApi
//
//  Created by Chandan on 09/05/22.
//

import Foundation


class ViewModel: ObservableObject {
    @Published var items = [EmployeeModel]()
    let prefixUrl = "http://localhost:8080"
    
    init() {
        getAllEmployees()
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

    //MARK: - get all employees
    func getAllEmployees() {
        guard let url = URL(string: "\(prefixUrl)/getAllEmployees") else {
            print("Url not found.")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(DataModel.self, from: data)
                    DispatchQueue.main.async {
                        self.items = result.data
                        self.sortLatest()
                    }
                }
                else {
                    print("No data found.")
                }
            } catch let JsonError {
                print("fetch json error:", JsonError.localizedDescription)
            }
            
        }.resume()
    }

    
    //MARK: -  create employee
    func createEmployee(parameters: [String: Any]) {
        guard let url = URL(string: "\(prefixUrl)/createEmployee") else {
            print("Url not found.")
            return
        }
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(DataModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                    }
                }
                else {
                    print("No data found.")
                }
            } catch let JsonError {
                print("fetch json error:", JsonError.localizedDescription)
            }
            
        }.resume()
    }

    
    //MARK: - update employee
    func updateEmployee(parameters: [String: Any]) {
        guard let url = URL(string: "\(prefixUrl)/updateEmployee") else {
            print("Url not found.")
            return
        }
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(DataModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                    }
                }
                else {
                    print("No data found.")
                }
            } catch let JsonError {
                print("fetch json error:", JsonError.localizedDescription)
            }
            
        }.resume()
    }

    
    //MARK: - delete employee
    func deleteEmployee(parameters: [String: Any]) {
        guard let url = URL(string: "\(prefixUrl)/deleteEmployee") else {
            print("Url not found.")
            return
        }
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(DataModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                    }
                }
                else {
                    print("No data found.")
                }
            } catch let JsonError {
                print("fetch json error:", JsonError.localizedDescription)
            }
            
        }.resume()
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
