//
//  Login.swift
//  MyVenus
//
//  Created by Monica Qiu on 2020-04-12.
//  Copyright © 2020 MyVenus. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

struct LoginView: View {
    
    enum Action {
        case signUp, resetPW
    }
    
    @State private var showSheet = false
    @State private var action: Action?
    
    var body: some View {
        
        SignInWithEmailView(showSheet: $showSheet, action: $action).sheet(isPresented: $showSheet) {
            if self.action == .signUp {
                SignUpView()
            } else {
                ForgotPasswordView()
            }
        }
        
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


