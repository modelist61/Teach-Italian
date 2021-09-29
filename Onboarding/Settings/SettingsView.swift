//
//  SettingsView.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 16.09.2021.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    
    @State var onbooardingOn = false
    
    var body: some View {
        ZStack(alignment: .top) {
                Color("onboardingBackgroundColor").ignoresSafeArea()
            VStack(spacing: 30) {
                VStack(alignment: .leading) {
                    SettingsButtonHeader(text: "Impostazioni di allenamento")
                    SettingsButton(text: "Educations settings", systemImage: "circle.grid.2x2")
                }
                
                VStack(alignment: .leading) {
                    SettingsButtonHeader(text: "Funzioni dell'applicazione")
                    SettingsButton(text: "Rate app", systemImage: "star")
                        .onTapGesture {
                            if let windowScene = UIApplication.shared.windows.first?.windowScene { SKStoreReviewController.requestReview(in: windowScene) }
                        }
                    SettingsButton(text: "Contact the developer", systemImage: "exclamationmark.triangle")
                        .onTapGesture {
                            let mailtoString = "mailto:nemecek@support.com".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                            let mailtoUrl = URL(string: mailtoString!)!
                            if UIApplication.shared.canOpenURL(mailtoUrl) {
                                    UIApplication.shared.open(mailtoUrl, options: [:])
                            }
                        }
                }
                
                VStack(alignment: .leading) {
                    SettingsButtonHeader(text: "Altro")
                    SettingsButton(text: "About app", systemImage: "exclamationmark.circle")
                    SettingsButton(text: "Restore purchase", systemImage: "creditcard")

                }
//                VStack {
//                    Toggle(isOn: $onbooardingOn ) {
//                        Text("turn on Onboarding at next lunch")
//                    }
//                }.onDisappear {
//                    
//                }
            }
        }.navigationBarBackButtonHidden(true)
        .toolbar {
            CustomChildToolBar(text: "Impostazioni")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct SettingsButton: View {
    let text: String
    let systemImage: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
            HStack {
                Text(text)
                    .font(Font(UIFont(name: "SFUIDisplay-Medium", size: 18)!))
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: systemImage)
                    .makeResizable(height: 24)
                    .foregroundColor(Color("playButtonColor"))
            }.padding()
        }.frame(width: 345, height: 60)
    }
}

struct SettingsButtonHeader: View {
    let text: String
    var body: some View {
        Text(text)
            .font(Font(UIFont(name: "SFUIDisplay-Regular", size: 16)!))
            .foregroundColor(.white.opacity(0.6))
    }
}
