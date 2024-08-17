//
//  ContentView.swift
//  DigitalFlyerDemo
//

import SwiftUI
import TCDigitalFlyer
import TCDigitalFlyerUI

struct ContentView: View {
    private let subscriptionKey = ""
    private let client = ""
    private let banner = ""
    private let storeId = ""

    private let digitalFlyer: DigitalFlyer

    @State private var attributes: Publication.Attributes?

    init() {
        self.digitalFlyer = try! DigitalFlyer(
            subscriptionKey: subscriptionKey,
            client: client
        )
    }

    var body: some View {
        Group {
            switch attributes {
            case .none:
                ProgressView()
            case .some(let attributes):
                FlyerViewUI(
                    digitalFlyer: digitalFlyer,
                    attributes: attributes
                ) { event in
                    print(event)
                }
                .flyerStyle(.myCustomStyle)
            }
        }
        .task {
            TCDigitalFlyer.logger = MyLogger()
            self.attributes = try? await digitalFlyer.listPublications(storeId: storeId).first
        }
    }
}

final class MyLogger: Logger {
    func verbose(_ message: String) {
        print("V: \(message)")
    }
    func debug(_ message: String) {
        print("D: \(message)")
    }
    func info(_ message: String) {
        print("I: \(message)")
    }
    func warning(_ message: String) {
        print("W: \(message)")
    }
    func error(_ message: String) {
        print("E: \(message)")
    }
}
