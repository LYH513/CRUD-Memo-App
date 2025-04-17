//
//  MyView.swift
//  Starter-SwiftUI
//
//  Created by 이유현 on 4/17/25.
//

import SwiftUI

struct MyView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
            VStack(spacing: 0){
                HStack(spacing: 0){
                    Text("😎 멋진 개발자인 나")
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
                
                VStack{
                    HStack{
                        Circle()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.white)
                            .overlay {
                                Image("myIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                            }
                        
                        VStack(alignment: .leading, spacing: 10){
                            Text("이름: 이유현")
                                .font(.system(size: 24))
                                .bold()
                            
                            Text("나이: 24")
                                .font(.system(size: 24))
                                .bold()
                            
                            Text("성별: 여자")
                                .font(.system(size: 24))
                                .bold()
                            
                            Text("전공: 컴퓨터 공학")
                                .font(.system(size: 24))
                                .bold()
                        }
                    } // : HStack
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(20)
                    .padding(.vertical, 20)
                    
                    
                    ForEach(1...4, id:\.self){ index in
                        HStack{
                            Text("\(index). ")
                                .padding(.leading, 20)
                            
                            switch index{
                            case 1 :
                                Text("Swift(SwiftUI/ UIKit)")
                            case 2 :
                                Text("HTML/CSS/JavaScript")
                            case 3 :
                                Text("React")
                            case 4:
                                Text("Java (Spring Boot)")
                            default:
                                Text("그외")
                            }
                            
                            Spacer()
                        }
                        .font(.system(size : 24))
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(.white)
                        .cornerRadius(20)
                        
                    } // ForEach
                    
                    Spacer()
                    
                } // : VStack
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(hex: "fea443"))
                
            } // : VStack
    }
}

#Preview {
    MyView()
        .environmentObject(NavigationManager())
}
