//
//  DetailViewModel.swift
//  Starter-SwiftUI
//
//  Created by 이유현 on 4/18/25.
//

import Foundation

final class DetailViewModel: ObservableObject {
    @Published var detailBoard: BoardModel = BoardModel(userName: "", title: "", contents: "")
    
    private let boardRepository: BoardRepositoryProtocol
    
    init(boardRepository: BoardRepositoryProtocol) {
        self.boardRepository = boardRepository
    }
    
    // Read one
    func getBoardDetail(_ id: String?) async {
        do {
            guard let id = id else {return}
            
            let board = try await boardRepository.fetchBoardById(id)
            
            //UI는 메인스레드에서 수정
            DispatchQueue.main.async {
                self.detailBoard = board
            }
        } catch {
            print("getBoardDetail 에러")
        }
    }
    
    // Delete
    func deleteBoardDetail(_ id: String?) async {
        do {
            guard let id = id else {return}
            
            try await boardRepository.deleteBoard(id)
            
        } catch {
            print("deleteBoardDetail 에러")
        }
    }
}
