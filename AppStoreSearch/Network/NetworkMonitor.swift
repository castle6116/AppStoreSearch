//
//  NetworkMonitor.swift
//  AppStoreSearch
//
//  Created by 김진우 on 2023/03/22.
//

import Foundation
import Network
import RxSwift

final class NetworkMonitor {
    private let queue = DispatchQueue.global(qos: .background)
    private let monitor: NWPathMonitor
    
    init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring(statusUpdateHandler: @escaping (NWPath.Status) -> Void) {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                statusUpdateHandler(path.status)
            }
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
