//
//  OnBoardCards.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 27.08.2021.
//

import Foundation

struct OnBoardCardModel: Identifiable {
    let id = UUID()
    let title: String
    let image: String
    let text: String
    let obp: ViewRouter.Tab
}
