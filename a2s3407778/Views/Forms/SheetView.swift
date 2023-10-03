////
////  SheetView.swift
////  a1s3407778
////
////  Created by Ethan Herpich on 18/8/2023.
////
//
//
//import SwiftUI
//
//
//
//struct SheetView: View {
//
//
//    @Environment(\.managedObjectContext) private var viewContext //For accessing CoreData
//    @EnvironmentObject var settings: DateObservableObject
//
//    @FetchRequest var events: FetchedResults<EventCore> //New Request to initialize in init()
//
//
//
//
//    // Creating a new meal
//    @State var name: String?
//    @State var note: String?
//    @State var timePeriod: String?
//    //@State var date = Date()
//    @State var servings: Int?
//
//    // foodItems represents all current items within a meal
//    //@State var newFoodItems: [[String]] = [[]]
//
//    // allFoodItems represents all current items within database
//    // example foods are hardcoded for the milestone 1 demo
//    //@State var allFoodItems: [[String]] = [["Beef 80% lean","250g","Meat","Butcher"], ["Apple","5 or 6","Fruit","Woolworths"], ["Milk","200ml","Dairy","Coles"]] // populate
//
//    // used to control which modal is open
//    //@Binding var events : [Event]
////    @Binding var date : Date
////    @Binding var isMenuShown : Bool
////    @Binding var showActionSheet : Bool
////    @Binding var showCreateMealSheet : Bool
////    @Binding var showCreateShopSheet : Bool
////    @Binding var showCreateOtherSheet : Bool
////    @Binding var showSearchMealSheet : Bool
//    @Binding var buildActionSheet : Bool
//    @Binding var activateSheetPosition : CGPoint
//
//    init(filter: Date){
//
//        // Sort order by order
//        let orderSort = NSSortDescriptor(key: "order", ascending: true)
//
//        // Constructing filter predicate
//        let calendar = Calendar.current
//        let start = calendar.startOfDay(for: filter)
//        let end = calendar.date(byAdding: .day, value: 1, to: start)
//
//        let predicate = NSPredicate(format: "date >= %@ AND date < %@", start as NSDate, end! as NSDate)
//        // Need to get range because dates have times associated with them
//
//        //        // %K and %@ are format specifiers
//        //        // %K var arg substitution for a keypath (coredata attribute)
//        //        // %@ var arg substitution for an object
//
//        // Underscore means we are changing the wrapper itsself rather than the value stored
//        _events = FetchRequest<EventCore>(
//            sortDescriptors: [orderSort],
//            predicate: predicate)
//    }
//
//    //TODO: update shopping list as well as events
//
//    var body: some View {
//
//        // activating this button calls the custom action sheet (using custom layout) in weekPlannerView
//        PlusButton()
//            .onTapGesture(coordinateSpace: .global) { location in
//                buildActionSheet = true
//                activateSheetPosition = location
//                print("testing tap location measure")
//                print(activateSheetPosition)
//
//                // delay so animtion is applied
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                    print("delay end")
//                    settings.isMenuShown = true
//                }
//            }
//            .sheet(isPresented: $settings.showCreateMealSheet) {
//                NavigationStack(){
//                    // calls CreateMealSheet that is encapsulated in another file
//                    NewMealSheet(name: $name, timePeriod: $timePeriod, note: $note /*servings: $servings*/ )
//                        .navigationTitle("Create meal")
//                        .navigationBarTitleDisplayMode(.inline)
//                        .navigationBarItems(leading: Button("Back", action: { settings.showCreateMealSheet.toggle() } ))
//                        .navigationBarItems(trailing: Button("Done", action: {
//                            // when done is press append event to dayInfo
//
//                            //var newEvent = EventCore
//                            /*
//                            dayInfo.append(Event(id: Int.random(in:50..<4000), title: name ?? "", desc: note ?? "", date: dayInfo[0].date, order: 100, type: TypeEnum.meal, timeLabel: timePeriod ?? "", foodItems: newFoodItems))
//                            // when done is press append event to dayInfo
//                            dayInfo.append(Event(id: Int.random(in:50..<4000), title: name ?? "", desc: note ?? "", date: dayInfo[0].date, order: 100, type: TypeEnum.meal, timeLabel: timePeriod ?? "", foodItems: newFoodItems))
//                             */
//                            // when done is press append event to events
////                            addNewEvent(date: currDate, name: name ?? "", note: note ?? "", order: 100, timePeriod: timePeriod ?? "", type: "Meal")
//
//                            // clearing values
//                            name = nil
//                            timePeriod = nil
//                            note = nil
//                            servings = nil
//
//                            settings.showCreateMealSheet = false
//                        }))
//                }
//            }
//            // Ommited from milestone 1 presentation
//            .sheet(isPresented: $settings.showSearchMealSheet) {
//                Form {
//                    Button("Dismiss", action: { settings.showSearchMealSheet.toggle() })
//                }
//            }
//            // Creating a shopping trip event
//            .sheet(isPresented: $settings.showCreateShopSheet) {
//                NavigationStack(){
//                    Form {
//                        Section(){
//                            TextField("Time period", text: $timePeriod ?? "")
//                            TextField("Note", text: $note ?? "")
//                        }
//
//                    }
//                    .navigationTitle("Create shopping trip")
//                    .navigationBarTitleDisplayMode(.inline)
//                    .navigationBarItems(leading: Button("Back", action: { settings.showCreateShopSheet.toggle() } ))
//                    .navigationBarItems(trailing: Button("Done", action: {
////                        addNewEvent(date: currDate, name: name ?? "", note: note ?? "", order: 100, timePeriod: timePeriod ?? "", type: "Shopping Trip")
//                        settings.showCreateShopSheet.toggle()
//                    }))
//
//                }
//            }
//            // Ommited from milestone 1 presentation
//            .sheet(isPresented: $settings.showCreateOtherSheet) {
//                Form {
//                    Button("Dismiss", action: { settings.showCreateOtherSheet.toggle() })
//                }
//            }
//    }
//
//    func addNewEvent(date: Date, name: String, note: String, order: Int16, timePeriod: String, type: String) {
//        // Adding data to new EventCore Object
//        let newEvent = EventCore(context: viewContext) //New object with the CoreData ViewContext
//        newEvent.date = date //Add events to the selected date
//        newEvent.name = name
//        newEvent.note = note
//        newEvent.order = Int16(order)
//        newEvent.timePeriod = timePeriod
//        newEvent.type = type
//
//        // Saving data
//        do {
//            try viewContext.save() //Saving data to the persistent store
//        } catch {
//            let nserror = error as NSError
//            fatalError("Saving Error: \(nserror), \(nserror.userInfo)")
//        }
//    }
//
//}
