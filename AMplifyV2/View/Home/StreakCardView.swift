
//
//  HomeHeaderCard.swift
//  AMplifyV2
//
//  Created by William on 08/05/25.
//

import SwiftUI

struct StreakCardView: View {
    
    @EnvironmentObject var viewModel : HomeViewModel
    
    var body: some View {
        VStack (spacing: 15){
            HStack (alignment: .center,spacing: 15) {
                
                Image(systemName: viewModel.isTodayDoneStreak ? Icons.streakActive.rawValue : Icons.streakInactive.rawValue)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(viewModel.isTodayDoneStreak ? LinearGradient.StreakColor : LinearGradient.greyBG)
                
                Text("\(viewModel.streakCount)")
                    .font(.system(size: 36, weight: .medium))
                    .foregroundStyle(viewModel.isTodayDoneStreak ? Color.accentOrange : Color.accentGrey)
            
            }
            
            Text("Streak")
                .font(.system(size: 20, weight: .regular))
          
        }
        .padding(.horizontal, 36)
        .padding(.vertical, 17)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.white).stroke(LinearGradient.StreakColor, lineWidth: 2))
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
