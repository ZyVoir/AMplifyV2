//
//  ArriveAtADACompletedView.swift
//  AMplifyV2
//
//  Created by William on 09/05/25.
//

import SwiftUI

struct ArriveAtADACompletedView: View {
    
    @EnvironmentObject var viewModel : ArriveAtADAViewModel
    
    var body: some View {
        VStack (spacing : 25){
            HStack {
                Spacer()
                
                Button {
                    viewModel.showSetup()
                } label : {
                    Image(systemName: Icons.setting.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24, alignment: .trailing)
                        .foregroundStyle(Color.gray)
                }
            }
            Spacer()
            
            Image(systemName: Icons.questDone.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .foregroundStyle(Color.green)
            VStack (spacing : 10) {
                Text("Journey To ADA")
                    .font(.system(size: 24, weight: .semibold))
                Text("See you next morning!")
                    .font(.system(size: 12, weight: .regular))
            }
            Spacer(minLength: 100)
        }
        .padding()
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
        .environmentObject(LocationManager())
        .environmentObject(NotificationManager())
}

#Preview {
    UserDefaults.standard.set(QuestState.completed.value, forKey: "ArriveAtADAState")
    return HomeView()
        .environmentObject(HomeViewModel())
        .environmentObject(NotificationManager())
        .environmentObject(LocationManager())
}
