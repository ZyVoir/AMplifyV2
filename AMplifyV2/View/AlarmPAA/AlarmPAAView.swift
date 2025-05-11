//
//  AlarmPAAView.swift
//  AMplifyV2
//
//  Created by William on 08/05/25.
//

import SwiftUI

struct AlarmPAAView: View {
    
    @EnvironmentObject var viewModel : AlarmPAAViewModel
    var body: some View {
        
        ZStack {
            Color.white
            
            
            VStack (spacing : 20) {
                Image(systemName: Icons.alarm.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 46, height: 46)
                    .foregroundStyle(Color.Primary)
                
                VStack (spacing : 5) {
                    Text("Morning Alarm")
                        .font(.system(size: 24, weight: .semibold))
                    
                    Text("Set your morning alarm to use the feature")
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
