//
//  PreviewImageViewController.swift
//  Swift-Utils
//
//  Created by Natalia Martin on 22/5/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import UIKit

protocol PreviewImageViewControllerDelegate: class {
    func previewImageViewController(_ previewImageViewController: PreviewImageViewController, didConfirmImage image: UIImage?, withTag tag: Int?)
}

class PreviewImageViewController: UIViewController {
    @IBOutlet weak var previewIV: UIImageView!
    weak var delegate: PreviewImageViewControllerDelegate?
    var previewImage: UIImage?
    var tag: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previewIV.image = previewImage
    }
    
    @IBAction func continuarButtonDidPress(_ sender: AnyObject) {
        delegate?.previewImageViewController(self, didConfirmImage: self.previewIV.image, withTag: tag)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonDidPress(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
