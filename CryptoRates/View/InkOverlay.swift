import UIKit
import MaterialComponents.MaterialInk

class InkOverlay: UIView, MDCInkTouchControllerDelegate {

  fileprivate var inkTouchController: MDCInkTouchController?

  override init(frame: CGRect) {
    super.init(frame: frame)
    let white = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 0.2)
    self.inkTouchController = MDCInkTouchController(view:self)
    self.inkTouchController!.defaultInkView.inkColor = white
    self.inkTouchController!.addInkView()
    self.inkTouchController!.delegate = self
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)!
  }

  override func layoutSubviews() {
    super.layoutSubviews()
  }

}
