//
//  UIImageView+Extension.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 26/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import UIKit
import AlamofireImage

protocol UIImageViewCustomDataSoruce  {
    func didSetImage(imgeView: UIImageView?)
}

extension UIImageView {
    
    func getImage(from url: URL?, rounded: CGFloat? = 0, delegate: UIImageViewCustomDataSoruce? = nil){
        guard let url = url else {
            return
        }
        APIMarvel().requestImage(from: url) { (image) in
            var img = image
            self.layer.masksToBounds = false
                       self.clipsToBounds = true
            img = img?.af.imageAspectScaled(toFill: self.frame.size)
            if rounded ?? 0 > 0 {
                img = img?.af.imageRounded(withCornerRadius: rounded!)
            }
           
            self.image = img
            delegate?.didSetImage(imgeView: self)
        }
    }
}
