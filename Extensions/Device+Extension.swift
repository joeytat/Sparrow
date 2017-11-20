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
}
