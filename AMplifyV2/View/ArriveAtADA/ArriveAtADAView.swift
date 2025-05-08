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
                Text("test")
            case .ready:
                arriveAtADAReadyView()
            case .active:
                Text("Active")
            case .completed:
                arriveAtADASetupView()
            }
        }
        .overlay (RoundedRectangle(cornerRadius: 7)
            .stroke(Color.Primary, lineWidth: 2))
        .padding(.horizontal)
    }
}

struct arriveAtADAReadyView : View {
    
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
                
                Text("Start your journey to the academy!")
                    .font(.system(size: 12, weight: .regular))
            }
            
            VStack (spacing: 10){
                Button {
                    // TODO: Start an activity with widget extension (activityKit)
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
                    Text("Now Working Today?")
                        .font(.system(size: 12, weight: .regular))
                        .underline()
                        .foregroundStyle(Color.Primary)
                }
                
            }
            
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
        
        
    }
}

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
               // TODO: Modality to setup
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
