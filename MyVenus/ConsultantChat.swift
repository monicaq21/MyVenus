//
//  ConsultantChat.swift
//  MyVenus
//
//  Created by Monica Qiu on 2020-04-15.
//  Copyright © 2020 MyVenus. All rights reserved.
//

import SwiftUI
import Firebase

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}

struct ConsultantChat: View {
    
    var consultant: Consultant
    @State var messages = [Message]()
    @State var txt = ""
    @State var nomsg = false
    
    var body: some View {
        
        VStack {
            
            if messages.count == 0 {
                
                if self.nomsg {
                    Text("Start A New Conversation!").foregroundColor(Color.black.opacity(0.5)).padding(.top)
                    Spacer()
                } else {
                    Spacer()
                    Indicator()
                    Spacer()
                }

                
            } else {
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        ForEach(self.messages){i in
                            HStack {
                                if i.user == Auth.auth().currentUser?.uid {
                                    Spacer()
                                    Text(i.message).padding().background(Color.purple).clipShape(ChatBubble(ismymsg: true)).foregroundColor(.white).padding(.trailing, 10)
                                } else {
                                    Text(i.message).padding().background(Color.pink).clipShape(ChatBubble(ismymsg: false)).foregroundColor(.white).padding(.leading, 10)
                                    Spacer()
                                    
                                }
                            }
                        }
                    }
                }
            }
            
            HStack {
                TextField("Enter Message", text: self.$txt).textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    updateDB(message: self.txt, date: Date(), consultant: self.consultant)
                    self.txt = ""
                }, label: {
                    Text("Send")
                })
                
            } //end of VStack
                .padding()
                .onAppear {
                self.getMsgs()
            }
        }
        
    }
    
    func getMsgs() {
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
        db.collection("messages").document(uid!).collection(consultant.id).order(by: "date", descending: false).addSnapshotListener { (snap, err) in
            
            if err != nil {
                print((err?.localizedDescription)!)
                self.nomsg = true
                return
            }
            
            if snap!.isEmpty {
                self.nomsg = true
            }
            
            for i in snap!.documentChanges {
                
                if i.type == .added {
                
                    let id = i.document.documentID
                    let message = i.document.get("message") as! String
                    let user = i.document.get("user") as! String
                    
                    self.messages.append(Message(id: id, message: message, user: user))
                }
            }
            
        }
    }
    
}

struct Message: Identifiable {
    var id: String
    var message: String
    var user: String
}

struct ChatBubble: Shape {
    
    var ismymsg: Bool
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight, ismymsg ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 16, height: 16))
        return Path(path.cgPath)
    }
}

struct Indicator : UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<Indicator>) -> UIActivityIndicatorView {
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Indicator>) {
        
        
    }
}


struct ConsultantChat_Previews: PreviewProvider {
    static var previews: some View {
        ConsultantChat(consultant: Consultant(id: "", name: "Jeffrey", description: "Random guy", imageName: "Consultant_1"))
    }
}

func updateDB(message: String, date: Date, consultant: Consultant){
    
    let db = Firestore.firestore()
    let myuid = Auth.auth().currentUser?.uid
    
    db.collection("messages").document(myuid!).collection(consultant.id).document().setData(["message": message, "user": myuid!, "date": date]){(err) in
        
        if err != nil {
            print((err?.localizedDescription)!)
            return
        }
        
    }
    
}
