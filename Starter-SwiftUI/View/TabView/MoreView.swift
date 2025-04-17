//
//  MoreView.swift
//  Starter-SwiftUI
//
//  Created by 이유현 on 4/17/25.
//

import SwiftUI

struct MoreView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
            VStack(spacing: 0){
                HStack(spacing: 0){
                    Text("😎 멋진 개발자 순위")
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
                
                List{
                    ForEach(1...3, id:\.self){ index in
                        VStack{
                            Text("💡 \(index) : ...")
                                .bold()
                        }
                        .padding()
                    } // : ForEach
                } // : List
                .listStyle(.automatic)
                .scrollContentBackground(.hidden) // 리스트 기본 배경 제거
                .background(Color(hex: "fea443"))
                
            } // : VStack
    }
}

#Preview {
    MoreView()
        .environmentObject(NavigationManager())
}
