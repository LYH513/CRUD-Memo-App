//
//  WriteView.swift
//  Starter-SwiftUI
//
//  Created by 이유현 on 4/17/25.
//

import SwiftUI

struct WriteView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    @ObservedObject private var viewModel: WriteViewModel
    var boardID: String?
    
    init(viewModel: WriteViewModel, boardID: String? = nil) {
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
                
                Text(boardID == nil ? "메모 추가하기" : "메모 수정하기")
                    .foregroundColor(.white)
                    .font(.largeTitle).bold()
                    .padding()
                
                Spacer()
                
            } // : HStack
            .background(Color(hex: "fea443"))
            .padding(.bottom, 20)
            
            Text("1️⃣ 작성자")
                .font(.title2)
                .bold()
                .padding(.leading, 15)
            
            TextField("사용자 이름 입력하세요", text: $viewModel.userName)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Text("2️⃣ 제목")
                .font(.title2)
                .bold()
                .padding(.leading, 15)
            
            TextField("제목을 입력하세요", text: $viewModel.title)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Text("3️⃣ 내용")
                .font(.title2)
                .bold()
                .padding(.leading, 15)
            
            ZStack(alignment: .topLeading) {
                
                TextEditor(text: $viewModel.contents)
                    .frame(height: 120)
                    .cornerRadius(10)
                    .padding()
                
                if viewModel.contents.isEmpty {
                    Text("내용을 입력하세요")
                        .foregroundColor(Color(hex: "D3D3D3"))
                        .padding()
                        .padding(.top, 8)
                        .padding(.leading, 5)
                }
            } // : ZStack
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
            .padding()
            
            Spacer()
            
            Button(action: {
                if viewModel.userName.isEmpty || viewModel.title.isEmpty || viewModel.contents.isEmpty {
                    print("⚠️ 모든 필드를 입력해주세요.")
                    return
                }
                
                Task{
                    if let id = boardID {
                        //edit
                        let data = BoardModel(userName: viewModel.userName, title: viewModel.title, contents: viewModel.contents)
                        await viewModel.updateBoardDetail(id, data: data)
                    } else {
                        //post
                        let data = BoardModel(userName: viewModel.userName, title: viewModel.title, contents: viewModel.contents)
                        await viewModel.postBoard(data)
                    }
                    navigationManager.pop()
                    
                }
            }){
                Text("확인")
                    .font(.title3)
                    .frame(maxWidth:.infinity)
                    .padding(.vertical)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(hex: "fea443"))
            .padding()
            
            Spacer()
            
        } // : VStack
        .frame(maxWidth:.infinity, maxHeight: .infinity )
        .navigationBarBackButtonHidden(true)
        .onAppear{
            Task{
                await viewModel.getBoardDetail(boardID)
            }
        }
    }
}

#Preview {
    WriteView(viewModel: WriteViewModel(boardRepository: BoardRepository()), boardID: nil)
}
