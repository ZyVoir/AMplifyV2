//
//  ContentView.swift
//  watchOS Watch App
//
//  Created by William on 23/05/25.
//

import SwiftUI


struct WatchArriveAtADADeactiveView: View {
    var body: some View {
        VStack (spacing: 15){
            Image(systemName: "iphone.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 45,height: 45)
                .foregroundStyle(Color.Primary)
            
            Text("No Activity\nStarted!")
                .multilineTextAlignment(.center)
        }
    }
}

struct WatchArriveAtADAActiveView: View {
    
    
    @Environment(WatchArriveAtADAViewModel.self) var viewModel
    
    
    var body: some View {
        
        let color : Color = .Primary
        let width : CGFloat = 5
        
        VStack (spacing: 20) {
            
            
            ZStack {
                Circle().stroke(color.opacity(0.3), lineWidth: width)
                
                Circle().trim(from: 0, to: 100)
                    .stroke(color, style: StrokeStyle(lineWidth: width, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                
                VStack {
                    
                    
                    
                    Text(timerInterval: Date()...viewModel.sessionSelection.time , countsDown: true)
                        .foregroundStyle(Color.Primary)
                        .font(.system(size: 20,weight: .bold))
                    
                    
                    HStack {
                        Text("10")
                            .foregroundStyle(Color.Primary)
                            .font(.system(size: 20,weight: .bold))
                        Text("Km")
                    }
                    
                    
                }
                
            }
            
            
            
            Button {
                
            } label : {
                Text("Clock In")
                    .font(.system(size: 16, weight: .medium))
            }
            .background(Color.Primary)
            .clipShape(Capsule())
        }
    }
}

struct ContentView: View {
    
    @Environment(WatchArriveAtADAViewModel.self) var viewModel
    
    var body: some View {
        VStack {
            TabView {
                Tab {
                    switch viewModel.state {
                    case .active:
                        WatchArriveAtADAActiveView()
                    default :
                        WatchArriveAtADADeactiveView()
                    }
                }
                Tab {
                    Text("State")
                    if let state = viewModel.state {
                        Text("\(state)")
                    }
                }
            }
            .tabViewStyle(.verticalPage)
        }
    }
}

#Preview {
    ContentView()
        .environment(WatchArriveAtADAViewModel(sessionSelection: .morning, state: .ready))
        .environment(WatchToIOSConnectorManager())
}
