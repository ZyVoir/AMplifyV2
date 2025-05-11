//
//  ArriveAtADAViewModel.swift
//  AMplifyV2
//
//  Created by William on 08/05/25.
//

import Foundation
import SwiftUI

enum ArriveAtADAAlertState {
    case notWorking
    case onTime
    case late
    case dayStreak(count : Int)
    case errorlocationNotEnabled(isRejected : Bool = false)
    
    var title: String {
        switch self {
        case .notWorking:
            return "Day Off"
        case .onTime:
            return "On Time!"
        case .late:
            return "Late!"
        case .dayStreak(let count):
            return "\(count) Day Streak!"
        case .errorlocationNotEnabled:
            return "Could not save"
        }
    }
    
    var message: String {
        switch self {
        case .notWorking:
            return "Confirming this will not increase your streak"
        case .onTime, .late, .dayStreak:
            return "Complete your daily quests so your streak won’t reset!"
        case .errorlocationNotEnabled(let isRejected):
            return "In order to use this feature, please enable location services \(isRejected ? "from the phone settings" : "")"
        }
    }
    
    var isShowingTextField : Bool {
        switch self {
        case .notWorking:
            return true
        default:
            return false
        }
    }
}

enum LearnerSessionType {
    case morning
    case afternoon
    
    var title : String {
        switch self {
        case .morning:
            return "Morning"
        case .afternoon:
            return "Afternoon"
        }
    }
   
    var time : Date {
        switch self {
        case .morning:
            return IOHelper.shared.parseStringToDate("08:00:00")
        case .afternoon:
            return IOHelper.shared.parseStringToDate("13:00:00")
        }
    }
    
    var icon : String {
        switch self {
        case .morning:
            return Icons.morningSession.rawValue
        case .afternoon:
            return Icons.afternoonSession.rawValue
        }
    }
    
    var bg : LinearGradient {
        switch self {
        case .morning:
            return LinearGradient.morningSession
        case .afternoon:
            return LinearGradient.afternoonSession
        }
    }
    
    init(value rawValue : String) {
        switch rawValue {
        case "Morning":
            self = .morning
        case "Afternoon":
            self = .afternoon
        default:
            self = .morning
        }
    }
}

enum PriorReminder : Hashable, CaseIterable {
    case oneHour
    case twoHour
    case threeHour
    
    var time : Int {
        switch self {
        case .oneHour:
            return 1
        case .twoHour:
            return 2
        case .threeHour:
            return 3
        }
    }
    
    var description : String {
        return self.time == 1 ? "\(self.time) Hour" : "\(self.time) Hours"
    }
    
    init(time : Int){
        switch time {
        case 1:
            self = .oneHour
        case 2:
            self = .twoHour
        case 3:
            self = .threeHour
        default:
            self = .twoHour
        }
    }
    
}

final class ArriveAtADAViewModel : ObservableObject {
    
    @Published private(set) var state: QuestState = .new {
        didSet {
            UserDefaults.standard.set(state.value, forKey: "ArriveAtADAState")
        }
    }
    
    // alert
    @Published var isShowAlert : Bool = false
    @Published private(set) var alertState : ArriveAtADAAlertState
    
    // setupView
    @Published var isShowSetup : Bool = false
    
    // setupSheetView
    @Published var priorReminderSelection : PriorReminder = .twoHour {
        didSet {
            UserDefaults.standard.set(priorReminderSelection.time, forKey: "PriorReminderSelection")
        }
    }
    @Published var sessionSelection : LearnerSessionType = .morning {
        didSet {
            UserDefaults.standard.set(sessionSelection.title, forKey: "LearnerSessionType")
        }
    }
    @Published var isLocationEnabled : Bool = false {
        didSet {
            UserDefaults.standard.set(isLocationEnabled, forKey: "isLocationEnabled")
        }
    }
    
    // activeView
    @Published var timeRemaining: TimeInterval? = 0
    var totalTime: TimeInterval? = 0
    private var timer: Timer?
    
    @Published var timerCountDown : ClosedRange<Date>?
    
    var progress : CGFloat {
        return CGFloat(timeRemaining ?? 0) / CGFloat(totalTime ?? 1)
    }
    
    func showSetup() {
        isShowSetup = true
    }
    
    func showAlertNotWorking() {
        alertState = .notWorking
        isShowAlert = true
    }
    
