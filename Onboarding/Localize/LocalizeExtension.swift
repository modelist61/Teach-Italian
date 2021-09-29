//
//  LocalizeExtension.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 27.09.2021.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}
