//
//  ContentView.swift
//  Shared
//
//  Created by xdeveloper on 12/10/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CouponsView().tabItem {
                Image(systemName: "house")
                Text("Coupons")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
