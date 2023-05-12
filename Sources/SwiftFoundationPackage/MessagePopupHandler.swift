//
//  MessagePopupHandler.swift
//  FirstResponderSystem
//
//  Created by Gustavo Silva on 1/19/23.
//

import Combine
import Foundation

@available(iOS 16.0, *)
class MessagePopupHandler: ObservableObject {
    // Using a closure allows us to set up our singleton with any setup needed
    static let shared: MessagePopupHandler = {
        let instance = MessagePopupHandler()
        // Setup code
        return instance
    }()

    // Ensure there is only ever one instance
    private init() {}

    // Pass thru with message
    let hasPopup = PassthroughSubject<String, Never>()

    func showPopup(message: String) {
        DispatchQueue.main.async { [self] in
            self.hasPopup.send(message)
        }
    }
}
