//
//  MorningRoutineView.swift
//  AMplifyV2
//
//  Created by William on 08/05/25.
//

import SwiftUI

struct MorningRoutineView: View {
    
    @EnvironmentObject var viewModel : MorningRoutineViewModel
    
    var body: some View {
        
        ZStack {
            Color.white
            
            VStack (spacing : 20) {
                Image(systemName: Icons.morningRoutine.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .foregroundStyle(Color.Primary)
                
                VStack (spacing : 5) {
                    Text("Morning Routine")
                        .font(.system(size: 24, weight: .semibold))
                    
                    Text("Set your morning routine to use the feature")
                        .font(.system(size: 12, weight: .regular))
                }
                
                Button {
                } label: {
                    Text("Setup")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 15)
                        .background(RoundedRectangle(cornerRadius: 6).fill(Color.Primary))
                }
                
                
            }
            .sheet(isPresented: .constant(false)) {
                NavigationStack {
                    
                }
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
            }
            
        }
        .overlay (RoundedRectangle(cornerRadius: 7)
            .stroke(Color.Primary, lineWidth: 2))
        .padding(.horizontal)
        
        
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
