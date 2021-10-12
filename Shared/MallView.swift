//
//  MallView.swift
//  CouponRedemption
//
//  Created by xdeveloper on 12/10/2021.
//

import SwiftUI

struct MallView: View {
    var body: some View {
        List(Mall.data) { mall in
            HStack {
                Text(mall.mall)
            }
        }
        
    }
}

struct MallView_Previews: PreviewProvider {
    static var previews: some View {
        MallView()
    }
}

struct Mall: Identifiable {
    let id = UUID()
    let mall: String
    let latitude: Double
    let longitude: Double
}

extension Mall{
    static let data: [Mall] = [
        Mall(mall: "IFC Mall", latitude: 22.2849, longitude: 114.158917),
        Mall(mall: "Pacific Place", latitude: 22.2774985, longitude: 114.1663225),
        Mall(mall: "Times Square", latitude: 22.2782079, longitude: 114.1822994),
        Mall(mall: "Elements", latitude: 22.3048708,longitude: 114.1615219),
        Mall(mall:"Harbour City", latitude: 22.2950689,longitude: 114.1668661),
        Mall(mall: "Festival Walk", latitude: 22.3372971, longitude: 114.1745273),
        Mall(mall: "MegaBox", latitude: 22.319857, longitude: 114.208168    ),
        Mall(mall: "APM", latitude: 22.3121738, longitude: 114.22513219999996),
        Mall(mall: "Tsuen Wan Plaza ", latitude: 22.370735, longitude: 114.111309),
        Mall(mall: "New Town Plaza ", latitude: 22.3814592, longitude: 114.1889307)
    ]
}
