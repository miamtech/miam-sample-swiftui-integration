//
//  Button.swift
//  iosApp
//
//  Created by didi on 4/9/23.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI

struct BasicButton: ButtonStyle {
    var bgColor: Color
    var secondaryColor: Color
    var selectedOption: Bool?
    @Environment(\.colorScheme) var colorScheme

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                        .fill(configuration.isPressed ? secondaryColor : bgColor )
                        .shadow()

                        .overlay(
                            RoundedRectangle(cornerRadius: .cornerRadiusTasks).stroke(secondaryColor, lineWidth: selectedOption ?? false ? 1:0)
                    )
                }
        )
            .animation(.spring())
    }
}

// all used to darken & disable buttons
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }

    @ViewBuilder func shadow() -> some View {
        self.shadow(radius: 3, x: 3, y: 3)
    }

    @ViewBuilder func addOpacity(_ needOpacity: Bool) -> some View {
        if needOpacity {
            self.opacity(0.5)
        } else {
            self
        }
    }

    @ViewBuilder func darkenView(_ darken: Bool) -> some View {
        if darken {
            self.brightness(-0.3)
        } else {
            self
        }
    }

}
