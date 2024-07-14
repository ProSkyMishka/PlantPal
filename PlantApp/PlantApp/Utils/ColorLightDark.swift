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
    static let themes = [ColorTheme.light: 0, ColorTheme.dark: 1]
    static var theme = UserDefaults.standard.integer(forKey: "theme")
    
    
   
    static var pink = theme == 0 ? ColorLight.pink: ColorDark.pink // фон в коллекциu
    static var backGround = theme == 0 ? ColorLight.backGround : ColorDark.backGround // главный светлый фон
    static var tabBar = theme == 0 ? ColorLight.tabBar: ColorDark.tabBar // светлый таббар
    static var textGreen = theme == 0 ? ColorLight.textGreen: ColorDark.textGreen // названия растения в его карточке/ название в коллекции/ характеристики в карточке
    static var textBrown = theme == 0 ? ColorLight.textBrown: ColorDark.textBrown
    static var textAzure = theme == 0 ? ColorLight.textAzure: ColorDark.textAzure // My Plant Collection
    static var textBlue = theme == 0 ? ColorLight.textBlue: ColorDark.textYellow  // названия в коллекции/ характеристики в карточке растения
    static var buttonColor = theme == 0 ? ColorLight.buttonColor: ColorDark.buttonColor //
    static var textColor = theme == 0 ? ColorLight.textColor: ColorDark.textColor
    static var search = theme == 0 ? ColorLight.search: ColorDark.search
    static var description = theme == 0 ? ColorLight.description: ColorDark.description
    static var icon = theme == 0 ? ColorLight.icon: ColorDark.icon
    

    static func changeTheme(colorTheme: Int) {
        theme = colorTheme
        
        switch (colorTheme) {
        case 1:
            pink = ColorDark.pink
            backGround = ColorDark.backGround
            tabBar = ColorDark.tabBar
            textGreen = ColorDark.textGreen
            textBrown = ColorDark.textBrown
            textAzure = ColorDark.textAzure
            textBlue = ColorDark.textYellow
            buttonColor = ColorDark.buttonColor
            textColor = ColorDark.textColor
            search = ColorDark.search
            description = ColorDark.description
            icon = ColorDark.icon
            
        default:
            pink = ColorLight.pink
            backGround = ColorLight.backGround
            tabBar = ColorLight.tabBar
            textGreen = ColorLight.textGreen
            textBrown = ColorLight.textBrown
            textAzure = ColorLight.textAzure
            textBlue = ColorLight.textBlue
            buttonColor = ColorLight.buttonColor
            textColor = ColorLight.textColor
            search = ColorLight.search
            description = ColorLight.description
            icon = ColorLight.icon
        }
    }
}

class ColorLight {
    static var pink = Color(uiColor: UIColor(hex: "C3F7B6"))// фон в коллекции     уже не розовый
    static var backGround = Color(uiColor: UIColor(hex: "FFFEDC")) // главный светлый фон
    static var tabBar = Color(uiColor: UIColor(hex: "E2F78C")) // светлый таббар
    static var textGreen = Color(uiColor: UIColor(hex: "079915")) // названия растения в его карточке/ название в коллекции/ характеристики в карточке
    static var textBrown = Color(uiColor: UIColor(hex: "99B008"))
    static var textAzure = Color(uiColor: UIColor(hex: "7EBDEA")) // My Plant Collection
    static var textBlue = Color(uiColor: UIColor(hex: "3154D3"))  // названия в коллекции/ характеристики в карточке растения
    static var buttonColor = Color(uiColor: UIColor(hex: "2AC1E3")) //цвет кнопок
    static var textColor = Color(uiColor: UIColor(hex: "616161"))
    static var search = Color(uiColor: UIColor(hex: "DFDDDD"))
    static var icon = Color(uiColor: UIColor(hex: "17980C"))
    static var description = Color(uiColor: UIColor(hex: "7C947E"))
}

class ColorDark {
    static var pink = Color(uiColor: UIColor(hex: "37A556")) // фон в коллекции
    static var backGround = Color(uiColor: UIColor(hex: "2F4538")) // главный темный фон
    static var tabBar = Color(uiColor: UIColor(hex: "98B546"))  //  темный таббар
    static var textGreen = Color(uiColor: UIColor(hex: "F5FA18")) // названия растения в его карточке/ название в коллекции/ характеристики в карточке
    static var textBrown = Color(uiColor: UIColor(hex: "97BA5F")) // характеристики в карточке растения
    static var textAzure = Color(uiColor: UIColor(hex: "9CF573")) // My Plant Collection
    static var textYellow = Color(uiColor: UIColor(hex: "A7A120" )) // названия в коллекции/ характеристики в карточке растения
    static var buttonColor = Color(uiColor: UIColor(hex: "12849D")) //цвет кнопок
    static var textColor = Color(uiColor: UIColor(hex: "FFFFFF"))
    static var icon = Color(uiColor: UIColor(hex: "0ACD87"))
    static var description = Color(uiColor: UIColor(hex: "E8EFE2"))
    static var search = Color(uiColor: UIColor(hex: "86B371"))
}
