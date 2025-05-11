//
//  ArriveAtADASetupView.swift
//  AMplifyV2
//
//  Created by William on 09/05/25.
//

import SwiftUI

struct arriveAtADASetupView : View {
    
    @EnvironmentObject var viewModel: ArriveAtADAViewModel
    
    var body: some View {
        VStack (spacing : 20) {
            Image(systemName: Icons.arriveAtADA.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .foregroundStyle(Color.Primary)
            
            VStack (spacing : 5) {
                Text("Journey to ADA")
                    .font(.system(size: 24, weight: .semibold))
                
                Text("Set your Journey to ADA to use the feature")
                    .font(.system(size: 12, weight: .regular))
            }
            
            Button {
                viewModel.showSetup()
            } label: {
                Text("Setup")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .background(RoundedRectangle(cornerRadius: 6).fill(Color.Primary))
            }
           
            
        }
        .sheet(isPresented: $viewModel.isShowSetup) {
            NavigationStack {
                ArriveAtADASetupSheetView()
            }
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
        }
        
        
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
