//
//  ArriveAtADAActiveView.swift
//  AMplifyV2
//
//  Created by William on 09/05/25.
//

import SwiftUI

struct ArriveAtADAActiveView: View {
    var body: some View {
        VStack (alignment: .center,spacing: 15) {
            CircularTimerView()
            locationTextView()
            ClockInButtonView()
        }
        .frame(maxHeight: .infinity)
    }
}

struct CircularTimerView : View {
    
    private var color : Color = .Primary
    private let width : CGFloat = 15
    
    @EnvironmentObject var viewModel : ArriveAtADAViewModel
    
    var body: some View {
        ZStack {
            Circle().stroke(color.opacity(0.3), lineWidth: width)
            
            Circle().trim(from: 0, to: viewModel.progress)
                .stroke(color, style: StrokeStyle(lineWidth: width, lineCap: .round))
                .rotationEffect(.degrees(-90))
            
            VStack {
                Image(systemName: Icons.arriveAtADA.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .foregroundStyle(color)
                if let timer = viewModel.timerCountDown {
                    Text(timerInterval: timer, countsDown: true)
                        .font(.system(size: 40, weight: .semibold))
                }
            }
            
        }.padding(.horizontal, 80)
    }
}

struct locationTextView : View {
    @EnvironmentObject var locationManager : LocationManager
    
    var body : some View {
        VStack (spacing: 0) {
            Text("\(locationManager.formattedDistanceFromAcademy) Km")
                .font(.system(size: 32, weight: .semibold))
            
            Text("From the academy!")
                .font(.system(size: 16, weight: .regular))
        }
    }
}

struct ClockInButtonView : View {
    
    @EnvironmentObject var locationManager : LocationManager
    @EnvironmentObject var viewModel : ArriveAtADAViewModel
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body : some View {
        Button {
            // TODO: COMPLETE HANDLING
            viewModel.onClockIn(homeViewModel: homeViewModel)
        } label : {
            HStack {
                Text("Clock In")
                Image(systemName: "arrow.right")
            }
            .font(.system(size: 16, weight: .bold))
            .foregroundStyle(.white)
            .padding()
            .background(RoundedRectangle(cornerRadius: 6).fill(locationManager.clockInEnabled ? Color.Primary : Color.gray))
        }
        .alert(viewModel.alertState.title,isPresented: $viewModel.isShowAlert) {
            Button("Clock In"){
                viewModel.redirectToCiCo()
            }
        } message: {
            Text(viewModel.alertState.message)
        }
        .disabled(!locationManager.clockInEnabled)
    }
}

#Preview {
    UserDefaults.standard.set(QuestState.ready.value, forKey: "ArriveAtADAState")
    return HomeView()
        .environmentObject(HomeViewModel())
        .environmentObject(NotificationManager())
        .environmentObject(LocationManager())
}

