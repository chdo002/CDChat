//
//  Utility.swift
//  CDChatList_Example
//
//  Created by chdo on 2017/11/24.
//  Copyright © 2017年 chdo002. All rights reserved.
//

import UIKit

var viwer :ImageViewer?

public class ImageViewer: NSObject {
    
    var window : UIWindow?
    class ImageViewController: UIViewController {
        override func viewDidLoad() {
            
        }
        override var prefersStatusBarHidden: Bool{
            return false
        }
    }
    var vc = ImageViewController()
    

    var imageView = UIImageView()
    var imageOringRect: CGRect!
    
    public static func showImage(image:UIImage, rectInWindow rect: CGRect){
        
        viwer = ImageViewer()
        let showWd = viwer?.window
        showWd?.makeKeyAndVisible()
        viwer?.imageView.image = image
        viwer?.imageView.frame = rect
        viwer?.imageOringRect = rect
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            viwer?.imageView.frame = (viwer?.vc.view.bounds)!
            viwer?.imageView.contentMode = .scaleAspectFit
        }) { (res) in
            
        }
    }
    
    public override init() {
        super.init()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = vc
        vc.view.backgroundColor = .black
        vc.view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panmoved(ges:)))
        vc.view.addGestureRecognizer(pan)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapges(ges:)))
        vc.view.addGestureRecognizer(tap)
        
    }
    
    var movBeginPoint : CGPoint!
    func panmoved(ges: UIPanGestureRecognizer) {
        
        switch ges.state {
        case .began:
            movBeginPoint = ges.location(in: ges.view)
        case .changed:
            
            let currentPoint = ges.location(in: ges.view)
            // 手指位移
            let deltaY = currentPoint.y - movBeginPoint.y
            if deltaY > 0 { // 手指向上移动
                
                // 修改背景透明度
                let halfScr = UIScreen.main.bounds.size.height * 0.5
                let calAlpha =  1 - (deltaY / halfScr)
                let newAlpha = calAlpha >= 0 ? calAlpha : 0
                vc.view.backgroundColor = UIColor(white: 0, alpha: newAlpha)
                
                // y = 1.5^x - 0.5
                let newScale = pow(1.4, newAlpha) - 0.4
                // 修改图片大小
                imageView.transform = CGAffineTransform(scaleX: newScale, y: newScale)
            }
            
            //
            let trans = ges.translation(in: ges.view)
            imageView.center = CGPoint(x: imageView.center.x + trans.x,
                                       y: imageView.center.y + trans.y)
            ges.setTranslation(CGPoint.zero, in: ges.view)
            
        default:
            
            if imageView.transform.a > 0.9 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.imageView.center = self.vc.view.center
                    self.vc.view.backgroundColor = UIColor(white: 0, alpha: 1)
                }, completion: { (res) in
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.imageView.frame = self.imageOringRect
                }, completion: { (res) in
                    self.tapges(ges: ges)
                })
            }
        }
    }
    func tapges(ges: UIPanGestureRecognizer){
        window?.resignKey()
        window = nil
//        适配iOS 9
        if let wind = UIApplication.shared.delegate?.window {
            wind?.makeKeyAndVisible()
        }
        
    }
}
