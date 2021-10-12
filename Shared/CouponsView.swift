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
                List (coupons){ couponItem in
                    VStack (alignment: .leading) {
                        //leading alignment causes it to stick left
//                        if #available(iOS 15.0, *) {
//                            AsyncImage(url: URL(string: couponItem.image)){ image in
//                                image.resizable()
//                            } placeholder: {
//                                ProgressView()
//                            }
//                            .scaledToFit()
//                        }else {
//                            RemoteImageView(urlString: couponItem.image)
//                        }
                        
                        RemoteImageView(urlString: couponItem.image)
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

extension Coupon: Decodable {}

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
            
            //comment this out when testing sails
            if let data = data,
               let string = String(data: data, encoding: .utf8) {
                
                self.coupons = [Coupon(id:0, title: "Placeholder Coupon", restaurant:"Placeholder Restaurant",region:"Nowhere", mall:"No Mall", image:"https://bulma.io/images/placeholders/128x128.png", quota:0,coins: 0, valid:"Not Valid", details: "No Details")]
            }
            //uncomment this when testing sails
            //            if let data = data, let coupons = try? JSONDecoder().decode([Coupon].self, from: data) {
            //
            //                self.coupons = coupons
            //            }
        }
        
        task.resume()
    }
}

struct RemoteImageView: View {
    
    var urlString: String
    @State var image: UIImage = UIImage()
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .onAppear {
                loadImage(for: urlString)
            }
    }
    
    func loadImage(for urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            self.image = UIImage(data: data) ?? UIImage()
        }
        task.resume()
    }
}


//struct sampleCoupon: Identifiable {
//    var id = UUID()
//    var title: String
//    var restaurant: String
//    var img: String
//    var coins: Int
//}
//
//extension sampleCoupon {
//    static let data = [
//        sampleCoupon(title:"Receive a complementary drink",restaurant: "Greyhound Cafe",img:  "https://bulma.io/images/placeholders/128x128.png", coins: 500),
//        sampleCoupon(title: "50% Discount on Supreme Seafood Feast (for 2 pax)", restaurant: "Mongo Tree", img: "https://bulma.io/images/placeholders/128x128.png", coins: 600),
//        sampleCoupon(title: "50% off Yoogane's Chicken Galbi", restaurant: "Yoogane", img: "https://bulma.io/images/placeholders/128x128.png", coins: 250)
//    ]
//}
