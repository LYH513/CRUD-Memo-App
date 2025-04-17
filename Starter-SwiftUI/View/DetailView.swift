//
//  DetailView.swift
//  Starter-SwiftUI
//
//  Created by 이유현 on 4/17/25.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    var boardID: String?
    
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
                
                Text(BoardModel.mockData[0].title)
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
                    navigationManager.pop()
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
                    Text("이름")
                    Text("날짜")
                    
                    Spacer()
                }
                .padding(.bottom, 10)
                
                Text("내용")
                
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
    }
}

#Preview {
    DetailView()
}
