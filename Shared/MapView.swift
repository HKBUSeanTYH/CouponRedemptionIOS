//
//  MapView.swift
//  CouponRedemption
//
//  Created by xdeveloper on 15/10/2021.
//

import SwiftUI
import MapKit

struct MapView: View {
    var mallstr: String = "IFC Mall"
    @FetchRequest var malls: FetchedResults<Mall>
    
//    @State private var region = MKCoordinateRegion()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 22.33787, longitude: 114.18131),
        span:   MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )

    init(mallstr: String) {
        
        self.mallstr = mallstr
        
        self._malls = FetchRequest(
            entity: Mall.entity(),
            sortDescriptors: [],
            predicate: NSPredicate(format: "mall == %@", mallstr)
        )
        
//        self._region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.malls[0].latitude, longitude: self.malls[0].longitude), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
//        if !self.malls.isEmpty {
//            self.region.center = CLLocationCoordinate2D(latitude: self.malls[0].latitude, longitude: self.malls[0].longitude)
//
//        }
        //during init, fetch request is still processing and may not have data causing empty array!!
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: malls) { m in
            
            MapMarker(coordinate: CLLocationCoordinate2D(latitude: m.latitude, longitude: m.longitude))
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear{
            self.region.center = CLLocationCoordinate2D(latitude: self.malls[0].latitude, longitude: self.malls[0].longitude)
        }
        //on appear fetch request is complete and there is data
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(mallstr:"Pacific Place")
    }
}
