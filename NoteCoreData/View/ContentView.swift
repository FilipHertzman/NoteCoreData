//
//  ContentView.swift
//  NoteCoreData
//
//  Created by Filip Hertzman on 2023-03-09.
//

import CoreData
import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES

    @EnvironmentObject var CoreDataVm: CoreDateViewModel
    @State private var showNewTaskView: Bool = false
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    // MARK: - BODY

    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - MAIN VIEW

                VStack {
                    // MARK: - HEADER

                    HStack(spacing: 10) {
                        // TITLE
                        Text("Notes ")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)

                        Spacer()
                        // EDIT BUTTON
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(Capsule().stroke(Color.black, lineWidth: 2))
                        // APPERANCE BUTTON
                        Button {
                            // TOGGLE APPERANCE
                            isDarkMode.toggle()
                        } label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        }
                    } //: HSTACK
                    .padding()
                    .foregroundColor(.black)

                    Spacer(minLength: 80)

                    // MARK: - NEW TASK BUTTON

                    Button {
                        showNewTaskView = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(.black)
                    .clipShape(Capsule())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)

                    List {
                        ForEach(CoreDataVm.savedTasks) { entity in
                            Button {
                                CoreDataVm.toggleCompleted(entity: entity)
                            } label: {
                                VStack(alignment: .leading, spacing: 5) {
                                    HStack {
                                        Image(systemName: entity.completed ? "checkmark.circle" : "circle")
                                            .foregroundColor(isDarkMode ? .white : .black)

                                        Text(entity.task ?? "NO NAME")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(isDarkMode ? .white : .black)
                                    }

                                    Text(entity.time.map { itemFormatter.string(from: $0) } ?? "")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                            } //: VSTACK
                        } //: LIST ITEM
                        

                        .onDelete(perform: CoreDataVm.deleteTask)

                        if CoreDataVm.savedTasks.isEmpty {
                            Spacer()
                                .listRowBackground(Color.clear)
                        }
                    } //: LIST
                    

                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                } //: VSTACK

                // MARK: - NEW TASK ITEM

                if showNewTaskView {
                    BlankView()
                        .onTapGesture {
                            withAnimation {
                                showNewTaskView = false
                            }
                        }
                    NewTaskView(isShowing: $showNewTaskView)
                }
            } //: ZSTACK
            .navigationBarTitle("Daily Tasks", displayMode: .large)
            .navigationBarHidden(true)
            .background(backgroundGradientLight.ignoresSafeArea(.all))
        } //: NAVIGATIONSTACK
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CoreDateViewModel())
    }
}
