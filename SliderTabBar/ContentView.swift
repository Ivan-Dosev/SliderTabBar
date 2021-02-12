//
//  ContentView.swift
//  SliderTabBar
//
//  Created by Ivan Dimitrov on 10.02.21.
//

import SwiftUI

struct ContentView: View {
    @State var tab = "USA"
    @Namespace var animation
    
    @State var subTab = "Today"
    var subTabs = ["Today","Yesterday","Last Week"]
    
    var body: some View {
        ZStack {
            Color(hex: "#526EFF")
                .ignoresSafeArea()
        VStack {
            HStack(spacing: 0) {
                TabButton(selected: $tab, title: "USA" , animation: animation)
                TabButton(selected: $tab, title: "Global", animation: animation)
            }
            .background(Color.white.opacity(0.08))
            .clipShape(Capsule())
            .padding(.horizontal)
            
            HStack(spacing: 20) {
                ForEach(subTabs, id: \.self) { tab in
                    Button(action: {subTab = tab}) {
                        Text(tab)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white.opacity(subTab == tab ? 1 : 0.4))
                    }
                    .padding()
                }
            }
        }
      }
    }
}

struct TabButton: View {

    @Binding var selected: String
    var title: String
    var animation : Namespace.ID
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                selected = title
            }
        }) {
            ZStack {
                // Capsule and sliding effect
                
                Capsule()
                    .fill(Color.clear)
                    .frame(height: 45)
                
                if selected == title {
                    Capsule()
                        .fill(Color.white)
                        .frame(height: 45)
                        .matchedGeometryEffect(id: "Tab", in: animation)
                }
                Text(title)
                    .foregroundColor(selected == title ?.black : .white)
                    .fontWeight(.bold)
            }
        }
    }
}

extension Color {
    init(hex string: String) {
        var string: String = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if string.hasPrefix("#") {
            _ = string.removeFirst()
        }

        // Double the last value if incomplete hex
        if !string.count.isMultiple(of: 2), let last = string.last {
            string.append(last)
        }

        // Fix invalid values
        if string.count > 8 {
            string = String(string.prefix(8))
        }

        // Scanner creation
        let scanner = Scanner(string: string)

        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        if string.count == 2 {
            let mask = 0xFF

            let g = Int(color) & mask

            let gray = Double(g) / 255.0

            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)

        } else if string.count == 4 {
            let mask = 0x00FF

            let g = Int(color >> 8) & mask
            let a = Int(color) & mask

            let gray = Double(g) / 255.0
            let alpha = Double(a) / 255.0

            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)

        } else if string.count == 6 {
            let mask = 0x0000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask

            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0

            self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)

        } else if string.count == 8 {
            let mask = 0x000000FF
            let r = Int(color >> 24) & mask
            let g = Int(color >> 16) & mask
            let b = Int(color >> 8) & mask
            let a = Int(color) & mask

            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0
            let alpha = Double(a) / 255.0

            self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)

        } else {
            self.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 1)
        }
    }
}
