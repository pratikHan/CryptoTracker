//
//  UIApplication.swift
//  SwiftfulCrypto
//
//  Created by Pratik Hanchate on 6/8/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
