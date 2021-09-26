//
//  CustomToolBar.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 13.09.2021.
//

import SwiftUI

struct CustomToolBar: View {
    
    @State private var activeLink = false
    
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
                isActive: $activeLink,
                label: {
                    Image(systemName: "gearshape")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.white)
                        .onTapGesture {
                            activeLink.toggle()
                            print("TAP settings")
                        }
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
    
//    @Environment (\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentation
    
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
                    presentation.wrappedValue.dismiss()
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


struct NavigationBarModifier: ViewModifier {
        
    var backgroundColor: UIColor?
    
    init( backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .white

    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }

}
