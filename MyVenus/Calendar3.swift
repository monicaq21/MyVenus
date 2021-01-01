//
//  Calendar3.swift
//  MyVenus
//
//  Created by Monica Qiu on 2020-04-28.
//  Copyright © 2020 MyVenus. All rights reserved.
//

import SwiftUI
import Firebase

struct Calendar2: View {
    
    @ObservedObject var periodState = getPeriodState2()
    @State var show = false
    
    var body: some View {
            
        VStack {
            
            VStack {

                ZStack {

                    Circle()
                        .frame(width: UIScreen.screenWidth / 2, height: UIScreen.screenWidth / 2)
                        .foregroundColor(.white)
                        .shadow(color: .pink, radius: 10)

                    // Day \(Int(round(Date().timeIntervalSince(self.periodState.startDate!) / 86400 + 0.5))) of Period
                    Text(self.periodState.state! ? "Day 1 of Period" : "Not During Period").font(.headline).foregroundColor(.pink)

                }.padding(.top, 100)

                Button(action: {
                    self.periodState.state?.toggle()
                    if !self.periodState.state! {
                        self.calculateAvg()
                    }
                }, label: {
                    Text("Change State").foregroundColor(.white)
                }).padding(.top, 50).padding(.bottom, 100)

            }.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.45).background(Color.init(red: 30, green: 0, blue: 0, opacity: 0.3))
            
            Spacer()

            // statistics
            VStack {
                
                Text("STATISTICS").padding(.top, 40).padding(.bottom, 20)

                Text("Average Days: \(self.periodState.state! ? "N/A" : "\(String(describing: self.periodState.avgDays))")")
                    .frame(width: UIScreen.screenWidth - 100).foregroundColor(.white).foregroundColor(.white).padding(20).background(Color.init(red: 30, green: 0, blue: 0, opacity: 0.6)).padding(.bottom, 30)

//                Text("# Days since last time: \(Int(round(Date().timeIntervalSince(self.periodState.endDate!) / 86400 + 0.5)))")
//                    .frame(width: UIScreen.screenWidth - 100).foregroundColor(.white).padding(20).background(Color.init(red: 30, green: 0, blue: 0, opacity: 0.6))

            }.padding(.bottom, 100)
            
        }
        
    }
    
    func calculateAvg() {
        
        let db = Firestore.firestore()
          
        db.collection("periodInfo").document(Auth.auth().currentUser!.uid).addSnapshotListener { (snap, err) in
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
                
            print("Calculating Average")
            
//            let average = snap?.get("avgDays") as? Int
            
            db.collection("periodInfo").document(Auth.auth().currentUser!.uid).setData(["avgDays": 1]) { (err) in

                if err != nil {

                    print((err?.localizedDescription)!)
                    return
                    
                }
            }
            
        }
        
    }
}

class getPeriodState2: ObservableObject {
    
    @Published var state: Bool?
    @Published var avgDays: Int?
    @Published var startDate: Date?
    @Published var endDate: Date?
    
    init () {
        
        let db = Firestore.firestore()
          
        db.collection("periodInfo").document(Auth.auth().currentUser!.uid).addSnapshotListener { (snap, err) in
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
//            if !snap!.exists {
//
//                print("snap doesn't exist!")
                
            db.collection("periodInfo").document(Auth.auth().currentUser!.uid).setData(["periodState": false, "startDate": Date(), "avgDays": 0, "endDate": Date()]) { (err) in

                if err != nil {

                    print((err?.localizedDescription)!)
                    return
                    
                }
            }
//            }
            
            let timestamp = snap?.get("startDate") as? Timestamp
            self.startDate = timestamp?.dateValue()
            let timestamp2 = snap?.get("endDate") as? Timestamp
            self.endDate = timestamp2?.dateValue()
            
            self.state = snap?.get("periodState") as? Bool
            self.avgDays = snap?.get("avgDays") as? Int
            
            
            
            
        }
        
    }
    
}


//struct Calendar_Previews: PreviewProvider {
//    static var previews: some View {
//        Calendar()
//    }
//}
