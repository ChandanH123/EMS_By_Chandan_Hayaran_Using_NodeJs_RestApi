//
//  ContentView.swift
//  EMS_By_Chandan_Hayaran_Using_NodeJs_RestApi
//
//  Created by Chandan on 09/05/22.
//

import SwiftUI
import Foundation

struct ContentView: View {

    @EnvironmentObject var viewModel: ViewModel
    
    @State var isPresentedCreateEmployee = false
    @State var isPresentedSearchBox = false
    
    var body: some View {

            NavigationView {
                
                VStack {
                    
                    // MARK: - Header Section Start
                    HeaderSectionView(isPresentedCreateEmployee: $isPresentedCreateEmployee, isPresentedSearchBox: $isPresentedSearchBox)
                    // MARK: - Header Section End
                    
                    
                    
                    // MARK: - Center Section Start
                        CenterSectionView()
                    // MARK: - Center Section End
                    
                    .navigationBarHidden(true)
                
                }
            }
            .sheet(isPresented: $isPresentedCreateEmployee, content: {
                CreateEmployeeView(isPresentedCreateEmployee: $isPresentedCreateEmployee)
        })
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
