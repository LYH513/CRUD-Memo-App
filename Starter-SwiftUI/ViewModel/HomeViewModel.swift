//
//  HomeViewModel.swift
//  Starter-SwiftUI
//
//  Created by 이유현 on 4/17/25.
//

import Foundation

final class HomeViewModel: ObservableObject {
//    @Published var boardList: [BoardModel] = []
    
    private let boardRepository: BoardRepositoryProtocol
    
    init(boardRepository: BoardRepositoryProtocol) {
        self.boardRepository = boardRepository
    }
    
    // 서버로부터 board list를 불러옴
    func getBoardList() async -> [BoardModel] {
        do {
            let boards = try await boardRepository.fetchBoardList()
            
            return boards
            
        } catch {
            print("getBoardList 에러")
            return []
        }
    }
}
