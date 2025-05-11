//
//  ArriveAtADASetupSheetView.swift
//  AMplifyV2
//
//  Created by William on 08/05/25.
//

import SwiftUI

struct ArriveAtADASetupSheetView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel : ArriveAtADAViewModel
    @EnvironmentObject var locationManager : LocationManager
    @EnvironmentObject var homeViewModel : HomeViewModel
    @EnvironmentObject var notificationManager : NotificationManager
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text("SESSION").font(.system(size: 13, weight: .medium))
                .padding(.leading,40)
                .padding(.top, 20)
                .foregroundStyle(.gray)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                SessionCardView(type: .morning, selectedSessionType: $viewModel.sessionSelection)
                SessionCardView(type: .afternoon, selectedSessionType: $viewModel.sessionSelection)
            }
            .padding()
            List {
                Section(header: Text("Location"), footer: Text("Track user’s location relative to the Apple Academy. If toggled Off, application cannot determine user location and will not able to clock in using AMplify")){
                    Picker("Prior Reminder", selection: $viewModel.priorReminderSelection) {
                        ForEach(PriorReminder.allCases, id: \.self){ option in
                            Text(option.description)
                        }
                    }
                    
                    if viewModel.isLocationEnabled {
                        HStack {
                            Text("Location")
                            Spacer()
                            Image(systemName: Icons.checklist.rawValue)
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundStyle(.green)
                        }
                    }
                    else {
                        Toggle("Location", isOn: $viewModel.isLocationEnabled)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .onChange(of: viewModel.isLocationEnabled) { _, newValue in
                if newValue {
                    viewModel.requestPermission(locationManager: locationManager)
                }
            }
            .onChange(of: locationManager.authorizationStatus) { oldValue, newValue in
                if newValue == .denied {
                    viewModel.alertLocationNotEnabled(isRejected: true)
                }
            }
            Spacer()
        }
        .scrollContentBackground(.hidden)
        .background(Color.GreyBG)
        .padding(.top,1)
        .navigationTitle("Journey to ADA Setup")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Back") {
                    dismiss()
                }
            }
           ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    viewModel.onSetupSheetSaved(locationManager: locationManager, homeViewModel: homeViewModel, notificationManager: notificationManager)
                }
            }
        }
        .alert(viewModel.alertState.title,isPresented: $viewModel.isShowAlert) {
            Button("Confirm", role: .cancel){
                viewModel.dismissAlert()
            }
        } message: {
            Text(viewModel.alertState.message)
        }
        
        
    }
}

struct SessionCardView: View {
    
    var type : LearnerSessionType
    @Binding var selectedSessionType : LearnerSessionType
    
    var isActive : Bool {
        return selectedSessionType == type
    }
    
    var body: some View {
        VStack (spacing: 15){
            Text(type.title).font(.system(size: 13, weight: .bold))
            
            Image(systemName: type.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 64, height: 64)
            
        }
        .foregroundStyle(isActive ? Color.white : Color.gray)
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 8).fill(isActive ? type.bg : LinearGradient.white))
        .onTapGesture {
            withAnimation {
                selectedSessionType = type
            }
        }
    }
}

#Preview {
    ArriveAtADASetupSheetView()
        .environmentObject(ArriveAtADAViewModel())
        .environmentObject(LocationManager())
        .environmentObject(NotificationManager())
    //    HomeView()
    //        .environmentObject(HomeViewModel())
}
