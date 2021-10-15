//
//  ContentView.swift
//  Shared
//
//  Created by xdeveloper on 12/10/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var Globalcoupons = Coupons()
    
    var body: some View {
        TabView {
            CouponsView(couponFromParent: $Globalcoupons.coupons).tabItem {
                Image(systemName: "house")
                Text("Coupons")
            }
            
            MallView(couponFromParent: $Globalcoupons.coupons).tabItem {
                Image(systemName: "doc.plaintext")
                Text("Malls")
            }
            
            CoinsView(couponFromParent: $Globalcoupons.coupons).tabItem {
                Image(systemName: "doc.plaintext")
                Text("Coins")
            }
            
            //            Image(systemName: "person")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

class Coupons : ObservableObject {
    @Published var coupons: [Coupon] = []
}
