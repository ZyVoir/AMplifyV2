//
//  AdminView.swift
//  AMplifyV2
//
//  Created by William on 11/05/25.
//

import SwiftUI

struct AdminView: View {
    
    @EnvironmentObject var arriveAtADAViewModel : ArriveAtADAViewModel
    
    @State private var selectedStatusArriveAtADA : QuestState
    
    init () {
        self.selectedStatusArriveAtADA = QuestState(value: UserDefaults.standard.string(forKey: "ArriveAtADAState") ?? "new")
    }
    
    var body: some View {
        VStack{
            List {
                Section("ArriveAtADA") {
                    Picker ("Status", selection: $selectedStatusArriveAtADA) {
                        ForEach(QuestState.allCases, id: \.self) { status in
                            Text(status.value)
                                .tag(status)
                        }
                    }
                    .onChange(of: selectedStatusArriveAtADA) { oldValue, newValue in
                        arriveAtADAViewModel._adminUpdateState(state: newValue)
                    }
                }
            }
            Spacer()
        }
    }
    
}

#Preview {
    AdminView()
        .environmentObject(ArriveAtADAViewModel())
}
