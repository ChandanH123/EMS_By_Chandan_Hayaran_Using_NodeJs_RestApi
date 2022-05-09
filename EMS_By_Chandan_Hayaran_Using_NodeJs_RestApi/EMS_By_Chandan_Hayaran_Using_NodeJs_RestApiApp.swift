//
//  EMS_By_Chandan_Hayaran_Using_NodeJs_RestApiApp.swift
//  EMS_By_Chandan_Hayaran_Using_NodeJs_RestApi
//
//  Created by Chandan on 09/05/22.
//

import SwiftUI

@main
struct EMS_By_Chandan_Hayaran_Using_NodeJs_RestApiApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(ViewModel())
        }
    }
}
