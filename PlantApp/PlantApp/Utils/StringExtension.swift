//
//  StringExtension.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import Foundation

extension String {
    func maxSubstring(b: String) -> Bool {
        let a = self
        if a.count < 1 { return false }
        var arr = [[Int]](repeating: [Int](repeating: 0, count: a.count + 1), count: b.count + 1)

        for i in 1...b.count {
            for j in 1...a.count {
                let aIndex = a.index(a.startIndex, offsetBy: j - 1)
                let bIndex = b.index(b.startIndex, offsetBy: i - 1)

                if a[aIndex] == b[bIndex] {
                    arr[i][j] = arr[i - 1][j - 1] + 1
                } else {
                    arr[i][j] = max(arr[i - 1][j], arr[i][j - 1])
                }
            }
        }
        
        return (a.count - arr[b.count][a.count]) < 2
    }
}
