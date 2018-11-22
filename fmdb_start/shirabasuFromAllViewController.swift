//
//  shirabasuFromAllViewController.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/07/22.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit
import PDFKit

class shirabasuFromAllViewController: UIViewController,UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    var imageView: UIImageView!
    
    
    
    var getPageFromAll:Int = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        // 上がズームアウトの限界、下がズームインの限界2.0で二分の一
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2.0
        
        //スクロール時のスクロールバーを非表示
        scrollView.showsHorizontalScrollIndicator = false
        
        //画像のセット
        imageView = UIImageView(image: UIImage(named: "shiraKouki\(getPageFromAll).png"))
        //よくわからん
        imageView.contentMode = .scaleAspectFit
        //画像を押せるようにする、初期値はfalseなので指定してあげる
        imageView.isUserInteractionEnabled = true
        
        //ダブルタップの設定
        let doubleTapGesture = UITapGestureRecognizer(target: self, action:#selector(self.doubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(doubleTapGesture)
        
        //scrollViewにimageViewをセット
        scrollView.addSubview(imageView)
        
    }

    //以下はあんまり理解していない
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let image = imageView.image {
            let w_scale = scrollView.frame.width / image.size.width
            let h_scale = scrollView.frame.height / image.size.height
            
            // これで初期表示がいい感じになった
            let scale = min(w_scale, h_scale)
            
            
            scrollView.zoomScale = scale
            scrollView.contentSize = imageView.frame.size
            
            // In case that the image is larger than screen, calculate offset to show the center of image at initial launch
            let offset = CGPoint(x: (imageView.frame.width - scrollView.frame.width) / 2.0,
                                 y: (imageView.frame.height - scrollView.frame.height) / 2.0)
            scrollView.setContentOffset(offset, animated: false)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // Keep the image at center of the screen in case that the image is smaller than the screen
        scrollView.contentInset = UIEdgeInsetsMake(
            max((scrollView.frame.height - imageView.frame.height) / 2.0, 0.0),
            max((scrollView.frame.width - imageView.frame.width) / 2.0, 0.0),
            0,
            0
        );
    }
    
    //ダブルタップした時の処理
    @objc func doubleTap(gesture: UITapGestureRecognizer) -> Void {
        //２倍ズーム以下ならば
        if (self.scrollView.zoomScale < self.scrollView.maximumZoomScale) {
            //初期段階でscaleは0.5になっている→ダブルタップで２倍表示にしたいので４倍にしてあげる
            let newScale = self.scrollView.zoomScale * 4
            let zoomRect = self.zoomRectForScale(scale: newScale, center: gesture.location(in: gesture.view))
            self.scrollView.zoom(to: zoomRect, animated: true)
            //２倍ズームならば(これ以上ズームできなければ)
        } else {
            self.scrollView.setZoomScale(0.5, animated: true)
        }
    }
    
    //なんか計算しているんだね
    func zoomRectForScale(scale:CGFloat, center: CGPoint) -> CGRect{
        let size = CGSize(
            width: self.scrollView.frame.size.width / scale,
            height: self.scrollView.frame.size.height / scale
        )
        return CGRect(
            origin: CGPoint(
                x: center.x - size.width / 2.0,
                y: center.y - size.height / 2.0
            ),
            size: size
        )
    }
    

    


}
