//
//  HttpClient.swift
//  EMS_By_Chandan_Hayaran_Using_NodeJs_RestApi
//
//  Created by Chandan on 28/05/22.
//

import Foundation


class HttpClient {
    
    let prefixUrl = "http://localhost:8080"

    enum NetworkError: Error {
        case fail
    }

    //MARK: - get all employees
    func getAllEmployees(completion: @escaping (Result<[EmployeeModel], NetworkError>) -> Void)  {
        
        guard let url = URL(string: "\(prefixUrl)/getAllEmployees") else {
            print("Url not found.")
            return completion(.failure(NetworkError.fail))
        }
        
        URLSession.shared.dataTask(with: url) { (data, res, error) in
            if error != nil {
                print("error \(String(describing: error?.localizedDescription))")
                return completion(.failure(NetworkError.fail))
            }
            
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(DataModel.self, from: data)
                    return completion(.success(result.data))
                }
                else {
                    print("No data found")
                    return completion(.failure(NetworkError.fail))
                }
            } catch let JsonError {
               print("fetch json error: \(JsonError.localizedDescription)")
                return completion(.failure(NetworkError.fail))
            }
            
        }.resume()
    }
    
    
    //MARK: -  create employee
    func createEmployee(parameters: [String: Any], completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: "\(prefixUrl)/createEmployee") else {
            print("Url not found.")
            return completion(.failure(NetworkError.fail))
        }

        let data = try! JSONSerialization.data(withJSONObject: parameters)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, res, error) in
            if error != nil {
                print("error \(String(describing: error?.localizedDescription))")
                return completion(.failure(NetworkError.fail))
            }

            do {
                if let data = data {
                    let result = try JSONDecoder().decode(DataModel.self, from: data)
                    return completion(.success(result.message))
                }
                else {
                    print("No data found")
                    return completion(.failure(NetworkError.fail))
                }
            } catch let JsonError {
               print("fetch json error: \(JsonError.localizedDescription)")
                return completion(.failure(NetworkError.fail))
            }

        }.resume()
    }

    //MARK: -  update employee
    func updateEmployee(parameters: [String: Any], completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: "\(prefixUrl)/updateEmployee") else {
            print("Url not found.")
            return completion(.failure(NetworkError.fail))
        }

        let data = try! JSONSerialization.data(withJSONObject: parameters)

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, res, error) in
            if error != nil {
                print("error \(String(describing: error?.localizedDescription))")
                return completion(.failure(NetworkError.fail))
            }

            do {
                if let data = data {
                    let result = try JSONDecoder().decode(DataModel.self, from: data)
                    return completion(.success(result.message))
                }
                else {
                    print("No data found")
                    return completion(.failure(NetworkError.fail))
                }
            } catch let JsonError {
               print("fetch json error: \(JsonError.localizedDescription)")
                return completion(.failure(NetworkError.fail))
            }

        }.resume()
    }
    
    //MARK: -  delete employee
    func deleteEmployee(parameters: [String: Any], completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: "\(prefixUrl)/deleteEmployee") else {
            print("Url not found.")
            return completion(.failure(NetworkError.fail))
        }

        let data = try! JSONSerialization.data(withJSONObject: parameters)

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, res, error) in
            if error != nil {
                print("error \(String(describing: error?.localizedDescription))")
                return completion(.failure(NetworkError.fail))
            }

            do {
                if let data = data {
                    let result = try JSONDecoder().decode(DataModel.self, from: data)
                    return completion(.success(result.message))
                }
                else {
                    print("No data found")
                    return completion(.failure(NetworkError.fail))
                }
            } catch let JsonError {
               print("fetch json error: \(JsonError.localizedDescription)")
                return completion(.failure(NetworkError.fail))
            }

        }.resume()
    }

}
