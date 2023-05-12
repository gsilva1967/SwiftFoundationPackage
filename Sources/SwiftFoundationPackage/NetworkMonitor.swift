//
//  InternetReachability.swift
//  FirstResponderSystem (iOS)
//
//  Created by Michael Kacos on 4/21/23.
//

import Foundation
import Network

@available(iOS 16.0, *)
final class NetworkMonitor: ObservableObject {
    @Published private(set) var isConnected = false
    
    private let nwMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue.global()
    
    public func start() {
        nwMonitor.start(queue: workerQueue)
        nwMonitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
                
            }
        }
    }
    
    public func stop() {
        nwMonitor.cancel()
    }
}
