//
//  Sound+Extension.swift
//  Sparrow
//
//  Created by Joey on 20/11/2017.
//

import Foundation
import AudioUnit
import AVFoundation

public struct Device {
    public static func playSound(_ filename: String, type: String? = nil) {
        guard let filePath = Bundle.main.path(forResource: filename, ofType: type)
            else { return }
        let url = NSURL(fileURLWithPath: filePath)
        var soundId: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(url, &soundId)
        AudioServicesPlayAlertSound(soundId)
    }
    
    public static func flashlight(_ isOn: Bool) {
        if Device.isSimulator() { return }
        guard let flashlight: AVCaptureDevice = AVCaptureDevice.default(for: .video)
            else { return }
        
        if flashlight.isTorchAvailable && flashlight.isTorchModeSupported(.on) {
            guard let _ = try? flashlight.lockForConfiguration() else {
                return
            }
            flashlight.torchMode = isOn ? .on : .off
            flashlight.unlockForConfiguration()
        }
    }
    
    public static func isSimulator() -> Bool {
        #if arch(i386) || arch(x86_64)
            return true
        #else
            return false
        #endif
    }
    
    public static let isPad = UIDevice.current.userInterfaceIdiom == .pad
    
    public static func makePhoneCall(_ number: String) {
        guard let number = URL(string: "tel://" + number) else { return }
        UIApplication.shared.openURL(number)
    }
    
    
    public static func openSettings() {
        guard let url = URL(string: UIApplicationOpenSettingsURLString) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    public static var isX: Bool {
        return UIScreen.main.nativeBounds.height == 2436
    }
    
    public static var safeArea: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow!.safeAreaInsets
        } else {
            return UIEdgeInsets.zero
        }
    }
}
