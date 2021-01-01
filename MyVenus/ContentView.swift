//
//  ContentView.swift
//  MyVenus
//
//  Created by Monica Qiu on 2020-04-11.
//  Copyright © 2020 MyVenus. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @EnvironmentObject var userInfo: UserInfo
    
    var body: some View {
        
        Group {
            if userInfo.isUserAuthenticated == .undefined {
                Text("Loading Page")
            } else if userInfo.isUserAuthenticated == .signedOut {
                LoginView()
            } else {
                HomeView()
            }
        }
        .onAppear {
            self.userInfo.configureFirebaseStateDidChange()
        }
        
    }
}

struct HomeView: View {
    
    @EnvironmentObject var userInfo: UserInfo
    
    var body: some View {
        NavigationView {
            VStack {
                Image("title-img").padding(.top, 130)
                Text("Hello \(userInfo.user.name)!")
                    .font(.largeTitle)
                    .padding(.top, 50)
                
                Spacer()
                
                NavigationLink(destination: MenuView(name: userInfo.user.name)) {
                    Text("Tap here to start")
                        .foregroundColor(Color.gray)
                        .frame(alignment: .bottom)
                        .padding(70)
                }
                    .navigationBarTitle(Text("MyVenus"))
                    .navigationBarItems(trailing: Button(action: {
                        FBAuth.logout { (result) in
                            print("Logged Out")
                        }
                    }){
                        Text("Log Out")
                    })
                    .onAppear {
                        guard let uid = Auth.auth().currentUser?.uid else {
                            return
                        }
                        FBFirestore.retrieveFBUser(uid: uid) { (result) in
                            switch result {
                            case .failure(let error):
                                print(error.localizedDescription)
                                // display some kind of alert to the user
                            case .success(let user):
                                self.userInfo.user = user
                            }
                        }
                }
            }
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
