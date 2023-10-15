//
//  a2_s3407778_widget.swift
//  a2-s3407778-widget
//
//  Created by Ethan Herpich on 15/10/2023.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    // widget with no data
    func placeholder(in context: Context) -> SummaryEntry {
        SummaryEntry(date: Date(), configuration: ConfigurationIntent(), events: ["dummyEvent1", "dummyEvent2", "dummyEvent3", "dummyEvent4"], shoppingItems: ["dummyItem1", "dummyItem2 ", "dummyItem3", "dummyItem4"])
    }

    // widget with dummy data
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SummaryEntry) -> ()) {
        let entry = SummaryEntry(date: Date(), configuration: configuration, events: ["dummyEvent1", "dummyEvent2", "dummyEvent3", "dummyEvent4"], shoppingItems: ["dummyItem1", "dummyItem2 ", "dummyItem3", "dummyItem4"])
        completion(entry)
    }

    // timeline of events in advance, an entry is the data
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<SummaryEntry>) -> ()) {
        var entries: [SummaryEntry] = []
        
        /* Reading the encoded data from your shared App Group container storage */
        let encodedData  = UserDefaults(suiteName: "group.com.charlieblyton.a2s3407778")!.object(forKey: "summary") as? Data
        
        /* Decoding it using JSONDecoder*/
        if let summaryEncoded = encodedData {
            let summaryDecoded = try? JSONDecoder().decode(DaySummary.self, from: summaryEncoded)
            if let summary = summaryDecoded {
                
                // On successful retrieval
                print("success")
                let entry = SummaryEntry(date: Date(), configuration: configuration, events: summary.eventNames, shoppingItems: summary.shoppingItems)
                entries.append(entry)
            }
        }

        // Will refresh every time the user opens the app
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

// data structure for timeline
struct SummaryEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let events : [String]
    let shoppingItems : [String]
}

// Small data structure that can be turned into JSON.
struct DaySummary : Codable {
    var eventNames : [String]
    var shoppingItems : [String]
}



// Where view is created. SwiftUI
struct a2_s3407778_widgetEntryView : View {
    var entry: Provider.Entry
    
    // formats date string
    func weekdayFromDate (date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE d")
        return dateFormatter.string(from: date)
    }

    var body: some View {
        //Text(entry.date, style: .time)
        
        // MARK: View 1
        /*
        
        VStack {
            HStack {
                Text("Shopping List")
                    .font(.system(size: 13).weight(.semibold))
                    .frame(maxWidth:.infinity, alignment: .leading)
                Image(systemName: "cart.circle")
            }
            
            VStack(spacing: 0) {
                ForEach(entry.shoppingItems, id: \.self) { item in
                    HStack {
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                        Text(item)
                            .font(.system(size: 13))
                    }
                    .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
            
        }
        .frame(maxWidth:.infinity, alignment: .topLeading)
        .padding()
         */
        // MARK: View 2
        
        VStack {
            HStack {
                VStack {
                    Text("Today, ")
                        .font(.system(size: 12).weight(.semibold))
                        .frame(maxWidth:.infinity, alignment: .leading)
                        .foregroundColor(Color.red)
                    Text(weekdayFromDate(date: entry.date))
                        .font(.system(size: 13).weight(.semibold))
                        .frame(maxWidth:.infinity, alignment: .leading)
                }
                Image(systemName: "sun.max")
            }
            
            VStack(spacing: 0) {
                ForEach(entry.events, id: \.self) { item in
                    HStack {
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                        Text(item)
                            .font(.system(size: 13))
                    }
                    .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
            
        }
        .frame(maxWidth:.infinity, alignment: .topLeading)
        .padding()
    }
}


// Main
struct a2_s3407778_widget: Widget {
    let kind: String = "a2_s3407778_widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            a2_s3407778_widgetEntryView(entry: entry)
        }
        .configurationDisplayName("MealBump widget")
        .description("See your meals, events and shopping items with ease.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct a2_s3407778_widget_Previews: PreviewProvider {
    static var previews: some View {
        a2_s3407778_widgetEntryView(entry: SummaryEntry(date: Date(), configuration: ConfigurationIntent(), events: ["dummyEvent1", "dummyEvent2", "dummyEvent3", "dummyEvent4"], shoppingItems: ["dummyItem1", "dummyItem2 ", "dummyItem3", "dummyItem4"]))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
