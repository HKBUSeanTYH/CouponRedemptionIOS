//
//  UserView.swift
//  CouponRedemption
//
//  Created by xdeveloper on 16/10/2021.
//

import SwiftUI

struct UserView: View {
    @State private var username: String = "Placeholder Username"
    
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    RemoteImageView(urlString: "https://bulma.io/images/placeholders/128x128.png")
                    Text(username)
                }
                List (userPageItem.data){ items in
                    HStack{
                        Text(items.item)
                    }
                }.navigationBarTitle("User", displayMode: .inline)
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}

struct userPageItem: Identifiable {
    let id = UUID()
    var item: String
}

extension userPageItem {
    static let data = [userPageItem(item: "log out"), userPageItem(item: "log in"), userPageItem(item: "redeemed coupons")]
}
