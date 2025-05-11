//
//  ArriveAtADAReadyView.swift
//  AMplifyV2
//
//  Created by William on 09/05/25.
//

import SwiftUI

struct arriveAtADAReadyView : View {
    
    @EnvironmentObject var viewModel: ArriveAtADAViewModel
    @EnvironmentObject var locationManager : LocationManager
    var body: some View {
        VStack (spacing : 20) {
            
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
            .padding()
            
            Spacer()
            
            Image(systemName: Icons.arriveAtADA.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .foregroundStyle(Color.Primary)
            
            VStack (spacing : 5) {
                Text("Journey to ADA")
                    .font(.system(size: 24, weight: .semibold))
                
                Text("Start your journey to the academy!")
                    .font(.system(size: 12, weight: .regular))
            }
            
            VStack (spacing: 10){
                Button {
                    // TODO: Start an activity with widget extension (activityKit)
                    viewModel.startActivity(locationManager: locationManager)
                } label: {
                    Text("Start Activity")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 15)
                        .background(RoundedRectangle(cornerRadius: 6).fill(Color.Primary))
                }
                
                Button {
                    viewModel.showAlertNotWorking()
                } label: {
                    Text("Day Off")
                        .font(.system(size: 12, weight: .regular))
                        .underline()
                        .foregroundStyle(Color.Primary)
                }
                Spacer()
            }
            Spacer()
        }
        .alert(viewModel.alertState.title,isPresented: $viewModel.isShowAlert) {
            Button("Cancel", role: .cancel){
                viewModel.dismissAlert()
            }
            Button("Confirm", role: .destructive){
                viewModel.notWorkingConfirmed()
            }
        } message: {
            Text(viewModel.alertState.message)
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
    UserDefaults.standard.set(QuestState.ready.value, forKey: "ArriveAtADAState")
    return HomeView()
        .environmentObject(HomeViewModel())
        .environmentObject(LocationManager())
        .environmentObject(NotificationManager())
}
