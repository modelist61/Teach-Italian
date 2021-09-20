//
//  OnBoardViewrouter.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 31.08.2021.
//

import Foundation

class ViewRouter: ObservableObject {
    @Published var currentPage: Tab = .obp1
    enum Tab {
        case obp0
        case obp1
        case obp2
    }
}
