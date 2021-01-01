//
//  Quiz.swift
//  MyVenus
//
//  Created by Monica Qiu on 2020-04-16.
//  Copyright © 2020 MyVenus. All rights reserved.
//

import SwiftUI

struct Quiz: View {
    
    private var questions = [
        "1. Has it been over 2 months since you’ve had your late period?",
        "2. Do you feel tired often and experience emotional fluctuations (mood swings)?",
        "3. Does your belly feel bloated?",
        "4. Do you go to the restroom regularly (meaning not being constipated)?",
        "5. Do you visit the bathroom often at night?",
        "6. Do you feel nausea to the point where you visit the bathroom?",
        "7. Did your taste in food change?",
        "8. Do you have light, spot-like bleedings (different from the normal period)?",
        "9. Did you gain weight (noticeable) even though your lifestyle hasn’t changed much?",
        "10. Do you feel changes in your breast (ex. Tingling, aching, growing, etc..)?",
        "11. Did you develop severe acne without any noticeable lifestyle changes?"
    ]
    
    @State private var count = 0
    @State private var curIndex = 0
    
    var body: some View {
        
        Group {
            
            if curIndex < questions.count {
            
                VStack {
                    
                    Text(questions[curIndex]).padding(.top, 50).font(.largeTitle)
                    
                    Spacer()
                    
                    Button(action: {
                        self.curIndex += 1
                        self.count += 1
                    }, label: {
                        Text("Yes")
                    }).padding(.bottom, 20).foregroundColor(.gray).font(.title)
                    
                    Button(action: {
                        self.curIndex += 1
                    }, label: {
                        Text("No")
                    }).padding(.bottom, 200).foregroundColor(.gray).font(.title)
                    
                }
                
            } else {
                Quiz2(count: count)
            }
        }.padding()
    }

}


struct Quiz2: View {
    
    var count: Int

    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack{
                
                Text("Out of the 11 symptoms of pregnancy, you have \(count) of them. This indicates:").font(.title).padding(.bottom, 50)
                Group {
                    if count == 0 {
                        
                        Text("There are currently no signs of pregnancy for you.")
                        
                    } else if count < 4 {
                        
                        Text("There is a low possibility of pregnancy. Moving forward you should:")
                        Text("Take a pregnancy test three weeks after your last unprotected sex. You can buy a pregnancy test from a pharmacy, or you can ask for a test to be done at: your general practice, a contraception clinic, a young people’s service (there will be an upper age limit), a pharmacy (there may be a charge), or a sexual health or genitourinary medicine (GUM) clinic.").padding(.bottom, 30)
                        Text("This website provides more detailed information on what to do: https://www.sexwise.fpa.org.uk/where-to-get-help/how-get-help-your-sexual-health").foregroundColor(.gray)
                        
                    } else {
                        
                        Text("There is a high possibility of pregnancy. Moving forward:")
                        Text("It’s normal to feel a range of different emotions. You may feel some, all, or none of the following: happiness that you’re able to get pregnant, shock that you’re actually pregnant, worry that you aren’t ready, worry that you can’t afford to have a baby, anger that you’re pregnant when you didn’t choose to be, anxiety about what other people will think, excitement about such a big change in your life, concern that you might make the wrong decision, and fear about the process of pregnancy and giving birth.").padding(.bottom, 30)
                        Text("At this point, although you might feel under pressure to make a decision, it’s important to take some time to consider your options and feel sure you’re making the right decision for you. It’s important that you receive support when you need it and don’t feel pressured by anyone into making a decision you don’t want. The decision is yours. It can be very difficult to know what to do, but support is available to help you decide. You can choose to: continue with the pregnancy and become a parent, end the pregnancy by having an abortion, or continue with the pregnancy and choose adoption.").padding(.bottom, 30)
                        Text("All the best to you, your family, and your potential baby!")
                        
                    }
                }
                
            }.padding()
        
        }
    }
}


struct Quiz_Previews: PreviewProvider {
    static var previews: some View {
        Quiz()
    }
}
