//
//  HomeView.swift
//  AMplifyV2
//
//  Created by William on 07/05/25.
//

import SwiftUI


struct HomeView: View {
    @EnvironmentObject var viewModel : HomeViewModel
   
    // Initialize sub view's view model
    @StateObject private var alarmPAAViewModel : AlarmPAAViewModel = AlarmPAAViewModel()
    
    @StateObject private var morningRoutineViewModel : MorningRoutineViewModel = MorningRoutineViewModel()
    
    @StateObject private var arriveAtADAViewModel : ArriveAtADAViewModel = ArriveAtADAViewModel()
    
    // For SegmentedPickerStyle Color and Selected Color
    init () {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(.Primary)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    var body: some View {
        ZStack {
            Color.GreyBG.edgesIgnoringSafeArea(.all)
            VStack (spacing: 22) {
                HomeHeader()
                    .padding(.bottom, 5)
                
                LazyVGrid(columns: HomeViewModel.gridColumns, spacing: 10) {
                    StreakCardView()
                    CompletedCardView()
                }
                .padding()
                
                Text("Your Daily Quest 🎯")
                    .font(.system(size: 22, weight: .bold))
                
                Picker("Pick", selection: $viewModel.menuSelectedIndex) {
                    segmentIcon(icon: Icons.alarm.rawValue,size: 16)
                        .tag(0)
                    segmentIcon(icon: Icons.morningRoutine.rawValue)
                        .tag(1)
                    segmentIcon(icon: Icons.arriveAtADA.rawValue)
                        .tag(2)
                }
                .frame(height: 43)
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                switch viewModel.menuState {
                case .alarm:
                    AlarmPAAView()
                        .environmentObject(alarmPAAViewModel)
                case .morningRoutine:
                    MorningRoutineView()
                        .environmentObject(morningRoutineViewModel)
                case .arriveAtADA:
                    ArriveAtADAView()
                        .environmentObject(arriveAtADAViewModel)
                }
            }
        }
    }
}

struct segmentIcon: View {
    
    var icon : String = ""
    var size : CGFloat = 18
    
    var body: some View {
        Image(systemName: icon)
            .resizable()
            .scaledToFit()
            .frame(width: 18, height: 18)
    }
}

struct HomeHeader: View {
    var body: some View {
        HStack {
            Text("AMplify your day! 🌤️")
                .font(.system(size: 28, weight: .bold, design: .default))
                .foregroundStyle(.white)
            Spacer()
            Button {
                
            } label : {
                Image(systemName: "questionmark.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 26, height: 26)
                    .foregroundStyle(.white)
            }
        }
        .padding()
        .background(UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 10, bottomTrailing: 10)).fill(Color.Primary).ignoresSafeArea())
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}

extension UISegmentedControl {
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}
