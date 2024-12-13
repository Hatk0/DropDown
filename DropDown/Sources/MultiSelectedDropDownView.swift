//
//  MultiSelectedDropDownView.swift
//  DropDown
//
//  Created by Dmitry Yastrebov on 13.12.2024.
//

import SwiftUI

struct MultiSelectedDropDownView: View {
    @State private var isExpanded = false
    @Binding var selectedLanguages: [String]

    let languages = ["Swift", "Java", "Python", "Kotlin", "Ruby"]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            headerView
            if isExpanded {
                dropdownContent
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.3), value: isExpanded)
            }
        }
        .padding(.horizontal)
    }
}

private extension MultiSelectedDropDownView {
    var headerView: some View {
        HStack {
            Text("Select Languages")
                .font(.headline)
                .foregroundStyle(Color.primary)

            Spacer()

            Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                .foregroundStyle(.gray)
                .rotationEffect(.degrees(isExpanded ? 180 : 0))
                .animation(.easeInOut(duration: 0.3), value: isExpanded)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isExpanded.toggle()
                    }
                }
        }
    }

    var dropdownContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(languages, id: \.self) { language in
                languageOptionView(for: language)
                    .transition(.scale)
            }
        }
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemGray6))
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }

    func languageOptionView(for language: String) -> some View {
        HStack {
            Text(language)
                .foregroundStyle(Color.primary)

            Spacer()

            if selectedLanguages.contains(language) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.blue)
                    .transition(.opacity)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(selectedLanguages.contains(language) ? Color.blue.opacity(0.15) : Color.clear)
        )
        .padding(.horizontal)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                toggleSelection(for: language)
            }
        }
    }

    func toggleSelection(for language: String) {
        if selectedLanguages.contains(language) {
            selectedLanguages.removeAll { $0 == language }
        } else {
            selectedLanguages.append(language)
        }
    }
}
