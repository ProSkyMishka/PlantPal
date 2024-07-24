//
//  EventsWidget.swift
//  EventsWidget
//
//  Created by ProSkyMishka on 08.07.2024.
//

import EventKit
import Intents
import SwiftUI
import WidgetKit
import SwiftData

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }
    
    func getSnapshot(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (SimpleEntry) -> ()
    ) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }
    
    func getTimeline(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (Timeline<Entry>) -> ()
    ) {
        let entry = SimpleEntry(date: .now, configuration: configuration)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct WidgetDate: View {
    var body: some View {
        VStack(alignment: .leading, spacing: -3) {
            Text(Date.now.formatted(.dateTime.weekday(.wide)).uppercased())
                .font(.caption2.weight(.semibold))
                .foregroundStyle(.red)
            
            Text(Date.now.formatted(.dateTime.day()))
                .font(.largeTitle.weight(.light))
        }
        .padding(.leading, 4)
        .offset(y: 2)
    }
}

struct EventsWidgetEntryView: View {
    internal init(entry: Provider.Entry) {
        self.entry = entry
        self.canAccessEvents = EventStore.shared.canAccessEvents
        self.select = select
    }
    
    
    @Environment(\.widgetFamily) private var widgetFamily
    @AppStorage("Temp") var temp: Double = 0.0
    @AppStorage("Humidity") var humidity: Double = 0.0
    @State var select: SensorDevice?
//    @State var temp = 0.0
    
    
    var entry: Provider.Entry
    let canAccessEvents: Bool

    
    var displayedEvents: [EKEvent] {
        var events = EventStore.shared.events(for: entry.date)
        
        if entry.configuration.showAllCalendars != 1,
           let calendarIDs = entry.configuration.calendars?.compactMap(\.identifier) {
            events = events
                .filter { event in
                    calendarIDs.contains { $0 == event.calendar.calendarIdentifier }
                }
        }
        
        // Ensures that the events fit the size of their widgets.
        switch widgetFamily {
            case .systemSmall, .systemMedium: return Array(events.prefix(2))
            case .systemLarge: return Array(events.prefix(6))
            default: return events
        }
    }
    
    var body: some View {
        if !canAccessEvents {
            Placeholder("No Access to Events")
        } else {
            let events = displayedEvents
            
            if events.isEmpty {
                Placeholder("No waterings")
            } else {
                VStack(alignment: .leading, spacing: .zero) {
                    HStack {
                        WidgetDate()
                            .padding(.bottom, 8)
                        Spacer()
                        VStack {
                            Text(String(UserDefaults(suiteName: "group.su.brf.apps.PlantPal")?.double(forKey: "Temp") ?? 0.0) + " ºC")
                                .font(.system(size: 13))
                            Text(String(String(UserDefaults(suiteName: "group.su.brf.apps.PlantPal")?.double(forKey: "Humidity") ?? 0.0)) + " %")
                                .font(.system(size: 13))
                        }
                        
                        .onAppear {
                            Task {
                                try await getSensor()
                            }
                            
                        }
                        
                    }
                    
                    VStack(spacing: 4) {
                        ForEach(events, id: \.eventIdentifier) { event in
                            EventItem(event)
                        }
                    }
                    Spacer()
                }
                .onAppear {
                    Task {
                        try await getSensor()
                    }
                }
            }
        }
    }

    
    func getSensor() async throws {
        let defaults = UserDefaults(suiteName: "group.su.brf.apps.PlantPal")
        let accessToken = defaults?.string(forKey: "AccessToken")
        guard let url = URL(string: "https://api.iot.yandex.net/v1.0/devices/\(defaults?.string(forKey: "SelectDeviceId") ?? "")") else {
            throw Errors.badUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let access = accessToken else {
            throw Errors.notAuth
        }
        request.setValue("Bearer \(access)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(Errors.someRequestError)
                return
            }
            guard let data = data else {
                print(Errors.noDataReceived)
                return
            }
            
            do {
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                    if httpResponse.statusCode == 401 {
                        print(Errors.notAuth)
                        return
                    }
                }
                
                let _ = String(data: data, encoding: .utf8) ?? "No response string"
                
                let ourDevice = try JSONDecoder().decode(IoTDevice.self, from: data)
                var device = SensorDevice(id: ourDevice.id, name: ourDevice.name, temp: 0.0, humidity: 0.0)
                if let properties = ourDevice.properties {
                    for j in properties {
                        if let state = j?.state {
                            if state.instance == "temperature" {
                                if case .double(let value) = state.value {
                                    device.temp = value
                                }
                            } else if state.instance == "humidity" {
                                if case .double(let value) = state.value {
                                    device.humidity = value
                                }
                            }
                        }
                    }
                }
                let deviceCopy = device
                DispatchQueue.main.async {
                    if self.temp != deviceCopy.temp || self.humidity != deviceCopy.humidity {
                        self.temp = deviceCopy.temp
                        self.humidity = deviceCopy.humidity
                        WidgetCenter.shared.reloadAllTimelines()
                    }
                }
            } catch {
                print("Failed to parse JSON: \(error)")
            }
        }
        task.resume()
    }
}

@main
struct EventsWidget: Widget {
    let kind: String = "EventsWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            EventsWidgetEntryView(entry: entry)
                .containerBackground(.background, for: .widget)
                .defaultAppStorage(UserDefaults(suiteName: "group.su.brf.apps.PlantPal")!)
        }
        .configurationDisplayName("Today's Events")
        .description("Your remaining events for today.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

enum Errors: Error {
    case badUrl
    case notAuth
    case someRequestError
    case noDataReceived
}


