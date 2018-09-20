//
//  ViewController.swift
//  TinderUI
//
//  Created by Togami Yuki on 2018/09/19.
//  Copyright © 2018 Togami Yuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var card: UIView!
    var cardCenter:CGPoint!//カードのセンターの位置を入れるための変数。
    
    // Screenの高さ
    var screenHeight:CGFloat!
    // Screenの幅
    var screenWidth:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //カードのセンターの位置を代入。
        cardCenter = card.center
        
        // 画面サイズ取得
        let screenSize: CGRect = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
    }

    
    
    @IBAction func gesture(_ sender: UIPanGestureRecognizer) {
        //senderはドラックアンドドロップされたもの。スワイプされた時の情報
        let swipeCard = sender.view!
        //どれくらいスワイプしたかの位置情報。
        let point = sender.translation(in:view)
        //スワイプした分カードを動かす。
        swipeCard.center = CGPoint(x: swipeCard.center.x + point.x*0.1,y:swipeCard.center.y)
        
        //カードのセンターのx座標.カードの角度を変える。
        //この値がプラスなら、右マイナスなら左にスワイプされたことになる。
        //45°のラジアン表記は0.785
        let cardCenterX = swipeCard.center.x - view.center.x
        swipeCard.transform = CGAffineTransform(rotationAngle: cardCenterX/(view.frame.width/2) * -0.785)
        
        //スワイプの指が離れたときの処理。
        if sender.state == UIGestureRecognizerState.ended{
            //カードが大きく左にスワイプされた時。
            if swipeCard.center.x < self.screenWidth/5 {
                UIView.animate(withDuration: 0.2, animations: {
                    swipeCard.center = CGPoint(x: self.cardCenter.x - self.screenWidth,y:self.cardCenter.y)
                })
                return//処理が呼ばれた後に、gesture関数から抜け出す。
            }else if swipeCard.center.x > self.screenWidth - self.screenWidth/5 {
                UIView.animate(withDuration: 0.2, animations: {
                    swipeCard.center = CGPoint(x: self.cardCenter.x + self.screenWidth,y:self.cardCenter.y)
                })
                return
            }
            //指が離れた時、にカードを真ん中に戻す処理を書く。
            UIView.animate(withDuration: 0.2, animations: {
                swipeCard.center = CGPoint(x: self.cardCenter.x,y:self.cardCenter.y)
                swipeCard.transform = .identity
            })
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

