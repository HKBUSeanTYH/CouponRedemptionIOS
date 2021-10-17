//
//  ContentView.swift
//  Shared
//
//  Created by xdeveloper on 12/10/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var Globalcoupons = Coupons()
    @ObservedObject var GlobalURL = urlItem()
    @ObservedObject var isloggedIn  = loginStatus()
    @ObservedObject var user = currentUser()
    
    var body: some View {
        TabView {
            CouponsView(couponFromParent: $Globalcoupons.coupons, urlFromParent: $GlobalURL.url).tabItem {
                Image(systemName: "house")
                Text("Coupons")
            }
            
            MallView(couponFromParent: $Globalcoupons.coupons, urlFromParent: $GlobalURL.url).tabItem {
                Image(systemName: "doc.plaintext")
                Text("Malls")
            }
            
            CoinsView(couponFromParent: $Globalcoupons.coupons, urlFromParent: $GlobalURL.url).tabItem {
                Image(systemName: "doc.plaintext")
                Text("Coins")
            }
            
            UserView(urlFromParent: $GlobalURL.url, statusFromParent: $isloggedIn.loggedIn,loggedInUser: $user.user  ).tabItem{
                Image(systemName: "person")
                Text("User")
            }
            
            //
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

class urlItem : ObservableObject {
    @Published var url : String = "https://d1a4-158-182-200-102.ngrok.io"
}

class loginStatus : ObservableObject {
    @Published var loggedIn : Bool = false
}

class currentUser: ObservableObject {
    @Published var user: User = User(id:0, username: "", wallet:0, role: "")
}
