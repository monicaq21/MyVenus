//
//  MenuView.swift
//  MyVenus
//
//  Created by Monica Qiu on 2020-04-11.
//  Copyright © 2020 MyVenus. All rights reserved.
//

import Foundation
import SwiftUI

struct MenuView: View {
    
    var name: String
    
    var body: some View {
        
        
        VStack {
        
            VStack {
                                    
                Text("MyVenus")
                .font(.system(size: 50))
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                
                NavigationLink(destination: CommunitiesView(name: self.name)) {
                    HStack {
                        Image(systemName: "bubble.left.and.bubble.right").font(.system(size: 30))
                        Text("Communities")
                            .font(.largeTitle)
                            
                    }
                        .frame(width: UIScreen.screenWidth - 70, height: 200, alignment: .center)
                        .foregroundColor(.white)
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(40)
                        .shadow(color: Color.init(red: 180, green: 0, blue: 0, opacity: 1), radius: 5, x: 10, y: 10)
                    
                }.padding(.bottom, 30)
                    
                NavigationLink(destination: Dashboard()) {
                    HStack {
                        Image(systemName: "person.circle").font(.system(size: 40))
                        Text("MyDashboard")
                            .font(.largeTitle)
                            
                    }
                        .frame(width: UIScreen.screenWidth - 70, height: 200, alignment: .center)
                        .foregroundColor(.white)
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(40)
                        .shadow(color: Color.init(red: 180, green: 0, blue: 0, opacity: 1), radius: 5, x: 10, y: 10)
                }
                
            }.padding(.bottom, 80)
                .padding(.top, 70)
            
        }.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
            .background(Color.init(red: 10, green: 0, blue: 0, opacity: 0.35))
            
        
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(name: "Monica Qiu")
    }
}
