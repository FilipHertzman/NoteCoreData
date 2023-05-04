//
//  Constant.swift
//  NoteCoreData
//
//  Created by Filip Hertzman on 2023-03-09.
//

import SwiftUI

 // MARK: - FORMATTER
let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "sv_SE")
    formatter.dateFormat = "dd/MM/yy HH:mm"
    return formatter
}()

 // MARK: - UI
var backgroundGradientLight: LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [Color.black, Color.white]), startPoint: .bottomLeading, endPoint: .topLeading)
}


