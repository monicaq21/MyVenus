//
//  ConsultantProfile.swift
//  MyVenus
//
//  Created by Monica Qiu on 2020-04-12.
//  Copyright © 2020 MyVenus. All rights reserved.
//

import SwiftUI

struct ConsultantProfile: View {
    
    var consultant: Consultant
    
    var body: some View {
        
        ZStack {
            
            VStack {
                Rectangle().fill(Color.purple).frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.55)
                Spacer()
                Rectangle().fill(Color.purple).frame(width: UIScreen.screenWidth, height: 0)
            }.padding(.top, 30)
            
            VStack {
                
                Image(consultant.imageName).resizable().frame(width: 260, height: 260).clipShape(Circle()).shadow(radius: 20).overlay(Circle().stroke(Color.white, lineWidth: 4))
                    
                VStack{
                    Text(consultant.name).font(.title).padding(.top, 30).padding(.bottom, 30)
                    Text(consultant.description).font(.subheadline).padding(.bottom, 30).padding(.leading, 35).padding(.trailing, 35).fixedSize(horizontal: false, vertical: true)
                    }
                        .frame(width: UIScreen.screenWidth - 100)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 1))
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                        .padding()
                
                // ConsultantChat(consultant: consultant)
                
                NavigationLink(destination: ConsultantChat(consultant: consultant)) {
                    Text("Consult!")
                }
                .frame(width: UIScreen.screenWidth / 2.5, height: 60, alignment: .center)
                    .background(Color.purple)
                    .foregroundColor(Color.white)
                    .cornerRadius(40)
                    .shadow(color: .purple, radius: 5)
                    .padding(.top, 30)
                
            }
        
        }.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        
    }
}

struct ConsultantProfile_Previews: PreviewProvider {
    static var previews: some View {
        ConsultantProfile(consultant: Consultant(id: "1234567", name: "Consultant_3", description: "Consultant_3 is a famous scientist who often appears in science textbooks, etc.", imageName: "Consultant_1"))
    }
}
