//
//  UserView.swift
//  CouponRedemption
//
//  Created by xdeveloper on 16/10/2021.
//

import SwiftUI

struct UserView: View {
    @State private var username: String = "Placeholder Username"
    @State private var loggedIn = false
    @Binding var urlFromParent: String
    
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    RemoteImageView(urlString: "https://bulma.io/images/placeholders/128x128.png").frame(width: 80.0, height:80).padding(.trailing, 40.0)
                    Text(username)
                    //Text(urlFromParent)
                }.padding(.top, 20)
                if (!loggedIn){
                    List (userPageItem.data.filter{$0.item == "log in"}){ items in
                        HStack{
                            //Text(items.item)
                            NavigationLink(destination: LoginView(urlFromParent: $urlFromParent)){
                                Text(items.item)
                                //                                Button(action: {
                                //                                    self.loggedIn.toggle()
                                //                                }) {
                                //
                                //                                }
                            }
                            
                        }
                    }
                }else {
                    List (userPageItem.data.filter{$0.item != "log in"}){ items in
                        HStack{
                            Button(action: {
                                if (items.item == "log out"){
                                    self.loggedIn.toggle()
                                }
                            }) {
                                Text(items.item)
                            }
                        }
                    }
                }
            }.navigationBarTitle("User Profile", displayMode: .inline)
        }
    }
}

struct UserView_Previews: PreviewProvider {
    @ObservedObject static var sampleUrl = urlItem()
    static var previews: some View {
        UserView(urlFromParent: $sampleUrl.url)
    }
}

struct userPageItem: Identifiable {
    let id = UUID()
    var item: String
}

extension userPageItem {
    static let data = [userPageItem(item: "log out"), userPageItem(item: "log in"), userPageItem(item: "redeemed coupons")]
}
