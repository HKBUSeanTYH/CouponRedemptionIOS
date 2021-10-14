//
//  CouponRedemptionApp.swift
//  Shared
//
//  Created by xdeveloper on 12/10/2021.
//

import SwiftUI
import CoreData

@main
struct CouponRedemptionApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage("shouldSeedData") var shouldSeedData: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ContentView().onAppear(perform: seedData)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

extension CouponRedemptionApp {
    private func seedData(){
        if !shouldSeedData {
            //undos core data seeding
//            let viewContext = persistenceController.container.viewContext
//            viewContext.automaticallyMergesChangesFromParent = true
//
//            let entities = persistenceController.container.managedObjectModel.entities
//            entities.flatMap({ $0.name }).forEach(clearDeepObjectEntity(_:))
            
            return
        }
        
        let malls: [[String : Any]] = [
            ["mall": "IFC Mall", "latitude": 22.2849, "longitude": 114.158917 ],
            ["mall": "Pacific Place", "latitude": 22.2774985, "longitude": 114.1663225 ],
            ["mall": "Times Square", "latitude": 22.2782079, "longitude": 114.1822994],
            ["mall": "Elements", "latitude": 22.3048708,"longitude": 114.1615219 ],
            ["mall":"Harbour City", "latitude": 22.2950689,"longitude": 114.1668661 ],
            ["mall": "Festival Walk", "latitude": 22.3372971, "longitude": 114.1745273],
            ["mall": "MegaBox", "latitude": 22.319857, "longitude": 114.208168],
            ["mall": "APM", "latitude": 22.3121738, "longitude": 114.22513219999996],
            ["mall": "Tsuen Wan Plaza ", "latitude": 22.370735, "longitude": 114.111309],
            ["mall": "New Town Plaza ", "latitude": 22.3814592, "longitude": 114.1889307]
        ]
        
        let viewContext = persistenceController.container.viewContext
        viewContext.automaticallyMergesChangesFromParent = true
        
        viewContext.performAndWait {
            let insertRequest = NSBatchInsertRequest(entity: Mall.entity(), objects: malls)
            
            let result = try? viewContext.execute(insertRequest) as? NSBatchInsertResult
            
            if let status = result?.result as? Int, status == 1 {
                print("Data Seeded")
                shouldSeedData = false
            }
        }
    }
    
//    private func clearDeepObjectEntity(_ entity: String){
//        let viewContext = persistenceController.container.viewContext
//        viewContext.performAndWait {
//            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
//            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//            
//            do {
//                try viewContext.execute(deleteRequest)
//                try viewContext.save()
//            } catch {
//                print ("There was an error")
//            }
//        }
//    }
}
