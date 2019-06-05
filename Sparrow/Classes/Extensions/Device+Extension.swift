//
//  Sound+Extension.swift
//  Sparrow
//
//  Created by Joey on 20/11/2017.
//

import Foundation
import AudioUnit
import AVFoundation
import StoreKit

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
    guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
    if #available(iOS 10.0, *) {
      UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
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
  
  public static func changeIcon(_ name: String?) {
    guard #available(iOS 10.3, *) else { return }
    guard UIApplication.shared.supportsAlternateIcons else { return }
    
    UIApplication.shared.setAlternateIconName(name) { (error) in
      
    }
  }
  
  public static var version: String {
    let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    let build = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    return "\(version)-\(build)"
  }
  
  public static func taptic(_ type: UINotificationFeedbackGenerator.FeedbackType = UINotificationFeedbackGenerator.FeedbackType.success) {
    if #available(iOS 10.0, *) {
      UINotificationFeedbackGenerator().notificationOccurred(type)
    }
  }
  
  public static func copyText(_ text: String?, of: String = "") {
    UIPasteboard.general.string = text
    UIApplication.shared.keyWindow?
      .visibleViewController?
      .show("已复制\(of)到粘贴板")
  }
  
  public static func askForRating() {
    if #available(iOS 10.3, *) {
      SKStoreReviewController.requestReview()
    }
  }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
  return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
