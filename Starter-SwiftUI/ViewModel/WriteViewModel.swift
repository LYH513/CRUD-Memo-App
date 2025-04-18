//
//  WriteViewModel.swift
//  Starter-SwiftUI
//
//  Created by 이유현 on 4/17/25.
//

import Foundation

final class WriteViewModel: ObservableObject {
    @Published var userName: String = "이유현"
    @Published var title : String = ""
    @Published var contents: String = ""
    
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
                self.userName = board.userName
                self.title = board.title
                self.contents = board.contents
            }
            
        } catch {
            print("getBoardDetail 에러")
        }
    }
    
    // Post
    func postBoard(_ data: BoardModel) async {
        do {
            try await boardRepository.postBoard(data)
        } catch {
            print("updateBoardDetail 에러")
        }
    }
    
    // Edit
    func updateBoardDetail(_ id: String?, data: BoardModel) async {
        do {
            guard let id = id else {return}
            
            try await boardRepository.updateBoard(id, data: data)
            
        } catch {
            print("updateBoardDetail 에러")
        }
    }
    
}
