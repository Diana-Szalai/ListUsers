//
//  InfoDisplayCell.swift
//  ListUsers
//
//  Created by Diana Szalai on 28.05.2023.
//

import SwiftUI

public struct InfoDisplayCell: View {
    
    private let title: TextType
    private let subtitle: TextType?
    private let info: TextType?
    private let verticalSpacing: CGFloat?
    private let onTap: (() -> Void)?
    
    public init(title: TextType,
                subtitle: TextType? = nil,
                info: TextType? = nil,
                verticalSpacing: CGFloat? = 8,
                onTap: (() -> Void)? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.info = info
        self.verticalSpacing = verticalSpacing
        self.onTap = onTap
    }
    
    public var body: some View {
        if let handler = onTap {
            Button(action: handler, label: { content })
        } else {
            content
        }
    }
    
    private var content: some View {
        
        VStack(alignment: .center, spacing: verticalSpacing) {
            Text(title.text)
                .fontWeight(title.fontWeight)
                .font(title.font)
                .padding(title.padding)
                .foregroundColor(title.foregroundColor)
                .background(title.backgroundColor)
                .lineLimit(title.lineLimit)
                .cornerRadius(title.cornerRadius)
            if let subtitle = subtitle, !subtitle.text.isEmpty {
                Text(subtitle.text)
                    .fontWeight(subtitle.fontWeight)
                    .font(subtitle.font)
                    .padding(subtitle.padding)
                    .foregroundColor(subtitle.foregroundColor)
                    .background(subtitle.backgroundColor)
                    .lineLimit(subtitle.lineLimit)
                    .cornerRadius(subtitle.cornerRadius)
            }
            if let info = info, !info.text.isEmpty {
                Text(info.text)
                    .fontWeight(info.fontWeight)
                    .font(info.font)
                    .padding(info.padding)
                    .foregroundColor(info.foregroundColor)
                    .background(info.backgroundColor)
                    .lineLimit(info.lineLimit)
                    .cornerRadius(info.cornerRadius)
            }
        }
        .padding(20)
        .background(.gray.opacity(0.1))
        .contentShape(Rectangle())
        .cornerRadius(15)
    }
}

public extension InfoDisplayCell {
    struct TextType {
        let text: String
        let padding: CGFloat
        let foregroundColor: Color?
        let backgroundColor: Color?
        let font: Font?
        let fontWeight: Font.Weight?
        let lineLimit: Int?
        let cornerRadius: CGFloat
    }
}

public extension InfoDisplayCell.TextType {
    static func title(_ text: String,
                      padding: CGFloat = 0.0,
                      foregroundColor: Color = .black,
                      backgroundColor: Color? = nil,
                      font: Font = .body,
                      fontWeight: Font.Weight = .regular,
                      lineLimit: Int? = 1,
                      cornerRadius: CGFloat = 0.0) -> Self {
        .init(text: text,
              padding: padding,
              foregroundColor: foregroundColor,
              backgroundColor: backgroundColor,
              font: font,
              fontWeight: fontWeight,
              lineLimit: lineLimit,
              cornerRadius: cornerRadius)
    }
    
    static func subtitle(_ text: String,
                         padding: CGFloat = 0.0,
                         foregroundColor: Color? = nil,
                         backgroundColor: Color? = nil,
                         font: Font = .subheadline,
                         fontWeight: Font.Weight = .regular,
                         lineLimit: Int? = 1,
                         cornerRadius: CGFloat = 0.0) -> Self {
        .init(text: text,
              padding: padding,
              foregroundColor: foregroundColor,
              backgroundColor: backgroundColor,
              font: font,
              fontWeight: fontWeight,
              lineLimit: lineLimit,
              cornerRadius: cornerRadius)
    }
    
    static func info(_ text: String,
                     padding: CGFloat = 0.0,
                     foregroundColor: Color = .gray,
                     backgroundColor: Color? = nil,
                     font: Font = .body,
                     fontWeight: Font.Weight = .regular,
                     lineLimit: Int? = 1,
                     cornerRadius: CGFloat = 0.0) -> Self {
        .init(text: text,
              padding: padding,
              foregroundColor: foregroundColor,
              backgroundColor: backgroundColor,
              font: font,
              fontWeight: fontWeight,
              lineLimit: lineLimit,
              cornerRadius: cornerRadius)
    }
}
