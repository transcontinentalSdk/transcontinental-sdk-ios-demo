//
//  MyCustomStyle.swift
//  DigitalFlyerDemo
//

import SwiftUI
import TCDigitalFlyerUI

extension FlyerStyle {
    static var myCustomStyle: Self {
        Self(
            masthead: .init(
                logo: Image("tc-logo")
            ),
            searchBar: .init(
                search: .init(
                    searchTextField: SearchTextFieldStyle(),
                    filterToggleStyle: FilterToggleStyle(),
                    resetButtonStyle: ResetButtonStyle()
                ),
                filter: .init(
                    categoryToggleStyle: FilterToggleStyle(),
                    discountToggleStyle: FilterToggleStyle()
                )
            )
        )
    }
}

struct SearchTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .background(Color(red: 0.46, green: 0.46, blue: 0.5).opacity(0.12))
                .cornerRadius(10.0)

            HStack {
                Image(systemName: "magnifyingglass")
                configuration
            }.foregroundStyle(Color.gray)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
        }.frame(height: 36)
    }
}

struct FilterToggleStyle: ToggleStyle {
    private let cornerRadius = 16.0

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onTapGesture {
                withAnimation {
                    configuration.isOn.toggle()
                }
            }
            .foregroundColor(configuration.isOn ? .white : .black)
            .frame(width: 88, height: 36)
            .background(configuration.isOn ? .black : .white)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color(red: 0.31, green: 0.31, blue: 0.31), lineWidth: 1)
            )
    }
}

struct FilterButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.black)
            .frame(width: 88, height: 36)
            .overlay(
                RoundedRectangle(cornerRadius: 17.5)
                    .stroke(Color(red: 0.31, green: 0.31, blue: 0.31), lineWidth: 1)
            )
    }
}

struct ResetButtonStyle: ButtonStyle {
    @SwiftUI.Environment(\.isEnabled) var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? .gray : .red)
    }
}
