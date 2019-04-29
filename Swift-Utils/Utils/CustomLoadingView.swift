//
//  CustomLoadingView.swift
//  Swift-Utils
//
//  Created by Natalia Martin on 4/7/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import UIKit

class CustomLoadingView: UIView {
    @IBOutlet var messageLbl: UILabel?
    @IBOutlet var stackContainer: UIStackView?
    
    var container: UIView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    init(container: UIView) {
        super.init(frame: container.frame)
        self.container = container
        loadViewFromNib()
    }
    
    private func loadViewFromNib() {
        let bundle = Bundle(for: type(of:self))
        let nib = UINib(nibName: "CustomLoadingView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        view?.frame = (container?.frame)!
        view?.center = (container?.center)!
        self.tag = 555
        self.messageLbl?.tag = 570
        addSubview(view!)
    }
    
    func show(withMessage message: String) {
        if self.container != nil {
            
            if message != "" {
                self.messageLbl?.text = message
                for subview in (self.stackContainer?.subviews)! {
                    if subview.tag != self.messageLbl?.tag {
                        self.stackContainer?.addSubview(self.messageLbl!)
                        break
                    }
                }
            } else {
                for subview in (self.stackContainer?.subviews)! {
                    if subview.tag == self.messageLbl?.tag {
                        self.messageLbl?.removeFromSuperview()
                        break
                    }
                }
            }
            
            for subview in (self.container?.subviews)! {
                if subview.tag == self.tag {
                    return
                }
            }
            self.container?.addSubview(self)
        }
    }
    
    func isVisibleInView() -> Bool {
        for subview in (self.container?.subviews)! {
            if subview.tag == self.tag {
                return true
            }
        }
        return false
    }
    
    func hide() {
        if self.container != nil {
            for subview in (self.container?.subviews)! {
                if subview.tag == self.tag {
                    DispatchQueue.main.async() {
                        self.removeFromSuperview()
                    }
                    return
                }
            }
        }
    }
}
