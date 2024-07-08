//
//  HistoryViewModel.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import Foundation

struct DateItem: Identifiable, Equatable {
    var id: UUID = UUID()
    var month: String
    var day: String
}

class ScheduleViewModel: ObservableObject {
    @Published var historyArray: [ScheduleItemModel] = [
        ScheduleItemModel(name: "Oduvanchik", schedule_time: "Scheduled on 07/06/2024 7:00", moisture: "47 %", moistureInt: 47),
        ScheduleItemModel(name: "Podsolnuh", schedule_time: "Scheduled on 08/06/2024 8:00", moisture: "29 %", moistureInt: 29),
        ScheduleItemModel(name: "Rosa", schedule_time: "Scheduled on 09/06/2024 9:00", moisture: "17 %", moistureInt: 17)
    ]
    
    // TODO: В расписании полива данные будут храниться следующим образом:
    // id и имя цветка
    // Дата полива (она может быть как в прошлом, так и в будущем)
    
    @Published var futureDateArray: [DateItem] = [DateItem(month: ".01", day: "11"),
                                                  DateItem(month: ".02", day: "12"),
                                                  DateItem(month: ".03", day: "13"),
                                                  DateItem(month: ".04", day: "11"),
                                                  DateItem(month: ".05", day: "11"),
                                                  DateItem(month: ".06", day: "11"),
                                                  DateItem(month: ".07", day: "11"),
                                                  DateItem(month: ".08", day: "11"),
                                                  DateItem(month: ".09", day: "11"),
                                                  DateItem(month: ".10", day: "11"),
                                                  DateItem(month: ".11", day: "11"),
                                                  DateItem(month: ".12", day: "11")]
    
    @Published var pastDateArray: [DateItem] = [DateItem(month: ".07", day: "11"),
                                                DateItem(month: ".08", day: "12"),
                                                DateItem(month: ".09", day: "13"),
                                                DateItem(month: ".07", day: "11"),
                                                DateItem(month: ".07", day: "11"),
                                                DateItem(month: ".07", day: "11"),
                                                DateItem(month: ".07", day: "11"),
                                                DateItem(month: ".07", day: "11"),
                                                DateItem(month: ".07", day: "11"),
                                                DateItem(month: ".07", day: "11"),
                                                DateItem(month: ".07", day: "11"),
                                                DateItem(month: ".07", day: "11")]
    
}
