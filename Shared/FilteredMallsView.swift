//
//  FilteredCouponsView.swift
//  CouponRedemption
//
//  Created by xdeveloper on 14/10/2021.
//

import SwiftUI

struct FilteredMallsView: View {
    @Binding var couponFromParent: [Coupon]
    //@State private var filcoupons: [Coupon] = []
    var mallItem = ""
    
    var body: some View {
        //Text("Hello")
        List(couponFromParent.filter{$0.mall == mallItem}) { coupon in
            NavigationLink(destination: DetailsView(coupon: coupon)){
                HStack {
                    Text(coupon.restaurant)
                }
            }
        }.navigationBarTitle("Filtered Coupons", displayMode: .inline)
    }
}

struct FilteredCouponsView_Previews: PreviewProvider {
    @ObservedObject static var sampleData = Coupons()
    static var previews: some View {
        FilteredMallsView(couponFromParent: $sampleData.coupons)
    }
}

//extension FilteredMallsView{
//    func handleClientError(_: Error) {
//        return
//    }
//    
//    func handleServerError(_: URLResponse?) {
//        return
//    }
//    
//    func startLoad() {
//        
//        let url = URL(string: "https://api.npoint.io/a8cea79c033ace1c8b8b")!
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            
//            if let error = error {
//                self.handleClientError(error)
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode) else {
//                self.handleServerError(response)
//                return
//            }
//            
//            //comment this out when testing sails
//            if let data = data,
//               let string = String(data: data, encoding: .utf8) {
//                
//                self.filcoupons = [Coupon(id:0, title: "Placeholder Coupon", restaurant:"Placeholder Restaurant",region:"Nowhere", mall:"Pacific Place", image:"https://bulma.io/images/placeholders/128x128.png", quota:0,coins: 0, valid:"Not Valid", details: "No Details"),
//                                   Coupon(id: 1, title: "Another Placeholder", restaurant: "Another Restaurant", region: "Another Region", mall: "Elements", image: "https://bulma.io/images/placeholders/128x128.png", quota: 0, coins: 0, valid: "Not Valid", details: "No Details")]
//            }
//            //uncomment this when testing sails
//            //            if let data = data, let filcoupons = try? JSONDecoder().decode([Coupon].self, from: data) {
//            //
//            //                self.filcoupons = filcoupons
//            //            }
//        }
//        
//        task.resume()
//    }
//}
