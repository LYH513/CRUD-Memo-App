//
//  BoardRepositoryProtocol.swift
//  Starter-SwiftUI
//
//  Created by 이유현 on 4/18/25.
//

import Foundation

protocol BoardRepositoryProtocol {
    func postBoard(_ data: BoardModel) async throws
    func fetchBoardList() async throws -> [BoardModel]
    func fetchBoardById(_ boardId: String) async throws -> BoardModel
    func updateBoard(_ boardId: String, data: BoardModel) async throws
    func deleteBoard(_ boardId: String) async throws
}
