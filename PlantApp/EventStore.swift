//
//  EventStore.swift
//  EventsWidget
//
//  Created by ProSkyMishka on 08.07.2024.
//

import Combine
import EventKit
import Foundation
import WidgetKit

@Observable
final class EventStore {
    static let shared = EventStore()
    
    private init() {
        todaysEvents = events(for: .now)
        
        // Automatically refreshes the object when a change occurs.
        NotificationCenter.default.publisher(for: .EKEventStoreChanged)
            .sink { [unowned self] in
                guard let info = $0.userInfo else { return }
                
                print(Date.now, info)
                
                // TODO: The widgets do not refresh automatically if the app is in the background.
                for (key, value) in info {
                    guard let keyString = key as? String,
                          let intValue = value as? Int else { return }
                    
                    if intValue == 1 && keyString == "EKEventStoreCalendarDataChangedUserInfoKey" {
                        todaysEvents = events(for: .now)
                        WidgetCenter.shared.reloadAllTimelines()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private var cancellables = Set<AnyCancellable>()
    private var ekEventStore = EKEventStore()
    
    private(set) var canAccessEvents = EKEventStore.authorizationStatus(for: .event) == .fullAccess
    private(set) var todaysEvents = [EKEvent]()
    
    /// Fetches the events for the whole day.
    /// - Parameter date: All events on the same day as this date will be fetched.
    /// - Returns: Chronologically sorted events.
    func events(for date: Date) -> [EKEvent] {
        let startOfDay = Calendar.current.startOfDay(for: date)
        let predicate = ekEventStore.predicateForEvents(
            withStart: startOfDay,
            end: startOfDay.advanced(by: 86400),
            calendars: nil
        )
        return ekEventStore.events(matching: predicate)
            .filter { $0.endDate > .now }
    }
    
    /// Adds a test event in the default calendar.
    func addEvent(startDate: Date, seconds: Int, plants: String) {
        let event = EKEvent(eventStore: ekEventStore)
        event.title = "Watering \(plants)"
        event.startDate = startDate
        event.endDate = startDate.advanced(by: TimeInterval(seconds))
        event.calendar = ekEventStore.defaultCalendarForNewEvents
        
        do {
            try ekEventStore.save(event, span: .thisEvent)
            try ekEventStore.commit()
        } catch {
            print(error)
        }
    }

    func clearCalendar() {
        let startOfDay = Calendar.current.startOfDay(for: .now)
        let predicate = ekEventStore.predicateForEvents(
            withStart: startOfDay,
            end: startOfDay.advanced(by: 31104000),
            calendars: nil
        )
        let ev = ekEventStore.events(matching: predicate) as [EKEvent]?
        if ev != nil {
            for i in ev! {
                do{
                    (try ekEventStore.remove(i, span: EKSpan.thisEvent, commit: true))
                }
                catch let error {
                    print("Error removing events: ", error)
                }

            }
        }
    }
    
    /// Fetches all event calendars.
    /// - Returns: Alphabetically sorted calendars.
    func calendars() -> [EKCalendar] {
        ekEventStore.calendars(for: .event)
            .sorted { $0.title.localizedStandardCompare($1.title) == .orderedAscending }
    }
    
    /// Presents the permission request to the user.
    func requestAccess() async {
        do {
            canAccessEvents = try await ekEventStore.requestFullAccessToEvents()
            ekEventStore.reset()
            todaysEvents = events(for: .now)
        } catch {
            print(error)
        }
    }
}
