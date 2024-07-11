//
//  ColorLightDark.swift
//  PlantApp
//
//  Created by Lucy Rez on 11.07.2024.
//

import Foundation
import SwiftUI


class Theme {
    enum ColorTheme {
        case light
        case dark
    }
    
    static let shared = Theme()
   
    static var pink = Color(uiColor: UIColor(hex: "C3F7B6"))// фон в коллекциu
    static var backGround = Color(uiColor: UIColor(hex: "FFFEDC")) // главный светлый фон
    static var tabBar = Color(uiColor: UIColor(hex: "E2F78C"))  // светлый таббар
    static var textGreen = Color(uiColor: UIColor(hex: "079915")) // названия растения в его карточке/ название в коллекции/ характеристики в карточке
    static var textBrown = Color(uiColor: UIColor(hex: "99B008"))
    static var textAzure = Color(uiColor: UIColor(hex: "7EBDEA")) // My Plant Collection
    static var textBlue = Color(uiColor: UIColor(hex: "3154D3"))  // названия в коллекции/ характеристики в карточке растения
    static var buttonColor = Color(uiColor: UIColor(hex: "2AC1E3")) //
    static var textColor = Color(uiColor: UIColor(hex: "000000"))
    static var search = Color(uiColor: UIColor(hex: "FFF38C"))
    
    static var description = Color(uiColor: UIColor(hex: "7C947E"))

    static func changeTheme(colorTheme: ColorTheme) {
        
        switch (colorTheme) {
            case .light:
            pink = ColorLight().pink
            backGround = ColorLight().backGround
            tabBar = ColorLight().tabBar
            textGreen = ColorLight().textGreen
            textBrown = ColorLight().textBrown
            textAzure = ColorLight().textAzure
            textBlue = ColorLight().textBlue
            buttonColor = ColorLight().buttonColor
            textColor = ColorLight().textColor
            search = ColorLight().search
            description = ColorLight().description
            
            case .dark:
            pink = ColorDark().pink
            backGround = ColorDark().backGround
            tabBar = ColorDark().tabBar
            textGreen = ColorDark().textGreen
            textBrown = ColorDark().textBrown
            textAzure = ColorDark().textAzure
            textBlue = ColorDark().textYellow
            buttonColor = ColorDark().buttonColor
            textColor = ColorDark().textColor
            search = ColorDark().search
            description = ColorDark().description
        }

    }
    
    
}

struct ColorLight {
    var pink = Color(uiColor: UIColor(hex: "C3F7B6"))// фон в коллекции     уже не розовый
    var backGround = Color(uiColor: UIColor(hex: "FFFEDC")) // главный светлый фон
    var tabBar = Color(uiColor: UIColor(hex: "E2F78C")) // светлый таббар
    var textGreen = Color(uiColor: UIColor(hex: "079915")) // названия растения в его карточке/ название в коллекции/ характеристики в карточке
    var textBrown = Color(uiColor: UIColor(hex: "99B008"))
    var textAzure = Color(uiColor: UIColor(hex: "7EBDEA")) // My Plant Collection
    var textBlue = Color(uiColor: UIColor(hex: "3154D3"))  // названия в коллекции/ характеристики в карточке растения
    var buttonColor = Color(uiColor: UIColor(hex: "2AC1E3")) //цвет кнопок
    var textColor = Color(uiColor: UIColor(hex: "000000"))
    
    var search = Color(uiColor: UIColor(hex: "FFF38C"))
    
    var description = Color(uiColor: UIColor(hex: "7C947E"))
}

struct ColorDark {
    var pink = Color(uiColor: UIColor(hex: "CD9778")) // фон в коллекции
    var backGround = Color(uiColor: UIColor(hex: "7B3F14")) // главный темный фон
    var tabBar = Color(uiColor: UIColor(hex: "E2F78C"))  //  темный таббар
    var textGreen = Color(uiColor: UIColor(hex: "1D320D")) // названия растения в его карточке/ название в коллекции/ характеристики в карточке
    var textBrown = Color(uiColor: UIColor(hex: "7B3F14")) // характеристики в карточке растения
    var textAzure = Color(uiColor: UIColor(hex: "9CF573")) // My Plant Collection
    var textYellow = Color(uiColor: UIColor(hex: "F5F951" )) // названия в коллекции/ характеристики в карточке растения
    var buttonColor = Color(uiColor: UIColor(hex: "12849D")) //цвет кнопок
    var textColor = Color(uiColor: UIColor(hex: "FFFFFF"))
    
    
    //TODO: подобрать цвета:
    var description = Color(uiColor: UIColor(hex: "7C947E"))
    var search = Color(uiColor: UIColor(hex: "EDE989"))
}
