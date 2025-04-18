//
//  DetailView.swift
//  Starter-SwiftUI
//
//  Created by 이유현 on 4/17/25.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    @ObservedObject private var viewModel: DetailViewModel
    var boardID: String?
    
    init(viewModel: DetailViewModel, boardID: String? = nil) {
        self.viewModel = viewModel
        self.boardID = boardID
    }
    
    var body: some View {
        VStack(alignment: .leading,spacing:0){
            HStack(spacing: 0){
                
                Button(action: {
                    navigationManager.pop()
                }){
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 30))
                        .tint(.white)
                }
                .padding(.leading, 10)
                
                Text(viewModel.detailBoard.title)
                    .foregroundColor(.white)
                    .font(.largeTitle).bold()
                    .padding()
                
                Spacer()
                
                Button(action: {
                    // 수정 로직
                    navigationManager.push(.WriteView(boardID: boardID))
                }){
                    Image(systemName: "square.and.pencil.circle")
                        .font(.system(size: 30))
                        .tint(.black)
                }
                .padding(.trailing, 10)
                
                Button(action: {
                    // 삭제 로직
                    Task{
                        await viewModel.deleteBoardDetail(boardID)
                        navigationManager.pop()
                    }
                }){
                    Image(systemName: "trash")
                        .font(.system(size: 30))
                        .tint(.black)
                }
                .padding(.trailing, 10)
                
            } // : HStack
            .background(Color(hex: "fea443"))
            .padding(.bottom, 20)
            
            VStack(alignment: .leading){
                HStack{
                    Text(viewModel.detailBoard.userName)
                    Text(viewModel.detailBoard.createdAt ?? "")
                    
                    Spacer()
                }
                .padding(.bottom, 10)
                
                Text(viewModel.detailBoard.contents)
                
                Spacer()
            }
            .frame(maxWidth: .infinity,maxHeight: 300)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(hex: "fea443"), lineWidth: 3)
            )
            .padding()
            
            Spacer()
            
        } // : Vstack
        .navigationBarBackButtonHidden(true)
        .task {
            await viewModel.getBoardDetail(boardID ?? nil)
        }
    }
}

#Preview {
    DetailView(viewModel: DetailViewModel(boardRepository: BoardRepository()), boardID: nil)
}
