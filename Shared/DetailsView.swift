//
//  DetailsView.swift
//  CouponRedemption
//
//  Created by xdeveloper on 14/10/2021.
//

import SwiftUI

struct DetailsView: View {
    var coupon: Coupon
    @State var showsAlert = false
    @State private var serverMsg: String = ""
    @State private var showsRedeemFail = false
    @State private var showsRedeemSuccess = false
    @Binding var urlFromParent: String
    
    @State private var alertItem: AlertItem?
    //    @FetchRequest(entity: Mall.entity(), sortDescriptors: [])
    //    var malls: FetchedResults<Mall>
    
    var body: some View {
        VStack (alignment: .leading){
            Section{
                RemoteImageView(urlString: coupon.image)
            }
            .alert(isPresented: self.$showsRedeemFail){
                Alert(title: Text("Redeem Failed!"), message: Text(serverMsg))
            }
            Section{
                VStack (alignment: .leading) {
                    Text(coupon.restaurant).bold()
                        .underline(true, color:Color.gray)
                        .font(.system(size:30)).padding(.bottom, 3)
                    Text(coupon.title)
                    HStack {
                        Text("Mall: ")
                        Text(coupon.mall)
                        Text("Coins: ")
                        Text(String(coupon.coins))
                    }
                    HStack{
                        Text("Expiry Date: ")
                        Text(coupon.valid)
                    }
                    HStack{
                        Button(action: {
                            self.showsAlert.toggle()
                        }){
                            HStack {
                                //Image(systemName: "bookmark.fill")
                                Text("Redeem")
                            }.padding(.top, 10.0).padding(.bottom, 10.0)
                            .padding(.trailing, 40.0).padding(.leading, 40.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(lineWidth: 2.0)
                            )
                        }.alert(isPresented: self.$showsAlert) {
                            Alert(title: Text("Are you sure?"), message: Text("To redeem this coupon?"),  primaryButton: .default(Text("Okay"), action: {redeemRequest(id: coupon.id)}), secondaryButton: .cancel() )
                        }
                        Spacer()
                        NavigationLink(destination: MapView(mallstr: coupon.mall)){
                            HStack {
                                //Image(systemName: "bookmark.fill")
                                Text("Address")
                            }.padding(.top, 10.0).padding(.bottom, 10.0)
                            .padding(.trailing, 40.0).padding(.leading, 40.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(lineWidth: 2.0)
                            )
                        }
                    }.padding(.top, 10.0)
                }
            }.padding(10).overlay(Rectangle().stroke(lineWidth:2.0))
        }.padding(10)
    }
}

struct DetailsView_Previews: PreviewProvider {
    @ObservedObject static var sampleUrl = urlItem()
    
    static var previews: some View {
        DetailsView(coupon: Coupon(id:0,title:"Receive a complementary drink",restaurant: "Greyhound Cafe", region:"no idea",mall:"no idea",image:  "https://bulma.io/images/placeholders/128x128.png",quota:50, coins: 500, valid:"until December", details:"-"), urlFromParent: $sampleUrl.url)
    }
}

struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text?
    var dismissButton: Alert.Button?
}

extension DetailsView {
    
    func handleClientError(_: Error) {
        return
    }
    
    func handleServerError(_: URLResponse?) {
        return
    }
    
    
    func redeemRequest(id: Int) {
        
        let url = URL(string: urlFromParent+"/user/coupons/add/"+"\(id)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
                self.showsRedeemFail.toggle()
                return
            }
            
            self.showsRedeemSuccess.toggle()
        }
        
        task.resume()
    }
}


//List(sampleCoupon.data) { s_coupon in
//    VStack (alignment: .leading){
//        Section{
//            RemoteImageView(urlString: s_coupon.image)
//        }
//        Section{
//            VStack (alignment: .leading) {
//                Text(s_coupon.restaurant).bold()
//                    .underline(true, color:Color.gray)
//                    .font(.system(size:30)).padding(.bottom, 3)
//                Text(s_coupon.title)
//                HStack {
//                    Text("Mall: ")
//                    Text(s_coupon.mall)
//                    Text("Coins: ")
//                    Text(String(s_coupon.coins))
//                }
//                HStack{
//                    Text("Expiry Date: ")
//                    Text(s_coupon.valid)
//                }
//                HStack{
//                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
//                        HStack {
//                            //Image(systemName: "bookmark.fill")
//                            Text("Redeem")
//                        }.padding(.top, 10.0).padding(.bottom, 10.0)
//                        .padding(.trailing, 40.0).padding(.leading, 40.0)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 10.0)
//                                .stroke(lineWidth: 2.0)
//                        )
//                    }
//                    Spacer()
//                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
//                        HStack {
//                            //Image(systemName: "bookmark.fill")
//                            Text("Address")
//                        }.padding(.top, 10.0).padding(.bottom, 10.0)
//                        .padding(.trailing, 40.0).padding(.leading, 40.0)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 10.0)
//                                .stroke(lineWidth: 2.0)
//                        )
//                    }
//                }.padding(.top, 10.0)
//            }
//        }.padding(10).overlay(Rectangle().stroke(lineWidth:2.0))
//    }
//}
