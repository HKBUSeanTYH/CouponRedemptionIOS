//
//  RedeemedView.swift
//  CouponRedemption
//
//  Created by xdeveloper on 18/10/2021.
//

import SwiftUI

struct RedeemedView: View {
    @Binding var urlFromParent: String
    
    @State var redeemedCoupons: [Coupon]
    @State var serverMsg: String = ""
    
    var body: some View {
        VStack{
            //Text(serverMsg)
            List(redeemedCoupons) { couponItem in
                VStack (alignment: .leading){
                    NavigationLink(destination: DetailsView(coupon: couponItem, urlFromParent: $urlFromParent)){
                        VStack (alignment: .leading){
                            Text(couponItem.restaurant)
                            Text(couponItem.mall)
                        }
                    }
                    
                }
            }.navigationBarTitle("Redeemed Coupons",displayMode: .inline).onAppear(perform: {
                requestRedeemed()
            })
        }
    }
}

struct RedeemedView_Previews: PreviewProvider {
    @ObservedObject static var sampleUrl = urlItem()

    static var previews: some View {
        RedeemedView(urlFromParent: $sampleUrl.url, redeemedCoupons: [])
    }
}

struct userCoupons: Decodable {
    var coupons: [Coupon]
    var id: Int
    var username: String
    var wallet: Int
    var role: String
}

extension RedeemedView {
    
    func handleClientError(_: Error) {
        return
    }
    
    func handleServerError(_: URLResponse?) {
        return
    }
    
    func requestRedeemed() {
        
        let url = URL(string: urlFromParent+"/user/redeem")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                self.handleClientError(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                self.handleServerError(response)
//                let str = String(decoding: data!, as: UTF8.self)
//                serverMsg = str
                return
            }
            
//            let str = String(decoding: data!, as: UTF8.self)
//            serverMsg = str
            
            if let data = data, let usercoupons = try? JSONDecoder().decode(userCoupons.self, from: data) {
                DispatchQueue.main.async {
                    //update
                    self.redeemedCoupons = usercoupons.coupons
                }
                
            }
        }
        
        task.resume()
    }
}
