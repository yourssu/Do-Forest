//
//  BackButton.swift
//  DesignSystem
//
//  Created by 정종인 on 10/9/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) private var dismiss
    var color: Color = .black
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.backward")
                .renderingMode(.template)
                .foregroundColor(color)
                .shadow(radius: 2.0)
                .contentShape(Rectangle())
        }
    }
}

struct BackButtonModifier: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton(color: color)
                }
            }
    }
}

public extension View {
    func addBackButton(_ color: Color = .black) -> some View {
        modifier(BackButtonModifier(color: color))
    }
}
