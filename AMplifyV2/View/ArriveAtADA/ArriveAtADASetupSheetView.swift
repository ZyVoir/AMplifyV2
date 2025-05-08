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
    
    var body: some View {
        VStack {
            Text("Edit something here")
                .padding()
            // Your content here
            Spacer()
        }
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
                    
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
