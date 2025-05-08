//
//  AlarmPAAView.swift
//  AMplifyV2
//
//  Created by William on 08/05/25.
//

import SwiftUI

struct AlarmPAAView: View {
    var body: some View {
        
        ZStack {
            Color.white
            
            VStack {
                Text("Test")
                Text("test")
            }
        }
        .overlay (RoundedRectangle(cornerRadius: 7)
            .stroke(Color.Primary, lineWidth: 2))
        .padding(.horizontal)
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
