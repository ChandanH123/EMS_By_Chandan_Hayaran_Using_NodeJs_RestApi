//
//  HeaderSectionView.swift
//  EMS_By_Chandan_Hayaran_Using_NodeJs_RestApi
//
//  Created by Chandan on 19/05/22.
//

import SwiftUI

struct HeaderSectionView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var plusCircleButton: some View {
        Button(action: { print("plusCircleButton Pressed.")
            
            viewModel.emp_firstName = ""
            viewModel.emp_lastName = ""
            viewModel.emp_contactNumber = ""
            viewModel.emp_gender = "Male"
            viewModel.isPresentedCreateEmployee.toggle()
        
        },
               label: { ZStack {
            Rectangle()
                .foregroundColor(Color("Capgi_Light_Blue"))
                .frame(width: 50, height: 50)
                .cornerRadius(30)
            Image(systemName: "plus")
                .foregroundColor(.white)
        }})
    }
    
    var searchButton: some View {
        Button(action: { print("searchButton Pressed.")
            withAnimation(.spring()) {
                viewModel.isPresentedSearchBox.toggle()
                
            }
        },
               label: { ZStack {
            Rectangle()
                .foregroundColor(Color("Capgi_Light_Blue"))
                .frame(width: 50, height: 50)
                .cornerRadius(30)
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
        }})
    }
    
    var body: some View {
        VStack {
            HStack {
                
                searchButton
                    
                Spacer()
                
                ZStack {
                    Image("capgi_logo")
                        .resizable()
                        .frame(width: 200, height: 44)
                        .opacity(viewModel.isPresentedSearchBox ? 0 : 1)
                
                    SearchBarView()
                        .opacity(viewModel.isPresentedSearchBox ? 1 : 0)
                }
                
                Spacer()
                    
                ZStack {
                    plusCircleButton
                        .opacity(viewModel.isPresentedSearchBox ? 0 : 1)
                    
                    Button(action: {
                        withAnimation(.spring()) {
                            viewModel.isSearching.toggle()
                            viewModel.searchText = ""
                            viewModel.isPresentedSearchBox.toggle()
                        }
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        
                    }, label: {
                        Text("Cancel")
                            
                            
                    })
                    
                    .opacity(viewModel.isPresentedSearchBox ? 1 : 0)
                    
                }
                
                
                
            }
            .padding()
        .frame(height: 60)
            
            Rectangle()
                .foregroundColor(Color("Capgi_Dark_Blue"))
                .frame(height: 0.5)
                .offset(y: 8)
            
        }
        .sheet(isPresented: $viewModel.isPresentedCreateEmployee, content: {
            CreateEmployeeView()
    })
    }
}

struct HeaderSectionView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderSectionView()
            .previewLayout(.sizeThatFits)
            .environmentObject(ViewModel())
    }
}
