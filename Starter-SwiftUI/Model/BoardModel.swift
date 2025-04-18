//
//  BoardModel.swift
//  Starter-SwiftUI
//
//  Created by 이유현 on 4/17/25.
//

import Foundation

struct BoardModel: Hashable, Codable {
    var boardID : String?
    var userName: String
    var title : String
    var contents: String
    var createdAt: String?
}

extension BoardModel {
    static let mockData: [BoardModel] = [
        BoardModel(
            boardID: "1",
            userName: "Alice",
            title: "첫 번째 게시글",
            contents: "안녕하세요! 여기는 첫 번째 게시글입니다.안녕하세요! 여기는 첫 번째 게시글입니다.안녕하세요! 여기는 첫 번째 게시글입니다.",
            createdAt: "2025-04-17 10:00"
        ),
        BoardModel(
            boardID: "2",
            userName: "Bob",
            title: "두 번째 게시글",
            contents: "SwiftUI 정말 재밌어요!SwiftUI 정말 재밌어요!SwiftUI 정말 재밌어요!",
            createdAt: "2025-04-17 11:00"
        ),
        BoardModel(
            boardID: "3",
            userName: "Charlie",
            title: "질문 있습니다",
            contents: "Codable과 Hashable 같이 쓰는 이유가 뭔가요?Codable과 Hashable 같이 쓰는 이유가 뭔가요?Codable과 Hashable 같이 쓰는 이유가 뭔가요?",
            createdAt: "2025-04-17 12:00"
        )
    ]
}
