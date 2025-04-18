//
//  ContentView.swift
//  Starter-SwiftUI
//
//  Created by 이유현 on 4/17/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    @ObservedObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            
            switch navigationManager.currentTab {
            case .HomeView :
                HomeView(viewModel: viewModel)
            case .MyView :
                MyView()
            case .MoreView:
                MoreView()
            default:
                HomeView(viewModel: viewModel)
            }
            
            CustomTabView(currentView: navigationManager.currentTab)
        } // : Zstack
        .edgesIgnoringSafeArea(.bottom)
    }
}
        

#Preview {
    let repository = BoardRepository()
    let homeViewModel = HomeViewModel(boardRepository: repository)
    
    ContentView(viewModel: homeViewModel)
        .environmentObject(NavigationManager())
}
