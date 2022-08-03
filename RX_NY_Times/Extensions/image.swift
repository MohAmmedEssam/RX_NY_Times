//
//  image.swift
//  RX_NY_Times
//
//  Created by Mohammed Essam on 03/08/2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    //MARK: fromUrl
    func fromURL(_ stringUrl:String?){
        DispatchQueue.main.async {
            self.image = nil
        }
        if let stringUrl = stringUrl,
           let url = URL(string: stringUrl){
            if let cachedImage = GlobalObjects.imagesCache.object(forKey: stringUrl as NSString) {
                DispatchQueue.main.async {
                    self.image = cachedImage
                }
            }else{
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url){
                        DispatchQueue.main.async {
                            let img = UIImage(data: data)
                            self.image = img
                            if let img = img{
                                GlobalObjects.imagesCache.setObject(img, forKey: stringUrl as NSString)
                            }
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.image = nil
                        }
                    }
                }
            }
        }else{
            DispatchQueue.main.async {
                self.image = nil
            }
        }
    }
}