    func notWorkingConfirmed(){
        updateState(state: .completed)
        dismissAlert()
    }
    
    func dismissAlert(){
        isShowAlert = false
    }
    
    func revertLocation() {
        withAnimation {
            isLocationEnabled = false
        }
    }
    
    func requestPermission(locationManager : LocationManager) {
        locationManager.requestPermission()
    }
    
    func startActivity(locationManager : LocationManager){
        //TODO: Enable LiveActivity
       
        //Populate the start timer, the progress bar indicator and the timer range
        let now : Date = Date()
        timerCountDown = now...( sessionSelection.time > now ? sessionSelection.time : now)
        let duration : TimeInterval = sessionSelection.time.timeIntervalSince(now)
        totalTime = duration
        timeRemaining = duration
        
        startTimer()
        
        // start Tracking Location
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startListenForLocation()
        }
        
        // Update state to active
        updateState(state: .active)
    }
    
    func onSetupSheetSaved(locationManager : LocationManager, homeViewModel : HomeViewModel?, notificationManager : NotificationManager) {
        let weekday = [2,3,4,5,6]
        // TODO: Create/UpdateNotification for starting the journey + Clockout
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: sessionSelection.time)
        
        for day in weekday {
            
            notificationManager.scheduleNotification(notificationType: .reminderToStartTheJourney, dateComponent: notificationManager.createNotifDateComponent(hour: hour - priorReminderSelection.time, weekday: day), isRepeating: true, weekday: day)
            
            notificationManager.scheduleNotification(notificationType: .reminderToClockOut, dateComponent: notificationManager.createNotifDateComponent(hour: hour+4, weekday: day), isRepeating: true, weekday: day)
        }
        
        

        if state == .ready {
            isShowSetup = false
            return
        }
        
        if [.authorizedAlways, .authorizedWhenInUse].contains(locationManager.authorizationStatus) {
            isShowSetup = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.updateState(state: .completed)
            }
            if let homeViewModel = homeViewModel, state == .new {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    // TODO: Create notification for when arriving at ADA
                    notificationManager.shceduleNotificationForLocationADA(notificationType: .closeToTheAcademy)
                    withAnimation {
                        homeViewModel.maxCompletedQuest += 1
                    }
                }
            }
            
        }
        else if locationManager.authorizationStatus == .denied {
            alertLocationNotEnabled(isRejected: true)
        }
        else {
            alertLocationNotEnabled()
        }
    }
    
    func alertLocationNotEnabled(isRejected : Bool = false) {
        alertState = .errorlocationNotEnabled(isRejected: isRejected)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.isShowAlert = true
        }
        
    }
   
    func onClockIn(homeViewModel : HomeViewModel) {
        guard let timeRemaining = self.timeRemaining else { return }
        
        if timeRemaining > 0 {
            self.alertState = .onTime
            self.isShowAlert = true
            homeViewModel.completedQuest += 1
        }
        else {
            self.alertState = .late
            self.isShowAlert = true
            homeViewModel.streakCount = 0
        }
        
        homeViewModel.streakCheckAndAdd()
    }
    
    func redirectToCiCo() {
        dismissAlert()
        updateState(state: .completed)
        if let url = URL(string: "cico:") {
            UIApplication.shared.open(url, options: [:]) {
                _ in
            }
        }
    }
    
    init() {
        self.state = QuestState(value: UserDefaults.standard.string(forKey: "ArriveAtADAState") ?? "New")
        self.alertState = .notWorking
        self.priorReminderSelection = PriorReminder(time: UserDefaults.standard.integer(forKey: "priorReminderSelection"))
        self.sessionSelection = LearnerSessionType(value: UserDefaults.standard.string(forKey: "LearnerSessionType") ?? "Morning")
        self.isLocationEnabled = UserDefaults.standard.bool(forKey: "isLocationEnabled")
    }
    
    func _adminUpdateState(state: QuestState) {
        self.state = state
    }
}

private extension ArriveAtADAViewModel {
    func updateState(state: QuestState) {
        withAnimation {
            self.state = state
        }
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
            guard let self = self else {return}
            if self.timeRemaining ?? 0 > 0 {
                withAnimation{
                    self.timeRemaining! -= 1
                }
            }
            else {
                self.timer?.invalidate()
                self.timer = nil
            }
        })
    }
}
