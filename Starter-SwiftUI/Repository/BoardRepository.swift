//
//  BoardRepository.swift
//  Starter-SwiftUI
//
//  Created by 이유현 on 4/18/25.
//

import Foundation

final class BoardRepository: BoardRepositoryProtocol{
    
    public init(){}
    
    // Post
    func postBoard(_ data: BoardModel) async throws {
        do{
            let response: APIResponse = try await NetworkService.request(endpoint: "", body: data, method: "POST"
            )
        }catch {
            throw error
        }
    }
    
    // Read All
    func fetchBoardList() async throws -> [BoardModel]{
        do{
            let response: [BoardModel] = try await NetworkService.request(endpoint: "")
            return response
        } catch {
            throw error
        }
    }
    
    // Read one
    func fetchBoardById(_ boardId: String) async throws -> BoardModel{
        do{
            let response: BoardModel = try await NetworkService.request(endpoint: "/\(boardId)")
            return response
        } catch {
            throw error
        }
    }
    
    // Update
    func updateBoard(_ boardId: String, data: BoardModel) async throws {
        do{
            let response: APIResponse = try await NetworkService.request(endpoint: "/\(boardId)", body: data, method: "PATCH")
        }catch{
            throw error
        }
    }
    
    // Delete
    func deleteBoard(_ boardId: String) async throws {
        do{
            let response: APIResponse = try await NetworkService.request(endpoint: "/\(boardId)", method: "DELETE")
        }catch{
            throw error
        }
    }
}
