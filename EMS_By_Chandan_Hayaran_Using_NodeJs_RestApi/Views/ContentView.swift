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
    

    
    var body: some View {

            NavigationView {
                
                VStack {
                    
                    // MARK: - Header Section Start
                    HeaderSectionView()
                    // MARK: - Header Section End
                    
                    
                    
                    // MARK: - Center Section Start
                    CenterSectionView()
                    // MARK: - Center Section End
                    
                    .navigationBarHidden(true)
                
                }
            }
            
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
