//
//  FilterButtonView.swift
//  EMS_By_Chandan_Hayaran_Using_NodeJs_RestApi
//
//  Created by Chandan on 19/05/22.
//

import SwiftUI

struct FilterButtonView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("Capgi_Dark_Blue"))
                .frame(width: 80, height: 50)
                .cornerRadius(30)
            Menu(("Filter".uppercased())) {
                
                Button("Sort Z-A", action: { viewModel.sortZA()})
                
                Button("Sort A-Z", action: { viewModel.sortAZ()})
                       
                Button("Sort Earliest", action: { viewModel.sortEarliest()})
            
                Button("Sort Latest", action: { viewModel.sortLatest()})
            }
            .foregroundColor(.white)
            .font(Font.system(size: 15, weight: .bold))
        }
        .padding()
    }
}

struct FilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FilterButtonView()
            .environmentObject(ViewModel())
    }
}
