//
//  Starter_SwiftUIApp.swift
//  Starter-SwiftUI
//
//  Created by 이유현 on 4/17/25.
//

import SwiftUI

enum ViewType : Hashable {
    case HomeView
    case MyView
    case MoreView
    
    case DetailView(boardID: String?)
    case WriteView(boardID: String?)
}

final class NavigationManager: ObservableObject {
    @Published var path: [ViewType] = [] // 탭바 X -> stack
    @Published var currentTab: ViewType = .HomeView // 탭바 O 상태관리
    
    func push(_ view: ViewType) {
        path.append(view)
    }
    
    func pop(){
        path.removeLast()
    }
    
    func popToRoot(){
        path.removeAll()
    }
}

@main
struct Starter_SwiftUIApp: App {
    @StateObject private var navigationManager = NavigationManager()
    
    var body: some Scene {
        
        let repository = BoardRepository()
        let homeViewModel = HomeViewModel(boardRepository: repository)
        let detailViewModel = DetailViewModel(boardRepository: repository)
        let writeViewModel = WriteViewModel(boardRepository: repository)
        
        WindowGroup {
            NavigationStack(path: $navigationManager.path) {
                ContentView(viewModel: homeViewModel)
                    .navigationDestination(for: ViewType.self) { path in
                        switch path{
                        case .DetailView(let boardID):
                            DetailView(viewModel: detailViewModel, boardID: boardID)
                        case .WriteView(let boardID):
                            WriteView(viewModel: writeViewModel, boardID: boardID)
                        default :
                            EmptyView()
                        }
                    } // : navigationDestination
            } // : NavigationStack
            .environmentObject(navigationManager)
        }
    }
}
