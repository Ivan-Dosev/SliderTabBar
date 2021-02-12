//
//  OP.swift
//  SliderTabBar
//
//  Created by Ivan Dimitrov on 11.02.21.
//

import Foundation
import SwiftUI

struct ContentView1: View {
    @State private var isFlipped = false

    var body: some View {
        VStack {
            if isFlipped {
                Circle()
                    .fill(Color.red)
                    .frame(width: 44, height: 44)
                Text("Taylor Swift – 1989")
                    .font(.headline)
            } else {
                Text("Taylor Swift – 1989")
                    .font(.headline)
                Circle()
                    .fill(Color.blue)
                    .frame(width: 44, height: 44)
            }
        }
        .onTapGesture {
            withAnimation {
                isFlipped.toggle()
            }
        }
    }
}

//struct ContentView1: View {
//    @Namespace private var animation
//    @State private var isFlipped = false
//
//    var body: some View {
//        VStack {
//            if isFlipped {
//                Circle()
//                    .fill(Color.red)
//                    .frame(width: 44, height: 44)
//                    .matchedGeometryEffect(id: "Shape", in: animation)
//                Text("Taylor Swift – 1989")
//                    .matchedGeometryEffect(id: "AlbumTitle", in: animation)
//                    .font(.headline)
//            } else {
//                Text("Taylor Swift – 1989")
//                    .matchedGeometryEffect(id: "AlbumTitle", in: animation)
//                    .font(.headline)
//                Circle()
//                    .fill(Color.blue)
//                    .frame(width: 44, height: 44)
//                    .matchedGeometryEffect(id: "Shape", in: animation)
//            }
//        }
//        .onTapGesture {
//            withAnimation {
//                isFlipped.toggle()
//            }
//        }
//    }
//}
