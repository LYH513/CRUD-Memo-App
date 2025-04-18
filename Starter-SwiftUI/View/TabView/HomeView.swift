//
//  HomeView.swift
//  Starter-SwiftUI
//
//  Created by 이유현 on 4/17/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    @ObservedObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    @State private var boardList: [BoardModel] = []
    
    var body: some View {
            VStack(spacing: 0){
                HStack(spacing: 0){
                    Text("😎 멋진 개발자 메모")
                        .font(.largeTitle).bold()
                        .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        print("메모 추가 버튼 클릭!")
                        navigationManager.push(.WriteView(boardID: nil))
                    }){
                        Image(systemName: "pencil.tip.crop.circle.badge.plus")
                            .font(.system(size: 30))
                    }
                    .padding(.trailing, 10)
                    
                } // : HStack
                
                ScrollView{
                    
                    Spacer()
                        .frame(height: 15)
                    
                    ForEach(boardList, id:\.boardID){ item in
                        VStack(alignment: .leading){
                            HStack{
                                Text(item.userName)
                                    .font(.title)
                                    .bold()
                                
                                Spacer()
                                
                                Text(item.createdAt ?? " ")
                                
                                Spacer()
                            } // HStack
                            .padding(.horizontal)
                            .padding(.top)
                            
                            Text("✏️ \(item.title)")
                                .font(.system(size:20))
                                .bold()
                                .padding(.horizontal)
                                .padding(.top, 5)
                            
                            Text(item.contents)
                                .multilineTextAlignment(.leading)
                                .font(.system(size:20))
                                .padding(.horizontal)
                                .padding(.top, 5)
                            
                            Spacer()
                            
                        } // : VStack
                        .frame(width: 350, height: 200)
                        .background(.white)
                        .cornerRadius(20)
                        .onTapGesture{
                            navigationManager.push(.DetailView(boardID: item.boardID))
                        }
                        .padding()
                    } // : ForEach
                    
                } // : ScrollView
                .frame(maxWidth:.infinity, maxHeight: .infinity )
                .padding(.bottom, 100)
                .background(Color(hex: "fea443"))
            } // : VStack
            .onAppear {
                Task {
                    boardList = await viewModel.getBoardList()
                }
            }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(boardRepository: BoardRepository()))
        .environmentObject(NavigationManager())
}
