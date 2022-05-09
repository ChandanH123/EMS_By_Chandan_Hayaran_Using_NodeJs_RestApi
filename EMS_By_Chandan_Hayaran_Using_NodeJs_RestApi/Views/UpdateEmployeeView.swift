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
    
    @State var emp_firstName = ""
    @State var emp_lastName = ""
    @State var emp_contactNumber = ""
    @State var emp_gender = ""
    
    @State var isAlert = false
    
    var cancelButton: some View {
        Button(action: {
            print("Cancel Button Pressed.")
            viewModel.getAllEmployees()
            presentationMode.wrappedValue.dismiss()
                },
               label: {
                    ZStack(alignment: .center) {
                            Rectangle()
                                .foregroundColor(.blue)
                                .frame(width: 130, height: 50)
                                .cornerRadius(30)
                            
                            Text("Cancel")
                                .foregroundColor(.white)
                        }
                }
        )
    }
    
    var updateButton: some View {
        Button(action: {
                print("Update Button Pressed.")
            
            if (emp_firstName != "" && emp_lastName != "" && emp_contactNumber != "" && emp_gender != "") {
                
                let parameters: [String: Any] = ["emp_id": item.emp_id,"emp_firstName": emp_firstName, "emp_lastName": emp_lastName, "emp_contactNumber": emp_contactNumber, "emp_gender": emp_gender ]
                viewModel.updateEmployee(parameters: parameters)
                viewModel.getAllEmployees()
                
                presentationMode.wrappedValue.dismiss()
            }
            else {
                isAlert.toggle()
            }
                },
               label: {
                    ZStack(alignment: .center) {
                            Rectangle()
                                .foregroundColor(.blue)
                                .frame(width: 130, height: 50)
                                .cornerRadius(30)
                            
                            Text("Update")
                                .foregroundColor(.white)
                        }
                }
        )
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea(.all)
                VStack(alignment: .leading, spacing: 20) {
                    ZStack(alignment: .center) {
                            Rectangle()
                                .foregroundColor(.blue)
                                .frame(height: 100)
                                .cornerRadius(50)
                            
                            Text("Update Employee")
                                .font(Font.system(size: 25, weight: .bold))
                                .foregroundColor(.white)
                        }
                    
                    HStack {
                        Spacer()
                        Image(self.emp_gender)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
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
                        updateButton
                    }
                    
                    Spacer()
                    
                    
                }.padding()
                    .onAppear(perform: {
                        self.emp_firstName = item.emp_firstName
                        self.emp_lastName = item.emp_lastName
                        self.emp_contactNumber = item.emp_contactNumber
                        self.emp_gender = item.emp_gender
                    })
                    .alert(isPresented: $isAlert, content: {
                        let title = Text("No Data.")
                        let message = Text("Please fill all fields.")
                        return Alert(title: title, message: message)
                    })
                
                
            }
            .navigationBarHidden(true)
            
        }
        
    }
}

//struct UpdateEmployeeView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateEmployeeView(isPresentedCreateEmployee: .constant(true), emp_firstName: .constant("Chandan"), emp_lastName: .constant("Hayaran"), emp_contactNumber: .constant("7748064046"), emp_gender: .constant("male"))
//    }
//}
