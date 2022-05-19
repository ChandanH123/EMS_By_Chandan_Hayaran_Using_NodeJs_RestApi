//
//  HeaderSectionView.swift
//  EMS_By_Chandan_Hayaran_Using_NodeJs_RestApi
//
//  Created by Chandan on 19/05/22.
//

import SwiftUI

struct HeaderSectionView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    @Binding var isPresentedCreateEmployee: Bool
    @State var isPresentedSearchBox = false
    @State var searchInput = "Search..."
    
    var plusCircleButton: some View {
        Button(action: { print("plusCircleButton Pressed.")
            isPresentedCreateEmployee.toggle()
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
            isPresentedSearchBox.toggle()
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
                        .opacity(isPresentedSearchBox ? 0 : 1)
                
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color("Capgi_Dark_Blue"))
                            .frame(height: 50)
                            .cornerRadius(30)
                    
                        TextField("Search...", text: $searchInput)
                            .foregroundColor(.white)
                            .padding()
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                            .onChange(of: searchInput) { searchNewInput in
                                viewModel.searchByName(searchInput: searchNewInput)
                                
                                        }
                    }
                    .opacity(isPresentedSearchBox ? 1 : 0)
                }
                
                Spacer()
                    
                plusCircleButton
                
                
                
            }
            .padding()
        .frame(height: 60)
            
            Rectangle()
                .foregroundColor(Color("Capgi_Dark_Blue"))
                .frame(height: 0.5)
                .offset(y: 8)
            
        }
    }
}

struct HeaderSectionView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderSectionView(isPresentedCreateEmployee: .constant(false))
            .previewLayout(.sizeThatFits)
            .environmentObject(ViewModel())
    }
}
