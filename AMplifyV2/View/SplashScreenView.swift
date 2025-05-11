//
//  SplashScreenView.swift
//  AMplifyV2
//
//  Created by William on 05/05/25.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isSplashScreenActive: Bool = true
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some View {
        if isSplashScreenActive {
            ZStack {
                LinearGradient.SplashBG
                
                Image("LOGO")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(edges: .all)
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    withAnimation {
                        isSplashScreenActive = false
                    }
                }
            }
        }
        else {
            HomeView()
                .environmentObject(homeViewModel)
        }
    }
}

#Preview {
    SplashScreenView()
}
