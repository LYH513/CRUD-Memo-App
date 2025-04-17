//
//  WriteView.swift
//  Starter-SwiftUI
//
//  Created by 이유현 on 4/17/25.
//

import SwiftUI

struct WriteView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    var boardID: String?
    
    @State private var userName: String = "이유현"
    @State private var title : String = ""
    @State private var contents: String = ""
    
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
            
            TextField("사용자 이름 입력하세요", text: $userName)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Text("2️⃣ 제목")
                .font(.title2)
                .bold()
                .padding(.leading, 15)
            
            TextField("제목을 입력하세요", text: $title)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Text("3️⃣ 내용")
                .font(.title2)
                .bold()
                .padding(.leading, 15)
            
            ZStack(alignment: .topLeading) {
                
                TextEditor(text: $contents)
                    .frame(height: 120)
                    .cornerRadius(10)
                    .padding()
                
                if contents.isEmpty {
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
                navigationManager.pop()
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
    }
}

#Preview {
    WriteView()
}
