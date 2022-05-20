//
//  CenterSectionView.swift
//  EMS_By_Chandan_Hayaran_Using_NodeJs_RestApi
//
//  Created by Chandan on 19/05/22.
//

import SwiftUI

struct CenterSectionView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            List {
                ForEach(viewModel.items.filter({ "\($0)".localizedCaseInsensitiveContains(viewModel.searchText) || viewModel.searchText.isEmpty }), id: \.emp_id  ) { item in
                        NavigationLink(
                            destination: UpdateEmployeeView(item: item),
                            label: {                                RowView(employee: item)
                            })
                    }
                    .onDelete(perform: viewModel.deleteEmployeeRow)

                }
            
            .listStyle(.insetGrouped)
            
            
            
            // MARK: - Filter Button Start
                FilterButtonView()
            // MARK: - Filter Button End
        }

    }
}

struct CenterSectionView_Previews: PreviewProvider {
    static var previews: some View {
        CenterSectionView()
            .environmentObject(ViewModel())
    }
}
