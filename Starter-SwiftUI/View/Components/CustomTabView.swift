//
//  CustomTabView.swift
//  Starter-SwiftUI
//
//  Created by 이유현 on 4/17/25.
//

import SwiftUI

struct CustomTabView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    let currentView: ViewType
    
    var body: some View {
        HStack{
            Spacer()
            
            Button(action: {
                navigationManager.currentTab = .MyView
            }){
                VStack{
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 30))
                        .foregroundStyle(Color(hex: currentView == .MyView ? "fea443" : "DEDEDE"))
                    
                    Text("my")
                        .foregroundStyle(Color(hex: currentView == .MyView ? "fea443" : "DEDEDE"))
                }
            }
            
            Spacer()
            
            Button(action: {
                navigationManager.currentTab = .HomeView
            }){
                VStack{
                    Image(systemName: "house.fill")
                        .font(.system(size: 30))
                        .foregroundStyle(Color(hex: currentView == .HomeView ? "fea443" : "DEDEDE"))
                    
                    Text("home")
                        .foregroundStyle(Color(hex: currentView == .HomeView ? "fea443" : "DEDEDE"))
                }
            }
            
            Spacer()
            
            Button(action: {
                navigationManager.currentTab = .MoreView
            }){
                VStack{
                    Image(systemName: "ellipsis.circle.fill")
                        .font(.system(size: 30))
                        .foregroundStyle(Color(hex: currentView == .MoreView ? "fea443" : "DEDEDE"))
                
                    Text("more")
                        .foregroundStyle(Color(hex: currentView == .MoreView ? "fea443" : "DEDEDE"))
                }
            }
            
            Spacer()
            
        } // : HStack
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.white)
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
}

#Preview {
    CustomTabView(currentView: .HomeView)
        .environmentObject(NavigationManager())
}
