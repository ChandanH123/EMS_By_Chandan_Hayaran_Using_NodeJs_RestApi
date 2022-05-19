//
//  RowView.swift
//  EMS_By_Chandan_Hayaran
//
//  Created by Chandan on 09/05/22.
//

import SwiftUI

struct RowView: View {
    
    var employee: EmployeeModel
   

    var body: some View {
        ZStack {
           HStack {
                Image(employee.emp_gender)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .overlay(Circle()
                                .stroke(Color("Capgi_Light_Blue"), lineWidth: 4))
                            .shadow(radius: 1)
                
                Text("\(employee.emp_firstName) \(employee.emp_lastName)")
                        .font(.headline)
                        .foregroundColor(Color("Capgi_Dark_Blue"))
                        .fontWeight(.bold)
                Spacer()
                }
            .padding(5)
        }
        
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(employee: EmployeeModel(emp_id: 01, emp_firstName: "Rohit", emp_lastName: "Hayaran", emp_contactNumber: "1234567890", emp_gender: "Male"))
        }
    
}
