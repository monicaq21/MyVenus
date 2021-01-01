//
//  Dashboard.swift
//  MyVenus
//
//  Created by Monica Qiu on 2020-04-15.
//  Copyright © 2020 MyVenus. All rights reserved.
//

import Foundation
import SwiftUI
import WebKit

struct Dashboard: View {
    
    @EnvironmentObject var userInfo: UserInfo
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                Image("self-headshot").resizable().frame(width: 260, height: 260).clipShape(Circle()).shadow(radius: 20).overlay(Circle().stroke(Color.white, lineWidth: 4))
                Text(userInfo.user.name).font(.largeTitle).padding()
                
            }
            
            HStack {
                
                NavigationLink(destination: Quiz()) {
                    VStack {
                        Image(systemName: "pencil.and.outline").resizable().foregroundColor(.purple).frame(width: 40, height: 40)
                        Text("Quiz").foregroundColor(.gray)
                    }.padding(.leading, 30)
                }
                
                Spacer()
                
                NavigationLink(destination: Calendar2()) {
                    VStack {
                        Image(systemName: "calendar").resizable().foregroundColor(.pink).frame(width: 40, height: 40)
                        Text("Period Tracker").foregroundColor(.gray)
                    }
                }
                
                Spacer()
                    
                NavigationLink(destination: Diary()) {
                    VStack {
                        Image(systemName: "book").resizable().foregroundColor(.yellow).frame(width: 40, height: 40)
                        Text("My Diary").foregroundColor(.gray)
                    }.padding(.trailing, 30)
                }
                
            }.padding()
            
            VStack(alignment: .leading) {
                
                Text("Recommended Articles").foregroundColor(.gray).padding(.leading, 20)
                
                List {
                    
                    NavigationLink(destination: Webview(url: "https://www.healthychildren.org/English/ages-stages/teen/dating-sex/Pages/Teenage-Pregnancy.aspx")) {
                        VStack {
                            Text("Help Pregnant Teens Know Their Options: AAP Policy Explained")
                            Text("Options to handle having a baby").foregroundColor(.gray)
                        }
                    }.padding().padding(.trailing, 30).listRowBackground(Color.gray.opacity(0.05))
                    
                    NavigationLink(destination: Webview(url: "https://www.mayoclinic.org/healthy-lifestyle/tween-and-teen-health/in-depth/teen-pregnancy/art-20048124")) {
                        VStack {
                            Text("Teenage pregnancy: Helping your teen cope")
                            Text("Tips on proper prenatal care").foregroundColor(.gray)
                        }
                    }.padding().padding(.trailing, 30).listRowBackground(Color.gray.opacity(0.05))
                    
                    NavigationLink(destination: Webview(url: "https://www.teenvogue.com/story/teen-pregnancy-real-life-story")) {
                        VStack {
                            Text("Pregnant at Prom: My Life as a Teen Mom")
                            Text("A real story of teen pregnancy").foregroundColor(.gray)
                        }
                    }.padding().padding(.trailing, 30).listRowBackground(Color.gray.opacity(0.05))
                    
                    NavigationLink(destination: Webview(url: "https://www.pregnancy.com.au/story-teenage-pregnancy")) {
                        VStack {
                            Text("My Story about Teenage Pregnancy")
                            Text("Another real story of teen pregnancy").foregroundColor(.gray)
                        }
                    }.padding().padding(.trailing, 30).listRowBackground(Color.gray.opacity(0.05))
                    
                }
                
            }.padding(.top, 40).background(Color.gray.opacity(0.15))
            
            
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}

struct Webview: UIViewRepresentable {
    
    var url: String
    
    func makeUIView(context: Context) -> WKWebView {
        
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        
        let request = URLRequest(url: url)
        let wkWebview = WKWebView()
        wkWebview.load(request)
        return wkWebview
        
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<Webview>) {
        
        
        
    }
    
}
