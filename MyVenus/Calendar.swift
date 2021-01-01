//
//  Calendar.swift
//  MyVenus
//
//  Created by Monica Qiu on 2020-04-28.
//  Copyright © 2020 MyVenus. All rights reserved.
//

import SwiftUI
import Firebase

struct Calendar: View {
    
    @ObservedObject var periodState = getPeriodState()
    @State var show = false
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                Button(action: {
                    self.periodState.objectWillChange.send()
                }, label: {
                    Text("refresh")
                })
                
                Button(action: {
                    
                    self.show.toggle()
                    
                }, label: {
                    
                    Text(self.periodState.state! ? "Yes, Day \(Date().timeIntervalSince(self.periodState.startDate!))" : "No")
                    Text("Change State").foregroundColor(.gray)
                    
                }).background(Color.gray)
//                    .frame(width: UIScreen.screenWidth / 2, height: UIScreen.screenWidth / 2)
                .padding(100)
                    .clipShape(Circle())
                //.resizable().frame(width: 260, height: 260).clipShape(Circle()).shadow(radius: 20).overlay(Circle().stroke(Color.white, lineWidth: 4))
                
                
                Text("Statistics").font(.title)
                
                HStack {
                    
                    VStack {
                        
                        Text("Average Days")
                        Text("0")
                        
                    }
                    
                    VStack {
                        
                        Text("# Days since last time")
                        Text("1")
                        
                    }
                    
                }
                
                
            }
            
        }
        .sheet(isPresented: self.$show) {
            
            ChangeStateView(show: self.$show)
            
        }
        
    }
}

struct ChangeStateView : View {
    
    @Binding var show : Bool
    
    var body : some View {
        
        VStack {
            
            Button(action: {
                
                self.startPeriod()
                self.show.toggle()
                
            }) {
                
                Text("Start Period").padding(.vertical).padding(.horizontal,25).foregroundColor(.white)
                
            }.background(Color.purple)
            .clipShape(Capsule())
            .padding()
            
            Button(action: {
                
                self.endPeriod()
                self.show.toggle()
                
            }) {
                
                Text("End Period").padding(.vertical).padding(.horizontal,25).foregroundColor(.white)
                
            }.background(Color.purple)
            .clipShape(Capsule())
            .padding()
            
        }
        
    }
    
    func startPeriod() {
        print("clicked start period")
        
        let db = Firestore.firestore()
        db.collection("users").document(Auth.auth().currentUser!.uid).updateData(["periodState": true, "startDate": Date()])
    }
    
    func endPeriod() {
        let db = Firestore.firestore()
        db.collection("users").document(Auth.auth().currentUser!.uid).updateData(["periodState": false])
        // also have to count the average
        
    }

}


class getPeriodState: ObservableObject {
    
    @Published var state: Bool?
    @Published var startDate: Date?
    
    init () {
        
        let db = Firestore.firestore()
          
        db.collection("periodInfo").document(Auth.auth().currentUser!.uid).addSnapshotListener { (snap, err) in
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            if !snap!.exists {
                
                print("snap doesn't exist!")
                
//                snap?.setValue(false, forKey: "periodState")
//                snap?.setValue(Date(), forKey: "startDate")
                
                db.collection("periodInfo").document(Auth.auth().currentUser!.uid).setData(["periodState": false, "startDate": Date()]) { (err) in

                    if err != nil{

                        print((err?.localizedDescription)!)
                        return
                        
                    }
                }
            }
            
            // error: those two values still don't seem to exist
            self.startDate = snap?.get("startDate") as? Date
            self.state = snap?.get("periodState") as? Bool
            print("The current state is: ", self.state)
//                (snap?.value(forKey: "startDate") as? Date)!
//            self.state = (snap?.value(forKey: "periodState") as? Bool)!
            
            
            
            
        }
        
    }
    
}


//struct Calendar_Previews: PreviewProvider {
//    static var previews: some View {
//        Calendar()
//    }
//}
