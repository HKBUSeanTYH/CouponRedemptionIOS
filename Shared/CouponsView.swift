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
        NavigationView{
            //Normal one VStack look
            List (coupons){ couponItem in
                VStack {
                    NavigationLink(destination: DetailsView(coupon: couponItem)){
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
                            Text(couponItem.restaurant).bold().underline(true, color: Color.gray).font(.system(size:30))
                                .padding(.bottom, 5)
                            Text(couponItem.title).font(.system(size:20))
                            Text(String(couponItem.coins)).font(.system(size:15))
                        }
                    }
                }.padding()
            }.onAppear(perform: startLoad).navigationBarTitle("Coupons",displayMode: .inline)
            //.refreshable{startLoad()}
            
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
                
                self.coupons = [Coupon(id:0, title: "Placeholder Coupon", restaurant:"Placeholder Restaurant",region:"Nowhere", mall:"No Mall", image:"https://bulma.io/images/placeholders/128x128.png", quota:0,coins: 0, valid:"Not Valid", details: "No Details"),
                                Coupon(id: 1, title: "Another Placeholder", restaurant: "Another Restaurant", region: "Another Region", mall: "Another Mall", image: "https://bulma.io/images/placeholders/128x128.png", quota: 0, coins: 0, valid: "Not Valid", details: "No Details")]
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
//    var region: String
//    var mall: String
//    var image: String
//    var quota: Int
//    var coins: Int
//    var valid: String
//    var details: String
//}
//
//extension sampleCoupon {
//    static let data = [
//        sampleCoupon(title:"Receive a complementary drink",restaurant: "Greyhound Cafe", region:"no idea",mall:"no idea",image:  "https://bulma.io/images/placeholders/128x128.png",quota:50, coins: 500, valid:"until December", details:"-"),
//        sampleCoupon(title:"30% off Yooganes Chicken",restaurant: "Yoogane", region:"no idea",mall:"some idea",image:  "https://bulma.io/images/placeholders/128x128.png",quota:25, coins: 500, valid:"until November", details:"-")
//    ]
//}


//for sampleCoupons
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


//nested Vstack look
//            VStack{
//                List (coupons){ couponItem in
//                    VStack (alignment: .leading) {
//                        RemoteImageView(urlString: couponItem.image)
//                        Text(couponItem.restaurant).bold().underline(true, color: Color.gray).font(.system(size:30)).padding(3)
//                        Text(couponItem.title).font(.system(size:20))
//                        Text(String(couponItem.coins)).font(.system(size:15))
//
//                    }
//                }.onAppear(perform: startLoad)
//            }.navigationBarTitle("Coupons", displayMode: .inline)
