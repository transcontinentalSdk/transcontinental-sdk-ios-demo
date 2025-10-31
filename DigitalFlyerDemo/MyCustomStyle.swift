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
                    filterToggleStyle: FilterToggleStyle()
                ),
                filter: .init(
                    categoryToggleStyle: FilterToggleStyle(),
                    discountToggleStyle: FilterToggleStyle()
                )
            ),
            pageIndicator: .init(isDisabled: false)
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
            }
            .foregroundStyle(Color.black)
            .padding(.leading, 8)
        }.frame(height: 36)
    }
}

struct FilterToggleStyle: ToggleStyle {
    private let cornerRadius = 16.0

    func makeBody(configuration: Configuration) -> some View {
        let isActive =
            if #available(iOS 16.0, *) {
                configuration.isOn || configuration.isMixed
            } else {
                configuration.isOn
            }
        configuration.label
            .onTapGesture {
                withAnimation {
                    configuration.isOn.toggle()
                }
            }
            .frame(height: 36)
            .padding(.horizontal, 8)
            .foregroundColor(isActive ? .white : .black)
            .background(isActive ? .black : .white)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color(red: 0.31, green: 0.31, blue: 0.31), lineWidth: 1)
            )
    }
}
