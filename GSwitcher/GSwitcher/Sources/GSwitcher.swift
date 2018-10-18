//
//  GSwitcher.swift
//  GSwitcher
//
//  Created by Pavel Grechikhin on 17/10/2018.
//  Copyright © 2018 Pavel Grechikhin. All rights reserved.
//

import UIKit

public enum GSwitcherState {
    case left
    case right
}

public protocol GSwitcherDelegate {
    func switcherDidChangeValue(_ switcher: GSwitcher, value: GSwitcherState)
}

public class GSwitcher: UIView {
    
    private var button: UIButton!
    private var buttonLeftConstraint: NSLayoutConstraint!
    public var delegate: GSwitcherDelegate?
    
    @IBInspectable var titleWithLeftPosition: String = ""
    @IBInspectable public var titleWithRightPosition: String = ""
    @IBInspectable public var on: Bool = false
    @IBInspectable public var originalImage:UIImage?
    @IBInspectable public var selectedImage:UIImage?
    @IBInspectable public var selectedColor:UIColor = UIColor(red: 0/255.0, green: 150/255.0, blue: 136/255.0, alpha: 1)
    @IBInspectable public var originalColor:UIColor = UIColor(red: 237/255.0, green: 28/255.0, blue: 36/255.0, alpha: 1)
    
    private var offCenterPosition: CGFloat!
    private var onCenterPosition: CGFloat!
    
    init(frame: CGRect, on: Bool) {
        super.init(frame: frame)
        self.on = on
        commonInit()
    }
    
    override public func awakeFromNib() {
        commonInit()
    }
    
    private func commonInit() {
        button = UIButton(type: .custom)
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(switcherButtonTouch(_:)), for: UIControl.Event.touchUpInside)
        offCenterPosition = self.bounds.height * 0.1
        onCenterPosition = self.bounds.width - (self.bounds.height * 1.55)
        
        if on == true {
            self.backgroundColor = selectedColor
            self.button.setTitle(self.titleWithRightPosition, for: .normal)
            self.button.setTitleColor(selectedColor, for: .normal)
            
        } else {
            self.backgroundColor = originalColor
            self.button.setTitle(self.titleWithRightPosition, for: .normal)
            self.button.setTitleColor(originalColor, for: .normal)
        }
        initLayout()
        animationSwitcherButton()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 12.0
        self.clipsToBounds = true
        button.layer.cornerRadius = 10.0
    }
    
    private func initLayout() {
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        buttonLeftConstraint = button.leftAnchor.constraint(equalTo: self.leftAnchor)
        buttonLeftConstraint.isActive = true
        button.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8).isActive = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor, multiplier: 1.8).isActive = true
    }
    
    public func setImages(onImage:UIImage? , offImage :UIImage?) {
        button.setImage(offImage, for: .normal)
        button.setImage(onImage, for: .selected)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func switcherButtonTouch(_ sender: AnyObject) {
        on = !on
        animationSwitcherButton()
        delegate?.switcherDidChangeValue(self, value: on ? .right : .left)
    }
    
    private func animationSwitcherButton() {
        if on == true {
            
            UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: { () -> Void in
                self.button.isSelected = true
                self.button.setTitle(self.titleWithRightPosition, for: .normal)
                self.buttonLeftConstraint.constant = self.onCenterPosition
                self.layoutIfNeeded()
                self.backgroundColor = self.selectedColor
                self.button.setTitleColor(self.selectedColor, for: .normal)
            }, completion: { (finish:Bool) -> Void in
                self.button.layer.shadowOffset = CGSize(width: 0, height: 0.2)
                self.button.layer.shadowOpacity = 0.3
                self.button.layer.shadowRadius = self.offCenterPosition
                self.button.layer.cornerRadius = 10.0
                self.button.layer.shadowPath = UIBezierPath(roundedRect: self.button.layer.bounds, cornerRadius: self.button.frame.height / 2).cgPath
            })
        } else {
            
            UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: { () -> Void in
                self.button.setTitle(self.titleWithLeftPosition, for: .normal)
                self.button.isSelected = false
                self.button.setTitleColor(self.originalColor, for: .normal)
                self.buttonLeftConstraint.constant = self.offCenterPosition
                self.layoutIfNeeded()
                self.backgroundColor = self.originalColor
            }, completion: { (finish:Bool) -> Void in
            })
        }
    }

}
