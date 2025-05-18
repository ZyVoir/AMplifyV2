//
//  arriveAtADAView.swift
//  AMplifyV2
//
//  Created by William on 08/05/25.
//

import SwiftUI

struct ArriveAtADAView: View {
    @EnvironmentObject var viewModel: ArriveAtADAViewModel
    
    var body: some View {
        ZStack {
            Color.white
            
            switch viewModel.state {
            case .new:
                ArriveAtADASetupView()
            case .ready:
                ArriveAtADAReadyView()
            case .active:
                ArriveAtADAActiveView()
            case .completed:
                ArriveAtADACompletedView()
            }
        }
        .overlay (RoundedRectangle(cornerRadius: 7)
            .stroke(viewModel.state == .completed ? Color.green : Color.Primary , lineWidth: viewModel.state == .new ? 1 : 3))
        .padding(.horizontal)
    }
}

#Preview {
    UserDefaults.standard.set(QuestState.active.value, forKey: "ArriveAtADAState")
    return HomeView()
        .environmentObject(HomeViewModel())
        .environmentObject(NotificationManager())
}
