//
//  LoginView.swift
//  CouponRedemption
//
//  Created by xdeveloper on 17/10/2021.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showsLoginAlert = false
    @Binding var urlFromParent: String
    
    var body: some View {
        VStack{
            //Text(urlFromParent)
            TextField("Username", text: $username).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading, 20).padding(.trailing, 20)
            SecureField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading, 20).padding(.trailing, 20).padding(.bottom, 60)
            Button(action: {
                if (username.isEmpty || password.isEmpty){
                    self.showsLoginAlert.toggle()
                }
            }){
                Text("Login")
            }.padding(.top, 10.0).padding(.bottom, 10.0)
            .padding(.trailing, 40.0).padding(.leading, 40.0)
            .overlay(
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(lineWidth: 2.0)
            ).alert(isPresented: self.$showsLoginAlert) {
                Alert(title: Text("Missing Fields!"), message: Text("Please input login information!"))
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    @ObservedObject static var sampleUrl = urlItem()
    
    static var previews: some View {
        LoginView(urlFromParent: $sampleUrl.url)
    }
}
