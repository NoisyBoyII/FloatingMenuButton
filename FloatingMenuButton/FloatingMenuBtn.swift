
import UIKit

protocol FloatingMenuBtnAction: class {
    func btnClicked(tag: Int)
}

class FloatingMenuBtn {
    var mainButton: UIButton?
    var images: [UIImage]?
    var btnItems: [UIButton]? = []
    var isOpen: Bool = false
    weak var delegate: FloatingMenuBtnAction?
    var backGroundView: UIView?
    
    
    init(parentView: UIView, mainButton: UIButton, images: [UIImage]) {
        self.mainButton = mainButton
        self.images = images
        isOpen = false
        createButton(parentView: parentView)
    }
    
    /**
     Button created according to number of images
     */
    
    private func createButton(parentView: UIView) {
        backGroundView = UIView(frame: CGRect(x: 0, y: 0, width: parentView.frame.width, height: parentView.frame.height))
        backGroundView?.backgroundColor = .lightGray
        backGroundView?.alpha = 0.5
        parentView.insertSubview(backGroundView!, belowSubview: mainButton!)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleMenu))
        tapGesture.numberOfTapsRequired = 1
        backGroundView?.addGestureRecognizer(tapGesture)
        for (index, image) in images!.enumerated() {
            let btn = UIButton(frame: CGRect(x: 0,y: 0,width: 44,height: 44))
            btn.setImage(image, for: .normal)
            btn.backgroundColor = .blue
            btn.layer.cornerRadius = 22
            btn.tag = index
            btn.addTarget(self, action: #selector(menuButtonClicked(_:)), for: .touchUpInside)
            parentView.addSubview(btn)
            btnItems?.append(btn)
        }
        
        closeMenu()
        hideButton()
    }
    
    /**
     While hiding , center of hiding button changes to mainBtn center
     */
    
    private func closeMenu() {
        for item in btnItems! {
            item.center = CGPoint(x: mainButton!.center.x, y: mainButton!.center.y)
            item.transform = CGAffineTransform(rotationAngle: .pi)
        }
    }
    
    private func hideButton() {
        for item in btnItems! {
            item.isHidden = true
        }
        backGroundView?.isHidden = true
    }
    
    /**
     While unhiding ,center y axis of hiding button changes to mainBtn center y axis by offset 60
     */
    
    private func openMenu() {
        var offSet: CGFloat = 60
        for item in btnItems! {
            item.center = CGPoint(x: mainButton!.center.x, y: mainButton!.center.y - offSet)
            item.transform = .identity
            offSet += 60
        }
        unHideButton()
    }
    
    private func unHideButton() {
        for item in btnItems! {
            item.isHidden = false
        }
        backGroundView?.isHidden = false
    }
    
    
    /**
     Used for toggle menu via isOpen boolean
     */
    
    @objc public func toggleMenu() {
        UIView.animate(withDuration: 0.5, animations: {
            self.mainButton?.isSelected = !self.mainButton!.isSelected
            if self.isOpen == false {
                self.openMenu()
                self.isOpen = true
            } else {
                self.closeMenu()
                self.isOpen = false
            }
        }) { (done) in
            if self.isOpen == false {
                self.hideButton()
            }
        }
    }
    
    /**
     Menu Option clicked via tags
     */
    
    @objc func menuButtonClicked(_ sender: Any) {
        let btn = sender as! UIButton
        delegate?.btnClicked(tag: btn.tag)
    }
}
