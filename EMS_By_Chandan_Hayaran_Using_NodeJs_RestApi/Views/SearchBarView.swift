//
//  SearchBarView.swift
//  EMS_By_Chandan_Hayaran_Using_NodeJs_RestApi
//
//  Created by Chandan on 20/05/22.
//

import SwiftUI

struct SearchBarView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    @State var searchText = ""
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            
            HStack {
                TextField("Search terms here", text: $searchText)
                    .padding(.leading, 24)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(6)
            .padding(.horizontal)
            .onTapGesture(perform: {
                viewModel.isSearching = true
            })
            .onChange(of: searchText) {
                searchTextNew in
                viewModel.searchText = searchTextNew
            }
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    
                    if viewModel.isSearching {
                        Button(action: { viewModel.searchText = "" }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.vertical)
                        })
                        
                    }
                    
                }.padding(.horizontal, 32)
                .foregroundColor(.gray)
            ).animation(.spring(), value: viewModel.isSearching)
         
            
            
            
           
            
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
//        SearchBarView()
//            .environmentObject(ViewModel())
        HeaderSectionView(isPresentedCreateEmployee: .constant(false))
            .environmentObject(ViewModel())
    }
}
