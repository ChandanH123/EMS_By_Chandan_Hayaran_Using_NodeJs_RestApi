//
//  UpdateEmployeeView.swift
//  EMS_By_Chandan_Hayaran_Using_NodeJs_RestApi
//
//  Created by Chandan on 09/05/22.
//

import SwiftUI

struct UpdateEmployeeView: View {
    
    @EnvironmentObject var viewModel: ViewModel
     
    @Environment (\.presentationMode) var presentationMode
    
    let item: EmployeeModel
    
    
    var backButton: some View {
        Button(action: {
            print("Back Button Pressed.")
            
            viewModel.getAllEmployees()
            presentationMode.wrappedValue.dismiss()
                },
               label: {
                    ZStack(alignment: .center) {
                            Rectangle()
                            .foregroundColor(Color("Capgi_Dark_Blue"))
                                .frame(width: 130, height: 50)
                                .cornerRadius(30)
                            
                            Text("Back")
                                .foregroundColor(.white)
                        }
                }
        )
    }
    
    var updateButton: some View {
        Button(action: {
                print("Update Button Pressed.")
            
            if (viewModel.emp_firstName != "" && viewModel.emp_lastName != "" && viewModel.emp_contactNumber != "" && viewModel.emp_gender != "") {
                
                let parameters: [String: Any] = ["emp_id": item.emp_id, "emp_firstName": viewModel.emp_firstName, "emp_lastName": viewModel.emp_lastName, "emp_contactNumber": viewModel.emp_contactNumber, "emp_gender": viewModel.emp_gender ]
                
                viewModel.updateEmployee(parameters: parameters)
                viewModel.getAllEmployees()
                
                presentationMode.wrappedValue.dismiss()
            }
           
                },
               label: {
                    ZStack(alignment: .center) {
                            Rectangle()
                            .foregroundColor(Color("Capgi_Dark_Blue"))
                                .frame(width: 130, height: 50)
                                .cornerRadius(30)
                            
                            Text("Update")
                                .foregroundColor(.white)
                        }
                }
        )
    }
    
    var body: some View {
            ZStack {
                Color.black.ignoresSafeArea(.all)
                VStack(alignment: .leading, spacing: 20) {
                    ZStack(alignment: .center) {
                            Rectangle()
                            .foregroundColor(Color("Capgi_Dark_Blue"))
                                .frame(height: 70)
                                .cornerRadius(50)
                            
                            Text("Update Employee")
                                .font(Font.system(size: 25, weight: .bold))
                                .foregroundColor(.white)
                        }
                    
                    HStack {
                        Spacer()
                        Image(viewModel.emp_gender)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .overlay(Circle()
                                        .stroke(Color("Capgi_Light_Blue"), lineWidth: 7))
                            .shadow(radius: 1)
                        
                        Spacer()
                    }
                    
                    TextField("First name", text: $viewModel.emp_firstName)
                        .padding()
                        .background(.white)
                        .disableAutocorrection(true)
                        .border(.red, width: viewModel.emp_firstName.isEmpty ? 5 : 0)
                        .overlay(
                            HStack {
                                Spacer()
                                Text(viewModel.fieldValidationFirstNameIcon)
                            }
                            .padding()
                        )
                    
                        
                        
                    TextField("Last name", text: $viewModel.emp_lastName)
                        .padding()
                        .background(.white)
                        .disableAutocorrection(true)
                        .border(.red, width: viewModel.emp_lastName.isEmpty ? 5 : 0)
                        .overlay(
                            HStack {
                                Spacer()
                                Text(viewModel.fieldValidationLastNameIcon)
                            }
                            .padding()
                        )
                        
                    
                    TextField("Contact number", text: $viewModel.emp_contactNumber)
                        .padding()
                        .background(.white)
                        .disableAutocorrection(true)
                        .border(.red, width: viewModel.emp_contactNumber.isEmpty ? 5 : 0)
                        .overlay(
                            HStack {
                                Spacer()
                                Text(viewModel.fieldValidationContactNumberIcon)
                            }
                            .padding()
                        )
                        
                        
                    
                    HStack {
                        Spacer()
                        Picker(selection: $viewModel.emp_gender, label: Text("Gender")) {
                            Text("Male").tag("Male")
                            Text("Female").tag("Female")
                        }
                        Spacer()
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(6)

                    
                    HStack {
                        backButton
                        Spacer()
                        updateButton
                    }
                    
                    Spacer()
                    
                    
                }.padding()
                    .onAppear(perform: {
                        viewModel.emp_firstName = item.emp_firstName
                        viewModel.emp_lastName = item.emp_lastName
                        viewModel.emp_contactNumber = item.emp_contactNumber
                        viewModel.emp_gender = item.emp_gender
                    })
                
                
            }
            .navigationBarHidden(true)
            
        
    }
}

struct UpdateEmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateEmployeeView(item: EmployeeModel(emp_id: 01, emp_firstName: "Rohit", emp_lastName: "Hayaran", emp_contactNumber: "1234567890", emp_gender: "Male"))
            .environmentObject(ViewModel())
    }
}
