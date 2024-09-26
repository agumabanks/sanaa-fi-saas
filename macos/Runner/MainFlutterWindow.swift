import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    // Set the minimum size of the window (half screen width)
    self.minSize = NSSize(width: NSScreen.main!.frame.width / 2, height: 600)


    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
