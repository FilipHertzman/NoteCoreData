//
//  NewTaskView.swift
//  NoteCoreData
//
//  Created by Filip Hertzman on 2023-03-09.
//

import SwiftUI

struct NewTaskView: View {
    // MARK: - PROPERTY

    @EnvironmentObject var CoreDataVm: CoreDateViewModel

    @State var textFieldText: String = ""
    @Binding var isShowing: Bool
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    private var isButtonDisabled: Bool {
        textFieldText.isEmpty
    }

    // MARK: - BODY

    var body: some View {
        VStack {
            Spacer()

            // MARK: - TASKS

            VStack(spacing: 16) {
                TextField("New Task", text: $textFieldText)
                    .foregroundColor(isDarkMode ? .white : .black)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)

                Button(action: {
                    guard !textFieldText.isEmpty else { return }
                    CoreDataVm.addTask(text: textFieldText)

                    textFieldText = ""
                    hideKeyboard()
                    isShowing = false
                }, label: {
                    Text("SAVE")

                        .disabled(isButtonDisabled)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(isButtonDisabled ? Color.gray : Color.black)
                        .cornerRadius(10)
                })
            } //: VSTACK
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
        } //: VSTACK
        .padding()
    }
}

// MARK: - PREVIEW

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView(isShowing: .constant(true))
            .environmentObject(CoreDateViewModel())
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
