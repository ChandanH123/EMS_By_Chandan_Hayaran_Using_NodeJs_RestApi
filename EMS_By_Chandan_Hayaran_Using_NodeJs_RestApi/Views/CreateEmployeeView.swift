//
//  CreateEmployeeView.swift
//  EMS_By_Chandan_Hayaran_Using_NodeJs_RestApi
//
//  Created by Chandan on 09/05/22.
//

import SwiftUI

struct CreateEmployeeView: View {
    
    @EnvironmentObject var viewModel: ViewModel

    @Binding var isPresentedCreateEmployee: Bool
    
    @State var emp_firstName = ""
    @State var emp_lastName = ""
    @State var emp_contactNumber = ""
    @State var emp_gender = "Male"
    
    @State var isAlert = false
    
    var cancelButton: some View {
        Button(action: {
            print("Cancel Button Pressed.")
            viewModel.getAllEmployees()
            isPresentedCreateEmployee.toggle()
                },
               label: {
                    ZStack(alignment: .center) {
                            Rectangle()
                            .foregroundColor(Color("Capgi_Dark_Blue"))
                                .frame(width: 130, height: 50)
                                .cornerRadius(30)
                            
                            Text("Cancel")
                                .foregroundColor(.white)
                        }
                }
        )
    }
    
    var addButton: some View {
        Button(action: {
                print("Add Button Pressed.")
            if (emp_firstName != "" && emp_lastName != "" && emp_contactNumber != "" && emp_gender != "") {
                
                let parameters: [String: Any] = ["emp_firstName": emp_firstName, "emp_lastName": emp_lastName, "emp_contactNumber": emp_contactNumber, "emp_gender": emp_gender ]
                viewModel.createEmployee(parameters: parameters)
                viewModel.getAllEmployees()
                
                isPresentedCreateEmployee.toggle()
            }
            else {
                isAlert.toggle()
            }
                },
               label: {
                    ZStack(alignment: .center) {
                            Rectangle()
                                .foregroundColor(Color("Capgi_Dark_Blue"))
                                .frame(width: 130, height: 50)
                                .cornerRadius(30)
                            
                            Text("Add")
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
                            
                            Text("Add Employee")
                                .font(Font.system(size: 25, weight: .bold))
                                .foregroundColor(.white)
                        }
                    
                    HStack {
                        Spacer()
                        Image(self.emp_gender)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .overlay(Circle()
                                        .stroke(Color("Capgi_Light_Blue"), lineWidth: 7))
                            .shadow(radius: 1)
                        
                        Spacer()
                    }
                    
                    TextField("First Name", text: $emp_firstName)
                        .padding()
                        .background(.white)
                        .cornerRadius(6)
                        .disableAutocorrection(true)
                    
                    TextField("Last Name", text: $emp_lastName)
                        .padding()
                        .background(.white)
                        .cornerRadius(6)
                        .disableAutocorrection(true)
                    
                    TextField("Contact Number", text: $emp_contactNumber)
                        .padding()
                        .background(.white)
                        .cornerRadius(6)
                        .disableAutocorrection(true)
                    
                    HStack {
                        Spacer()
                        Picker(selection: $emp_gender, label: Text("Gender")) {
                            Text("Male").tag("Male")
                            Text("Female").tag("Female")
                        }
                        Spacer()
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(6)

                    
                    HStack {
                        cancelButton
                        Spacer()
                        addButton
                    }
                    
                    Spacer()
                    
                    
                }.padding()
                    .alert(isPresented: $isAlert, content: {
                        let title = Text("No Data.")
                        let message = Text("Please fill all fields.")
                        return Alert(title: title, message: message)
                    })
            }
        
    }
}


struct CreateEmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEmployeeView(isPresentedCreateEmployee: .constant(true))
            .environmentObject(ViewModel())
    }
}
