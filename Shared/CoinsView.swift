//
//  CoinsView.swift
//  CouponRedemption
//
//  Created by xdeveloper on 15/10/2021.
//

import SwiftUI

struct CoinsView: View {
    @Binding var couponFromParent: [Coupon]
    
    var body: some View {
        NavigationView{
            List(sampleRange.data) { ranges in
                NavigationLink(destination: FilteredCoinsView(couponFromParent: $couponFromParent,coinsItem: ranges.range)){
                    HStack {
                        Text(ranges.range)
                    }
                }
            }.navigationBarTitle("Coins", displayMode: .inline)
        }
    }
}

struct CoinsView_Previews: PreviewProvider {
    @ObservedObject static var sampleData = Coupons()
    static var previews: some View {
        CoinsView(couponFromParent: $sampleData.coupons)
    }
}

struct sampleRange: Identifiable {
    let id = UUID()
    var range: String
}

extension sampleRange {
    static let data = [sampleRange(range: "Coins <= 300"),
                       sampleRange(range: "300 < Coins < 600"),
                       sampleRange(range: "Coins >= 600")]
}
