//
//  UserView.swift
//  CouponRedemption
//
//  Created by xdeveloper on 16/10/2021.
//

import SwiftUI

struct UserView: View {
    //    @State private var username: String = "Placeholder Username"
    //@State private var loggedIn = false
    @Binding var urlFromParent: String
    @Binding var statusFromParent: Bool
    @Binding var loggedInUser: User
    
    @State var isLinkActive = false
    
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    RemoteImageView(urlString: "https://bulma.io/images/placeholders/128x128.png").frame(width: 80.0, height:80).padding(.trailing, 40.0)
                    if (loggedInUser.username.isEmpty){
                        Text("                                               ")
                    }else{
                        VStack{
                            Text(loggedInUser.username)
                            Text(loggedInUser.role)
                            Text("\(loggedInUser.wallet)")
                        }
                        
                        //Text(urlFromParent)
                    }
                }.padding(.top, 20)
                if (!statusFromParent){
                    List (userPageItem.data.filter{$0.item == "log in"}){ items in
                        HStack{
                            //Text(items.item)
                            NavigationLink(destination: LoginView(urlFromParent: $urlFromParent, statusFromParent: $statusFromParent, loggedInUser: $loggedInUser)){
                                Text(items.item)
                            }
                            
                        }
                    }
                }else {
                    List (userPageItem.data.filter{$0.item != "log in"}){ items in
                        HStack{
                            Button(action: {
                                if (items.item == "log out"){
                                    statusFromParent.toggle()
                                    startLogout()
                                    //logout is kind of buggy. sometimes the username is not updated after logout
                                }else if (items.item == "redeemed coupons"){
                                    self.isLinkActive.toggle()
                                }
                            }) {
                                Text(items.item)
                            }
                        }
                    }
                }
            }.navigationBarTitle("User Profile", displayMode: .inline).background(NavigationLink(destination: RedeemedView(urlFromParent: $urlFromParent, redeemedCoupons: []), isActive: $isLinkActive) {
                EmptyView()
            }
            .hidden())
        }
    }
}

struct UserView_Previews: PreviewProvider {
    @ObservedObject static var sampleUrl = urlItem()
    @ObservedObject static var sampleStatus = loginStatus()
    @ObservedObject static var sampleUser = currentUser()
    static var previews: some View {
        UserView(urlFromParent: $sampleUrl.url, statusFromParent: $sampleStatus.loggedIn, loggedInUser: $sampleUser.user)
    }
}

struct userPageItem: Identifiable {
    let id = UUID()
    var item: String
}

extension userPageItem {
    static let data = [userPageItem(item: "log out"), userPageItem(item: "log in"), userPageItem(item: "redeemed coupons")]
}

extension UserView {
    
    func handleClientError(_: Error) {
        return
    }
    
    func handleServerError(_: URLResponse?) {
        return
    }
    
    func startLogout() {
        
        let url = URL(string: urlFromParent+"/user/logout")!
        //"https://api.npoint.io/a8cea79c033ace1c8b8b"
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                self.handleClientError(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                self.handleServerError(response)
                return
            }
            
            //uncomment this when testing sails
            //            if let data = data, let user = try? JSONDecoder().decode(User.self, from: data) {
            //
            //                self.loggedInUser = user
            //            }
            DispatchQueue.main.async {
                self.loggedInUser = User(id:0, username: "", wallet:0, role: "")
            }
        }
        
        task.resume()
    }
}
