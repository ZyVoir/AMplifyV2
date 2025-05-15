//
//  ArriveAtADALiveActivity.swift
//  ArriveAtADA
//
//  Created by William on 13/05/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ArriveAtADALiveActivity: Widget {
    
    @Environment(\.activityFamily) var activityFamily
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ArriveAtADAAttributes.self) { context in
            // Lock screen/banner UI goes here
            MainLiveActivityView(context: context)

        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Image("LogoLiveActivity")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("📌")
                        .font(.system(size: 25))
                        .padding([.top, .trailing],7)
                }
                DynamicIslandExpandedRegion(.center) {
                    centerLiveActivityView()
                }
                DynamicIslandExpandedRegion(.bottom) {
                    bottomLiveActivityView(context: context)
                }
            } compactLeading: {
                HStack {
                    Text("📌")
                }
            } compactTrailing: {
                HStack (alignment: .lastTextBaseline, spacing: 3){
                    
                    Text("\(IOHelper.shared.formattedDistance(distance: context.state.distance))")
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .foregroundStyle(Color.Primary)
                    Text("Km")
                }
            } minimal: {
                Text("\(IOHelper.shared.formattedDistance(distance: context.state.distance))")
                    .font(.system(size: IOHelper.shared.formattedDistance(distance: context.state.distance).count > 3 ? 12 : 15, weight: .bold, design: .default))
                    .foregroundStyle(Color.Primary)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
        .supplementalActivityFamilies([.small])
    }
}

struct MainLiveActivityView: View {
    @Environment(\.activityFamily) var activityFamily
    
    var context : ActivityViewContext<ArriveAtADAAttributes>
    var body : some View {
        switch activityFamily {
        case .small:
            watchOSLiveActivityView(context: context)
        case .medium:
            VStack {
                HStack (alignment: .center) {
                    Image("LogoLiveActivity")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    Spacer()
                    Text("📌")
                        .font(.system(size: 24))
                        .padding([.top, .trailing],7)
                }
                centerLiveActivityView()
                bottomLiveActivityView(context: context)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .foregroundStyle(.white)
            .activityBackgroundTint(Color.Primary)
            .activitySystemActionForegroundColor(Color.Primary)
        @unknown default:
            EmptyView()
        }
    }
}

struct watchOSLiveActivityView: View {
    var context : ActivityViewContext<ArriveAtADAAttributes>
    var body : some View {
        HStack (spacing: 12){
//            ProgressView(timerInterval: Date()...Date().addingTimeInterval(100), countsDown: true)
//                .tint(Color.Primary)
//                .progressViewStyle(.circular)
//                .padding([.leading, .top, .bottom], 10)
            ZStack (alignment: .center){
                Circle().stroke(Color.Primary, lineWidth: 5)
                Image(systemName: "apple.logo")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
            }
            .padding([.bottom, .top], 15)
            .padding(.leading,10)
                
            VStack (alignment: .leading){
                HStack (alignment: .lastTextBaseline,spacing: 4){
                    Text("\(IOHelper.shared.formattedDistance(distance: context.state.distance))")
                        .foregroundStyle(Color.Primary)
                        .font(.system(size: 20, weight: .bold))
                    Text("Km away")
                        .font(.system(size: 12, weight: .regular))
                        .lineLimit(1)
                }
                .fontWeight(.semibold)
                Text(timerInterval: Date()...context.attributes.endTime, countsDown: true)
                    .font(.system(size: 25, weight: .bold))
                    .lineLimit(1)
                    .foregroundStyle(Color.Primary)
            }
        }
     
    }
}

struct centerLiveActivityView : View {
    var body : some View {
        VStack (spacing: 15) {
            Image(systemName: "apple.logo")
            Text("Go to The Academy!")
                .font(.system(size: 12, weight: .regular))
        }
    }
}

struct bottomLiveActivityView : View {
    var context : ActivityViewContext<ArriveAtADAAttributes>
    
    var body : some View {
        HStack (alignment: .lastTextBaseline){
            HStack (alignment: .lastTextBaseline, spacing: 5){
                
                Text("\(IOHelper.shared.formattedDistance(distance: context.state.distance))")
                    .font(.system(size: 32, weight: .semibold, design: .default))
                    .foregroundStyle(Color.Primary)
                Text("Km away")
                    .font(.system(size: 15, weight: .semibold))
            }
            Spacer()
            Text(timerInterval: Date()...context.attributes.endTime, countsDown: true)
                .multilineTextAlignment(.trailing)
                .font(.system(size: 40, weight: .bold))
                .foregroundStyle(Color.Primary)
        }
    }
}

extension ArriveAtADAAttributes {
    fileprivate static var preview: ArriveAtADAAttributes {
        ArriveAtADAAttributes(endTime: Date().addingTimeInterval(100))
    }
}

extension ArriveAtADAAttributes.ContentState {
    fileprivate static var defaultState: ArriveAtADAAttributes.ContentState {
        ArriveAtADAAttributes.ContentState(distance: 0.90)
     }
}

#Preview("Notification", as: .dynamicIsland(.minimal), using: ArriveAtADAAttributes.preview) {
   ArriveAtADALiveActivity()
} contentStates: {
    ArriveAtADAAttributes.ContentState.defaultState
}

#Preview("Notification", as: .content, using: ArriveAtADAAttributes.preview) {
   ArriveAtADALiveActivity()
} contentStates: {
    ArriveAtADAAttributes.ContentState.defaultState
}
