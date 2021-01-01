//
//  Communities.swift
//  MyVenus
//
//  Created by Monica Qiu on 2020-04-11.
//  Copyright © 2020 MyVenus. All rights reserved.
//

import Foundation
import SwiftUI

struct CommunitiesView: View {
    
    var name: String
    
    var body: some View {
        
        VStack {
            ImageView()
                .frame(width: UIScreen.screenHeight / 2, height: 400, alignment: .top)
            Spacer()
            InfoView(name: self.name)
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight / 3)
                .zIndex(1)
                .padding(.top, 30)
            
        }
    }
}

struct ImageView: View {
    
    var body: some View {
        Image("communities-img-2")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipped()
    }
}

struct InfoView: View {
    
    @State private var tappedPosts:Bool = true
    var name: String
    
    var body: some View {
        
        VStack(alignment: .trailing) {
        
        
            VStack(alignment: .leading) {
                
                HStack {
                    Button(action: {
                        self.tappedPosts = true
                    }) {
                        Text("Posts")
                            .font(.title)
                            .padding()
                    }
                        .foregroundColor(tappedPosts ? Color.black : Color.gray)
                    
                    Spacer()
                    
                    Button(action: {
                        self.tappedPosts = false
                    }) {
                        Text("Consultants")
                            .font(.title)
                            .padding()
                    }
                        .foregroundColor(tappedPosts ? Color.gray : Color.black)
                }
                
                
                Text(tappedPosts ? "This is a safe place for everyone to share their stories." : "Here, you can ask professionals any of your questions!").padding()

            }.padding()
            
            NavigationLink(destination: tappedPosts ? AnyView(PostsView(name: self.name)) : AnyView(ConsultationsView())) {
                Image(systemName: "arrow.right")
                    .font(.system(size: 30))
                    .foregroundColor(.gray)
                }.padding()
        }
    }
}



struct CommunitiesView_Previews: PreviewProvider {
    static var previews: some View {
        CommunitiesView(name: "Monica Qiu")
    }
}
