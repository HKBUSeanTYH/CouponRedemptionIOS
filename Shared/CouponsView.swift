//
//  CouponsView.swift
//  CouponRedemption
//
//  Created by xdeveloper on 12/10/2021.
//

import SwiftUI

struct CouponsView: View {
    @State private var coupons: [Coupon] = []
    var body: some View {
        //        VStack{
        //            Section(header: Text("Coupons")){
        //                List{
        //                    ForEach(sampleCoupon.data){ sampleCoupon in VStack (alignment: .leading) {
        //                        //leading alignment causes it to stick left
        //                        Text(sampleCoupon.restaurant).bold().underline(true, color: Color.gray).font(.system(size:30)).padding(3)
        //                        Text(sampleCoupon.title).font(.system(size:20))
        //                        Text(String(sampleCoupon.coins)).font(.system(size:15))
        //                    }
        //                    }
        //                }
        //                .padding(.top, 32.0)
        //            }
        //        }
        //        .padding(.top, 32.0)
        NavigationView{
            VStack{
                //                List{
                //                    ForEach(sampleCoupon.data){ sampleCoupon in VStack (alignment: .leading) {
                //                        //leading alignment causes it to stick left
                //                        Text(sampleCoupon.restaurant).bold().underline(true, color: Color.gray).font(.system(size:30)).padding(3)
                //                        Text(sampleCoupon.title).font(.system(size:20))
                //                        Text(String(sampleCoupon.coins)).font(.system(size:15))
                //                    }
                //                    }
                //                }.onAppear(perform: startLoad)
                List (coupons){ couponItem in
                    VStack (alignment: .leading) {
                        //leading alignment causes it to stick left
                        Text(couponItem.restaurant).bold().underline(true, color: Color.gray).font(.system(size:30)).padding(3)
                        Text(couponItem.title).font(.system(size:20))
                        Text(String(couponItem.coins)).font(.system(size:15))
                        
                    }
                }.onAppear(perform: startLoad)
            }.navigationBarTitle("Coupons", displayMode: .inline)
        }
    }
}

struct CouponsView_Previews: PreviewProvider {
    static var previews: some View {
        CouponsView()
    }
}

struct sampleCoupon: Identifiable {
    var id = UUID()
    var title: String
    var restaurant: String
    var img: String
    var coins: Int
}

extension sampleCoupon {
    static let data = [
        sampleCoupon(title:"Receive a complementary drink",restaurant: "Greyhound Cafe",img:  "https://bulma.io/images/placeholders/128x128.png", coins: 500),
        sampleCoupon(title: "50% Discount on Supreme Seafood Feast (for 2 pax)", restaurant: "Mongo Tree", img: "https://bulma.io/images/placeholders/128x128.png", coins: 600),
        sampleCoupon(title: "50% off Yoogane's Chicken Galbi", restaurant: "Yoogane", img: "https://bulma.io/images/placeholders/128x128.png", coins: 250)
    ]
}

struct Coupon: Identifiable {
    let id: Int
    let title: String
    let restaurant: String
    let region: String
    let mall: String
    let image: String
    let quota: Int
    let coins: Int
    let valid: String
    let details: String
}

extension CouponsView {
    
    func handleClientError(_: Error) {
        return
    }
    
    func handleServerError(_: URLResponse?) {
        return
    }
    
    func startLoad() {
        
        let url = URL(string: "https://api.npoint.io/a8cea79c033ace1c8b8b")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                self.handleClientError(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                self.handleServerError(response)
                return
            }
            
            if let data = data,
               let string = String(data: data, encoding: .utf8) {
                
                self.coupons = [Coupon(id:0, title: "Placeholder Coupon", restaurant:"Placeholder Restaurant",region:"Nowhere", mall:"No Mall", image:"", quota:0,coins: 0, valid:"Not Valid", details: "No Details")]
            }
        }
        
        task.resume()
    }
}
