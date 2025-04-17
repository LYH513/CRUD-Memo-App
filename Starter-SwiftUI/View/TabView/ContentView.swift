//
//  ContentView.swift
//  Starter-SwiftUI
//
//  Created by 이유현 on 4/17/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        ZStack(alignment: .bottom){
            
            switch navigationManager.currentTab {
            case .HomeView :
                HomeView()
            case .MyView :
                MyView()
            case .MoreView:
                MoreView()
            default:
                HomeView()
            }
            
            CustomTabView(currentView: navigationManager.currentTab)
        } // : Zstack
        .edgesIgnoringSafeArea(.bottom)
    }
}
        

#Preview {
    ContentView()
        .environmentObject(NavigationManager())
}
