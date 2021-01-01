////
////  Calendar2.swift
////  MyVenus
////
////  Created by Monica Qiu on 2020-04-28.
////  Copyright © 2020 MyVenus. All rights reserved.
////
//
//import SwiftUI
//import Firebase
//
//struct Calendar2: View {
//
//    @ObservedObject var periodState = getPeriodState2()
//    @State var show = false
//
//    var body: some View {
//
//        ZStack {
//
//            VStack {
//
//                VStack {
//
//                    ZStack {
//
//                        Circle()
//                            .frame(width: UIScreen.screenWidth / 2, height: UIScreen.screenWidth / 2)
//                            .foregroundColor(.white)
//                            .shadow(color: .pink, radius: 10)
//
//                        Text(self.periodState.state! ? "Day \(Int(round(Date().timeIntervalSince(self.periodState.startDate!) / 86400 + 0.5))) of Period" : "Not During Period").font(.headline).foregroundColor(.pink)
//
//                    }.padding(.top, 100)
//
//
//                    Button(action: {
//                        self.periodState.state?.toggle()
//                    }, label: {
//                        Text("Change State").foregroundColor(.white)
//                    }).padding(.top, 50).padding(.bottom, 100)
//
//                }.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.45).background(Color.init(red: 30, green: 0, blue: 0, opacity: 0.3))
//
//
//                Spacer()
//
//                // statistics
//                Text("STATISTICS").padding(.top, 40).padding(.bottom, 20)
//
//                VStack {
//
////                    VStack {
////
////                        Text("Average Days: 0").foregroundColor(.white) // to change
////
////                    }.padding().background(Color.init(red: 30, green: 0, blue: 0, opacity: 0.6))
////
////                    VStack {
////
////                        Text("# Days since last time: 1").foregroundColor(.white) // to change
////
////                    }.padding().background(Color.init(red: 30, green: 0, blue: 0, opacity: 0.6))
//
//                    Text("Average Days: 0").frame(width: UIScreen.screenWidth - 100).foregroundColor(.white).foregroundColor(.white).padding(20).background(Color.init(red: 30, green: 0, blue: 0, opacity: 0.6)).padding(.bottom, 30)
//
//                    Text("# Days since last time: 1").frame(width: UIScreen.screenWidth - 100).foregroundColor(.white).padding(20).background(Color.init(red: 30, green: 0, blue: 0, opacity: 0.6))
//
//                }.padding(.bottom, 100)
//
//
//            }
//
//        }
//
//    }
//}
//
//class getPeriodState2: ObservableObject {
//
//    @Published var state: Bool?
//    @Published var startDate: Date?
//
//    init () {
//
//        let db = Firestore.firestore()
//
//        db.collection("periodInfo").document(Auth.auth().currentUser!.uid).addSnapshotListener { (snap, err) in
//
//            if err != nil {
//                print((err?.localizedDescription)!)
//                return
//            }
//
//            if !snap!.exists {
//
//                print("snap doesn't exist!")
//
//                db.collection("periodInfo").document(Auth.auth().currentUser!.uid).setData(["periodState": false, "startDate": Date()]) { (err) in
//
//                    if err != nil{
//
//                        print((err?.localizedDescription)!)
//                        return
//
//                    }
//                }
//            }
//
//            let timestamp = snap?.get("startDate") as? Timestamp
//            self.startDate = timestamp?.dateValue()
//            self.state = snap?.get("periodState") as? Bool
//
//            print("The current state is: ", self.state)
//            print("The current date is: ", self.startDate)
//
////                (snap?.value(forKey: "startDate") as? Date)!
////            self.state = (snap?.value(forKey: "periodState") as? Bool)!
//
//
//
//
//        }
//
//    }
//
//}
//
//
////struct Calendar_Previews: PreviewProvider {
////    static var previews: some View {
////        Calendar()
////    }
////}
