//
//  Font.swift
//  iosApp
//
//  Created by didi on 4/9/23.
//  Copyright © 2023 Miam. All rights reserved.
//

import Foundation
import SwiftUI

// text boxes

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-700", size: 56))
            .multilineTextAlignment(.center)
            .padding(.horizontal)

    }
}
struct Heading: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-700", size: 40))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 10)

    }
}
struct Subheading: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-500", size: 24))
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
}
struct ParagraphOne: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-300", size: 24))
            .multilineTextAlignment(.center)
//            .padding(.horizontal)
    }
}
struct ParagraphTwo: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-300", size: 18))
//            .padding(.horizontal)
    }
}
struct ButtonText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-300", size: 16))
//            .padding(.horizontal)
    }
}
struct RoundButtonText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-300", size: 20))
            .multilineTextAlignment(.center)
//            .padding(.horizontal)
    }
}
struct ParagraphThree: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-100", size: 12))
    }
}

// extension so fonts can be used as modifiers
extension View {
    func heading() -> some View {
        self.modifier(Heading())
    }
    func subheading() -> some View {
        self.modifier(Subheading())
    }
    func paragraphOne() -> some View {
        self.modifier(ParagraphOne())
    }
    func paragraphTwo() -> some View {
        self.modifier(ParagraphTwo())
    }
    func buttonText() -> some View {
        self.modifier(ButtonText())
    }
    func roundButtonText() -> some View {
        self.modifier(RoundButtonText())
    }
    func paragraphThree() -> some View {
        self.modifier(ParagraphThree())
    }
}
