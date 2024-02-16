import UIKit
import AVFoundation

@main
class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        let sourceAssetURL = URL(string: ProcessInfo.processInfo.environment["ASSET_URL"]!)!
        let asset = AVAsset(url: sourceAssetURL)
        let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetPassthrough)!
        exportSession.timeRange = .init(
            start: .init(seconds: 10, preferredTimescale: 1),
            end: .init(seconds: 15, preferredTimescale: 1)
        )
        exportSession.outputURL = sourceAssetURL.appendingPathExtension("output.mp4")
        try? FileManager.default.removeItem(at: exportSession.outputURL!)
        exportSession.outputFileType = .mp4
        exportSession.exportAsynchronously {
            precondition(exportSession.status == .completed)
            precondition(exportSession.error == nil)
        }

        return true
    }
}
