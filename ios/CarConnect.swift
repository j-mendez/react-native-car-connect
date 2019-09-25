//
//  CarConnect.swift
//  CarConnect
//
//  Created by Jeffrey Mendez on 9/22/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import AVFoundation

@objc(CarConnect)
class CarConnect: RCTEventEmitter {
    private var connected = false

    override init() {
        super.init()
        checkAudioChannelConnection()
    }

    @objc
    func start(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleRouteChange),
                                               name: AVAudioSession.routeChangeNotification,
                                               object: AVAudioSession.sharedInstance())
        print("setting timer to get status: \(connected)")
    }

    @objc
    func stop() {
        NotificationCenter.default.removeObserver(AVAudioSession.routeChangeNotification)
    }

    @objc
    func checkAudioChannelConnection() {
        let outputs = AVAudioSession.sharedInstance().currentRoute.outputs
        var connection = false;

        for output in outputs{
          if output.portType == AVAudioSession.Port.bluetoothA2DP || output.portType == AVAudioSession.Port.bluetoothHFP {
            if !connection {
                connection = true
            }
            if !connected {
                connect()
            }
          }
        }

        if (connected && !connection) {
          disconnect()
        }

        print("connection is \(connected)")
    }

    @objc func handleRouteChange(notification: Notification) {
        guard let userInfo = notification.userInfo,
        let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
        let reason = AVAudioSession.RouteChangeReason(rawValue:reasonValue) else {
            return
        }
        switch reason {
            case .newDeviceAvailable:
              let session = AVAudioSession.sharedInstance()
              for output in session.currentRoute.outputs where output.portType == AVAudioSession.Port.bluetoothA2DP || output.portType == AVAudioSession.Port.bluetoothHFP {
                  connect()
                  break
              }
            case .oldDeviceUnavailable:
              if let previousRoute =
                  userInfo[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription {
                for output in previousRoute.outputs where output.portType == AVAudioSession.Port.bluetoothA2DP || output.portType == AVAudioSession.Port.bluetoothHFP  {
                      disconnect()
                      break
                  }
              }
            default: ()
        }
    }

    @objc
    func connect() {
        connected = true
        print("conected is \(connected)")
        sendEvent(withName: "onConnect", body: ["connected": connected])
    }

    @objc
    func disconnect() {
        connected = false
        print("conected is \(connected)")
        sendEvent(withName: "onDisconnect", body: ["connected": connected])
    }

    override
    func constantsToExport() -> [AnyHashable : Any]! {
        return ["connected": connected]
    }

    override func supportedEvents() -> [String]! {
        return ["onConnect", "onDisconnect"]
    }

    override
        static func requiresMainQueueSetup() -> Bool {
        return true
    }

    deinit {
        stop()
    }

}
