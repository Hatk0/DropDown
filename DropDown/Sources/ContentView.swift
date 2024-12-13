//
//  ContentView.swift
//  DropDown
//
//  Created by Dmitry Yastrebov on 13.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedLanguages: [String] = []

    var body: some View {
        MultiSelectedDropDownView(selectedLanguages: $selectedLanguages)
    }
}
