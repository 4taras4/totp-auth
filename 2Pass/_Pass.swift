
//  _Pass.swift
//  2Pass
//
//  Created by Taras Markevych on 13.10.2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents
import RealmSwift
import OneTimePassword
import Base32

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> CodeEntry {
        CodeEntry(date: Date(), otp: "OTP Code", name: "account.com", issuer: "", configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (CodeEntry) -> ()) {
        let entry = CodeEntry(date: Date(), otp: "OTP Code", name: "account.com", issuer: "", configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let users = readContents()
        var entries = [CodeEntry]()
        for u in users {
            entries.append(convertUser(user: u))
        }
        let currentDate = Date()
        let interval = 3
        for index in 0 ..< entries.count {
            entries[index].date = Calendar.current.date(byAdding: .second, value: interval + index, to: currentDate)!
        }
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func readContents() -> [User] {
        var contents: [User] = []
        let archiveURL = FileManager.sharedContainerURL().appendingPathComponent(Constants.settings.contentsJson)
        let decoder = JSONDecoder()
        if let codeData = try? Data(contentsOf: archiveURL) {
            do {
                contents = try decoder.decode([User].self, from: codeData)
            } catch {
                print("Error: Can't decode contents")
            }
        }
        return contents
    }
    
    func convertUser(user: User) -> CodeEntry {
        guard let secretData = MF_Base32Codec.data(fromBase32String: user.token),
            !secretData.isEmpty else {
                print("Invalid secret")
            return CodeEntry(date: Date(), otp: "No secret", name: "No secret", issuer: user.issuer ?? "", configuration: ConfigurationIntent())
        }

        guard let generator = Generator(
            factor: .timer(period: 30),
            secret: secretData,
            algorithm: .sha1,
            digits: 6) else {
                print("Invalid generator parameters")
            return CodeEntry(date: Date(), otp: "No secret", name: "No secret", issuer: user.issuer ?? "", configuration: ConfigurationIntent())
        }
        
        let token = Token(name: user.name ?? "", issuer: user.issuer ?? "", generator: generator)
        guard let currentCode = token.currentPassword else {
            print("Invalid generator parameters")
            return CodeEntry(date: Date(), otp: "No secret", name: "No secret", issuer: user.issuer ?? "", configuration: ConfigurationIntent())
        }
        return CodeEntry(date: Date(), otp: currentCode, name: user.name ?? "name", issuer: user.issuer ?? "", configuration: ConfigurationIntent())
    }
}

struct CodeEntry: TimelineEntry {
    var date: Date
    var otp: String
    let name: String
    let issuer: String?

    let configuration: ConfigurationIntent
}

struct _PassEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        if let issuer = entry.issuer {
            Text("Issuer: \(issuer)")
        }
        Text(entry.name)
        Text(entry.otp).bold()
    }
}

@main
struct _Pass: Widget {
    let kind: String = "_Pass"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            _PassEntryView(entry: entry)
        }
        .configurationDisplayName("2 Pass")
        .description("TOTP widget for quick access to your TOTP codes. Widget may have some delay it's iOS resctriction, but you always can open your app quickly from widget")
        .supportedFamilies([.systemSmall])
    }

}

struct _Pass_Previews: PreviewProvider {
    static var previews: some View {
        _PassEntryView(entry: CodeEntry(date: Date(), otp: "OTP Code", name: "username", issuer: nil, configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
