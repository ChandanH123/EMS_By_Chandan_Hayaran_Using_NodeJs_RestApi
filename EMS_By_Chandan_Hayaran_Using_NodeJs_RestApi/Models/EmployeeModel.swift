//
//  EmployeeModel.swift
//  EMS_By_Chandan_Hayaran_Using_NodeJs_RestApi
//
//  Created by Chandan on 09/05/22.
//

import Foundation
import SwiftUI

struct DataModel: Decodable {
    let error: Bool
    let message: String
    let data: [EmployeeModel]
}

struct EmployeeModel: Decodable {
    let emp_id: Int
    let emp_firstName: String
    let emp_lastName: String
    let emp_contactNumber: String
    let emp_gender: String
}
