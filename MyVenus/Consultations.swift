//
//  Consultations.swift
//  MyVenus
//
//  Created by Monica Qiu on 2020-04-12.
//  Copyright © 2020 MyVenus. All rights reserved.
//

import Foundation
import SwiftUI

struct ConsultationsView: View {
    
    @State private var searchTerm1: String = ""
    
    var consultants: [Consultant] = [
        Consultant(id: "puBV1ITi2SgAvdXK2RlYCIB2VWa2", name: "Linda Lee", description: "Experienced Maternity Consultant", imageName: "Consultant_1"),
        Consultant(id: "CfSKy3wqWGXxgBql0uaBJsomrbZ2", name: "Frank Smith", description: "Prenatal Doctor", imageName: "Consultant_2"),
        Consultant(id: "MBkcJ6jpvoPPRula0M3GELiUHXI2", name: "Amanda Jones", description: "Primary Care Physician", imageName: "Consultant_3"),
    ]
    
    var body: some View {
            
        ScrollView(.vertical, showsIndicators: false) {
        
            SearchBar(text: $searchTerm1)
            
            VStack(alignment: .leading) {
            
                ForEach(consultants.filter {
                        self.searchTerm1.isEmpty ? true :  $0.name.localizedCaseInsensitiveContains(self.searchTerm1)
                }) { person in
                    
                    consultantCell(consultant: person)
                    
                }.navigationBarTitle(Text("Consultants"))
                
            }
            
        }
        
//        Text("If you would like to sign up as a professional consultant, please email signups@MyVenus.com.").foregroundColor(.gray).font(.footnote).multilineTextAlignment(.center)
        
    }
}

struct consultantCell: View {
    
    var consultant: Consultant
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading) { // doesn't work
            
                NavigationLink(destination: ConsultantProfile(consultant: consultant)) {
                    
                    HStack {
                        
                        Image(consultant.imageName)
                            .resizable().frame(width: 50, height: 50).clipShape(Circle()).padding(.trailing, 20)
                        
                        VStack(alignment: .leading) {
                            Text(consultant.name)
                            Text(consultant.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        
                        
                    }
                    
                }.buttonStyle(PlainButtonStyle())
            }
        
            }.padding()
        
    }
    
}



struct ConsultationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConsultationsView()
    }
}

