//
//  Posts.swift
//  MyVenus
//
//  Created by Monica Qiu on 2020-04-12.
//  Copyright © 2020 MyVenus. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import Firebase

// the likes system is like a prototype... but not important so can change later.

struct PostsView: View {
    
    @State var show = false
    var name: String

    var body: some View {
        
        ZStack {
            
            Home(name: self.name)
            
            VStack {
                
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        self.show.toggle()
                    }, label: {
                        Image(systemName: "plus").resizable().frame(width: 20, height: 20).padding()
                    }).background(Color.pink).foregroundColor(.white).clipShape(Circle())
                }.padding()
                
            }.padding(.bottom, 65)
            
        }.sheet(isPresented: $show) {
            CreateTweet(show: self.$show, name: self.name)
        }
        
    }
}

struct Home: View {
    
    @ObservedObject var observedPosts = getPosts()
    @State private var searchTerm: String = ""
    var name: String
    
    var body: some View {
            
        ScrollView(.vertical, showsIndicators: false) {
            
            SearchBar(text: $searchTerm)
            
            VStack(alignment: .leading) {
                
                ForEach(observedPosts.posts.filter {
                    self.searchTerm.isEmpty ? true :  $0.msg.localizedCaseInsensitiveContains(self.searchTerm)
                }) { i in
                    
                    tweetCellTop(name: i.name, pic: i.pic, image: i.url, msg: i.msg, likes: i.likes)
                    
                    if i.pic != "" {
                        tweetCellMiddle(pic: i.pic).padding(.leading, 60)
                    }
                    
//                    tweetCellBottom().offset(x: UIScreen.screenWidth / 4)
                    
                }
                
            }
            
        }.padding(.bottom, 15)
        .navigationBarTitle("Social Feed", displayMode: .inline)
            
        
    }
        
    
}

//struct tweetCellBottom: View {
//
//    var body: some View {
//
//        HStack(spacing: 40) {
//
//            Button(action: {
//
//            }, label: {
//                Image(systemName: "text.bubble").resizable().frame(width: 20, height: 20)
//            }).foregroundColor(.gray)
//
//            Button(action: {
//
//            }, label: {
//                Image(systemName: "arrowshape.turn.up.left").resizable().frame(width: 20, height: 20)
//            }).foregroundColor(.gray)
//
//            VStack(alignment: .trailing) {
//
//                Button(action: {
//
//                }, label: {
//                    Image(systemName: "heart.fill").resizable().frame(width: 20, height: 20)
//                }).foregroundColor(.gray)
//
//            }
//
//            Button(action: {
//
//            }, label: {
//                Image(systemName: "square.and.arrow.up").resizable().frame(width: 20, height: 20)
//            }).foregroundColor(.gray)
//
//
//        }
//
//    }
//
//}

struct tweetCellTop: View {
    
    var name = ""
    var pic = ""
    var image = ""
    var msg = ""
    @State var likes = ""
    @State var liked: Bool = false
    
    var body: some View {
        
        HStack(alignment: .top) {
            
            VStack {
                
                Image(image).resizable().frame(width: 55, height: 55).clipShape(Circle())
                Spacer()
                
            }.padding(.trailing, 15)
            
            HStack {
            
                VStack(alignment: .leading) {
                    
                    Text(name).fontWeight(.heavy)
                    Text(msg).padding(.top, 8)
                    
                }
                
                Spacer()
                
                Button(action: {
                    
                    if self.liked {
                        self.likes = "\(Int(self.likes)! - 1)"
                    } else {
                        self.likes = "\(Int(self.likes)! + 1)"
                    }
                    
                    self.liked.toggle()
                    
                }, label: {
                    
                    Image(systemName: "heart.fill").resizable().frame(width: 20, height: 20)
                
                }).foregroundColor(liked ? Color.purple : Color.gray).padding()
                
                Text("\(self.likes)").foregroundColor(.gray).frame(width: 30)
            
            }
            
            Spacer()
            
        }.padding()
        
    }
    
}

struct tweetCellMiddle: View {
    
    var pic = ""
    
    var body: some View {
        
        Image(pic).resizable().frame(height: 300).cornerRadius(20).padding()
        
    }
    
}

struct CreateTweet: View {

    @EnvironmentObject var userInfo: UserInfo
    @Binding var show: Bool
    @State var txt = ""
    var name: String
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Button(action: {
                    self.show.toggle()
                }, label: {
                    Text("Cancel")
                })
                
                Spacer()
                
                Button(action: {
                    postTweet(msg: self.txt, name: self.name)
                    self.show.toggle()
                }, label: {
                    Text("Post").padding()
                }).background(Color.pink).foregroundColor(.white).clipShape(Capsule())
                
            }
            
            MultiLineTF(txt: $txt)
            
        }.padding()
        
    }
    
}


struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView(name: "Monica Qiu")
    }
}

struct post: Identifiable {
    var id: String
    var name: String
    var msg: String
    var retweet: String
    var likes: String
    var pic: String
    var url: String
}

func postTweet(msg: String, name: String) {
    
    let db = Firestore.firestore()
    
    db.collection("tweets").document().setData(["name": name, "msg": msg, "retweet": "0", "likes": "0", "pic": "", "url": "communities-img"]) { (err) in
        
        if err != nil {
            print((err?.localizedDescription)!)
            return
        }
        
        print("success")
        
        
    }
    
}

class getPosts: ObservableObject {
    
    @Published var posts = [post]()
    
    init () {
        let db = Firestore.firestore()
        
        db.collection("tweets").addSnapshotListener { (snap, err) in
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges {
                
                if i.type == .added {
                    
                    let id = i.document.documentID
                    let name = i.document.get("name") as! String
                    let msg = i.document.get("msg") as! String
                    print(msg)
                    let pic = i.document.get("pic") as! String
                    let url = i.document.get("url") as! String
                    let retweet = i.document.get("retweet") as! String
                    let likes = i.document.get("likes") as! String
                    
                    DispatchQueue.main.async {
                        self.posts.append(post(id: id, name: name, msg: msg, retweet: retweet, likes: likes, pic: pic, url: url))
                    }
                    
                }
                
            }
            
        }
        
    }
    
}
