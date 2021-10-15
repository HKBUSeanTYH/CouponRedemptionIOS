//
//  FilteredCoinsView.swift
//  CouponRedemption
//
//  Created by xdeveloper on 15/10/2021.
//

import SwiftUI

struct FilteredCoinsView: View {
    @Binding var couponFromParent: [Coupon]
    //@State private var filcoupons: [Coupon] = []
    var coinsItem = ""
    var filteredCoupons: [Coupon] = []
    
//    var my_closure: (Coupon) -> Bool = {
//
//        if (true) {
//            print($0.coins)
//            return true
//
//
//        }
//
//
//    }
    
    var body: some View {
        if (coinsItem == "Coins <= 300"){
            List(couponFromParent.filter{$0.coins <= 300}) { coupon in
                NavigationLink(destination: DetailsView(coupon: coupon)){
                    HStack {
                        Text(coupon.restaurant)
                    }
                }
            }.navigationBarTitle("Filtered Coupons", displayMode: .inline)
        }else if (coinsItem == "300 < Coins < 600"){
            List(couponFromParent.filter{$0.coins > 300 && $0.coins < 600}) { coupon in
                NavigationLink(destination: DetailsView(coupon: coupon)){
                    HStack {
                        Text(coupon.restaurant)
                    }
                }
            }.navigationBarTitle("Filtered Coupons", displayMode: .inline)
        }else if (coinsItem == "Coins >= 600"){
            List(couponFromParent.filter{$0.coins >= 600}) { coupon in
                NavigationLink(destination: DetailsView(coupon: coupon)){
                    HStack {
                        Text(coupon.restaurant)
                    }
                }
            }.navigationBarTitle("Filtered Coupons", displayMode: .inline)
        }
    }
}

struct FilteredCoinsView_Previews: PreviewProvider {
    @ObservedObject static var sampleData = Coupons()
    static var previews: some View {
        FilteredCoinsView(couponFromParent: $sampleData.coupons)
    }
}

//extension FilteredCoinsView{
//    mutating func performFiltering(){
//        if (coinsItem == "Coins <= 300"){
//            filteredCoupons = couponFromParent.filter{$0.coins <= 300}
//        }else if (coinsItem == "300 < Coins < 600"){
//            filteredCoupons = couponFromParent.filter{$0.coins > 300 && $0.coins < 600}
//        }else if (coinsItem == "Coins >= 600"){
//            filteredCoupons = couponFromParent.filter{$0.coins >= 600}
//        }
//    }
//}
