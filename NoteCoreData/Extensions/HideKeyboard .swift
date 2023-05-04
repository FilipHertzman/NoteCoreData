//
//  HideKeyboard .swift
//  NoteCoreData
//
//  Created by Filip Hertzman on 2023-03-09.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
