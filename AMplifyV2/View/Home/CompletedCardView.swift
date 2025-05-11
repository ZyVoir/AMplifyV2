//
//  HomeHeaderCard.swift
//  AMplifyV2
//
//  Created by William on 08/05/25.
//

import SwiftUI

struct CompletedCardView: View {
    
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack (spacing: 15){
            HStack (alignment: .center,spacing: 15) {
                
                Image(systemName: Icons.questCompleted.rawValue)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Color.Primary)
                
                Text("\(Text("\(viewModel.completedQuest)").foregroundStyle(Color.Primary)) \(Text("/ \(viewModel.maxCompletedQuest)").foregroundStyle(Color.black))")
                    .lineLimit(1)
                    .font(.system(size: 36, weight: .medium))
            }
            
            Text("Completed")
                .font(.system(size: 20, weight: .regular))
            
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 17)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.white).stroke(LinearGradient.SplashBG, lineWidth: 2))
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
        .environmentObject(NotificationManager())
}
