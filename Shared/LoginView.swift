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
    @State private var serverMsg: String = ""
    @State private var showsLoginAlert = false
    @State private var showsLoginSuccess = false
    @State private var showsLoginFail = false
    @Binding var urlFromParent: String
    @Binding var statusFromParent: Bool
    @Binding var loggedInUser: User
    
    var body: some View {
        VStack{
            //Text(urlFromParent)
            //Text(String(statusFromParent))
            TextField("Username", text: $username).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading, 20).padding(.trailing, 20)
            SecureField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading, 20).padding(.trailing, 20).padding(.bottom, 60)
            Button(action: {
                if (username.isEmpty || password.isEmpty){
                    self.showsLoginAlert.toggle()
                }else{
                    startLogin(username: username, password: password)
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
        }.alert(isPresented: self.$showsLoginFail){
            Alert(title: Text("Login Failed!"), message: Text(serverMsg))
        }
        VStack{}
            .alert(isPresented: self.$showsLoginSuccess) {
                Alert(title: Text("Logged In Successfully"), message: Text("You may now leave this page."))
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    @ObservedObject static var sampleUrl = urlItem()
    @ObservedObject static var sampleStatus = loginStatus()
    @ObservedObject static var sampleUser = currentUser()
    
    static var previews: some View {
        LoginView(urlFromParent: $sampleUrl.url, statusFromParent: $sampleStatus.loggedIn, loggedInUser: $sampleUser.user)
    }
}

struct User: Decodable {
    let id: Int
    let username: String
    let wallet: Int
    let role: String
}

struct serverMsg: Decodable {
    let msg: String
}

extension LoginView {
    
    func handleClientError(_: Error) {
        return
    }
    
    func handleServerError(_: URLResponse?) {
        return
    }
    
    func startLogin(username: String, password: String) {
        
        let url = URL(string: urlFromParent+"/user/login")!
        //"https://api.npoint.io/a8cea79c033ace1c8b8b"
        
        let body: [String: String] = ["username": username, "password": password]
        
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                self.handleClientError(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                self.handleServerError(response)
                let str = String(decoding: data!, as: UTF8.self)
                serverMsg = str
                self.showsLoginFail.toggle()
                return
            }
            
            //uncomment this when testing sails
            if let data = data, let user = try? JSONDecoder().decode(User.self, from: data) {
                DispatchQueue.main.async {
                    self.statusFromParent.toggle()
                    self.showsLoginSuccess.toggle()
                    self.loggedInUser = user
                }
            }
        }
        
        task.resume()
    }
}
