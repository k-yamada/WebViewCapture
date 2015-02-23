//
//  ViewController.swift
//  WebViewCapture
//
//  Created by 山田 和弘 on 2015/02/22.
//  Copyright (c) 2015年 k-yamada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var webView: UIWebView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let requestURL = NSURL(string: "http://yahoo.co.jp")
    let req = NSURLRequest(URL: requestURL!)
    webView.loadRequest(req)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func captureButtonClicked(sender: UIButton) {
    capture()
  }
  
  @IBAction func fullScreenCaptureButtonClicked(sender: UIButton) {
    fullScreenCapture()
  }
  
  func capture() {
    // webView to UIImage
    UIGraphicsBeginImageContext(webView.bounds.size);
    webView.layer.renderInContext(UIGraphicsGetCurrentContext())
    var image:UIImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // PhotoAlbumに保存
    UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
  }
  
  func fullScreenCapture() {
    // tempframe to reset view size after image was created
    var tmpFrame = webView.frame
    
    // set new Frame
    var aFrame         = webView.frame;
    aFrame.size.height = webView.sizeThatFits(UIScreen.mainScreen().bounds.size).height;
    webView.frame      = aFrame;
    
    // webView to UIImage
    UIGraphicsBeginImageContext(webView.sizeThatFits(UIScreen.mainScreen().bounds.size));
    webView.layer.renderInContext(UIGraphicsGetCurrentContext())
    var image:UIImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // reset Frame of view to origin
    webView.frame = tmpFrame;
    
    // PhotoAlbumに保存
    UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
  }
  
  func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) {
    if error != nil {
      //プライバシー設定不許可など書き込み失敗時は -3310 (ALAssetsLibraryDataUnavailableError)
      println(error.code)
    }
  }
}

