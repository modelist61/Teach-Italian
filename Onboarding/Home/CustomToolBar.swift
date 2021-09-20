//
//  CustomToolBar.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 13.09.2021.
//

import SwiftUI

struct CustomToolBar: View {
    var body: some View {
        HStack {
            Image("listImg")
                .renderingMode(.template)
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(.clear)
            Spacer()
            Text("Livello 1")
                .font(Font(UIFont(name: "SFProRounded-Semibold", size: 24)!))
                .foregroundColor(.white)
            Spacer()
            NavigationLink(
                destination: SettingsView(),
                label: {
                    Image(systemName: "gearshape")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.white)
                })
        }.frame(width: UIScreen.main.bounds.width - 32)
        
    }
}


struct CustomToolBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("onboardingBackgroundColor").ignoresSafeArea()
            VStack {
                CustomToolBar()
                Spacer()
            }
        }
    }
}

struct CustomChildToolBar: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let text: String
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "chevron.compact.left")
                    .resizable()
                    .frame(width: 12, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("Back")
                    .font(Font(UIFont(name: "SFUIDisplay-Medium", size: 18)!))
            }.frame(width: 70, alignment: .leading)
            .foregroundColor(.white)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            Spacer()
            Text(text)
                .font(Font(UIFont(name: "SFProRounded-Semibold", size: 24)!))
                .foregroundColor(.white)
            Spacer()
            Text("").opacity(0.0).frame(width: 70)
        }
        .frame(width: UIScreen.main.bounds.width - 32)
    }
}


struct CustomChildToolBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("onboardingBackgroundColor").ignoresSafeArea()
            VStack {
                CustomChildToolBar(text: "Settings")
                Spacer()
            }
        }
    }
}
