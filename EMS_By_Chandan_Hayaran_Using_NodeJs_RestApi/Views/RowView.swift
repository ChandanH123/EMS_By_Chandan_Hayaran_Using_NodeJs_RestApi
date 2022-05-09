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
            Rectangle()
                .foregroundColor(.blue)
                .frame(height: 100)
                .cornerRadius(50)
            
       
            HStack {
                Image(employee.emp_gender)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8)
                    .frame(width: 70, height: 70)
                
                Text("\(employee.emp_firstName) \(employee.emp_lastName)")
                        .font(.headline)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                Spacer()
                }
            .padding()
                
    
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
       
            ZStack {
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(height: 100)
                    .cornerRadius(50)
                
           
                HStack {
                    Image("Male")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(8)
                        .frame(width: 70, height: 70)
                    
                        Text("Rohit Hayaran")
                            .font(.headline)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    Spacer()
                    }
                .padding()
                    
        
            }
        }
    
}
