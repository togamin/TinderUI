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
    
    @IBOutlet weak var goodbadImageView: UIImageView!
    // Screenの高さ
    var screenHeight:CGFloat!
    // Screenの幅
    var screenWidth:CGFloat!
    
    //スライドするカードの配列。
    var animalCards = [UIView]()
    var animalName:[String]!
    
    //カード
    @IBOutlet weak var animal01: UIView!
    @IBOutlet weak var animal02: UIView!
    @IBOutlet weak var animal03: UIView!
    //カードを決めるための変数
    var selectedCount = 0
    //Likeされたカードの情報を入れる変数
    var likecard = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //カードのセンターの位置を代入。
        cardCenter = card.center
        
        // 画面サイズ取得
        let screenSize: CGRect = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
/*-----------------------------------------------------*/
        //カードの配列を作成
        animalCards = [animal01,animal02,animal03]
        animalName = ["ペンギン","ハリネズミ","ネコ"]
/*-----------------------------------------------------*/
    }

    
    //ジェスチャーした時の処理。
    @IBAction func gesture(_ sender: UIPanGestureRecognizer) {
        
        //senderはドラックアンドドロップされたもの。スワイプされた時の情報
        let swipeCard = sender.view!
        //どれくらいスワイプしたかの位置情報。
        let point = sender.translation(in:view)
        
        
        //スワイプした分カードを動かす。
        swipeCard.center = CGPoint(x: swipeCard.center.x + point.x*0.1,y:swipeCard.center.y)
        
        animalCards[selectedCount].center = CGPoint(x: swipeCard.center.x + point.x*0.1,y:swipeCard.center.y)

        
        
        
        //カードのセンターのx座標.カードの角度を変える。
        //この値がプラスなら、右マイナスなら左にスワイプされたことになる。
        //45°のラジアン表記は0.785
        let cardCenterX = swipeCard.center.x - view.center.x
        
        swipeCard.transform = CGAffineTransform(rotationAngle: cardCenterX/(view.frame.width/2) * -0.785)
        
        animalCards[selectedCount].transform = CGAffineTransform(rotationAngle: cardCenterX/(view.frame.width/2) * -0.785)
        
        
        
        
        //スワイプさせる方向のよって表示させる画像を変える。
        if cardCenterX > 0 {
            goodbadImageView.image = #imageLiteral(resourceName: "Tinder01")
            goodbadImageView.alpha = 1
        }else if cardCenterX < 0{
            goodbadImageView.image = #imageLiteral(resourceName: "Tinder02")
            goodbadImageView.alpha = 1
        }
        
        
        
        //スワイプの指が離れたときの処理。
        if sender.state == UIGestureRecognizerState.ended{
            //カードが大きく左にスワイプされた時。
            if swipeCard.center.x < self.screenWidth/5 {
                UIView.animate(withDuration: 0.2, animations: {
                    //swipeCard.center = CGPoint(x: self.cardCenter.x - self.screenWidth*2,y:self.cardCenter.y)
                    //大きくスワイプされた後に、元となるカードを元の位置に戻す。
                    swipeCard.center = CGPoint(x: self.cardCenter.x,y:self.cardCenter.y)
                    swipeCard.transform = .identity
                    
                    self.animalCards[self.selectedCount].center = CGPoint(x: self.cardCenter.x - self.screenWidth*2,y:self.cardCenter.y)
                    
                    if self.selectedCount == self.animalCards.count - 1{
                        swipeCard.isHidden = true
                    }else{
                        self.selectedCount += 1
                    }
                    self.goodbadImageView.alpha = 0
                })
                return//処理が呼ばれた後に、gesture関数から抜け出す。
            }else if swipeCard.center.x > self.screenWidth - self.screenWidth/5 {
                UIView.animate(withDuration: 0.2, animations: {
                    //swipeCard.center = CGPoint(x: self.cardCenter.x + self.screenWidth*2,y:self.cardCenter.y)
                    //大きくスワイプされた後に、元となるカードを元の位置に戻す。
                    swipeCard.center = CGPoint(x: self.cardCenter.x,y:self.cardCenter.y)
                    swipeCard.transform = .identity
                    
                    self.animalCards[self.selectedCount].center = CGPoint(x: self.cardCenter.x + self.screenWidth*2,y:self.cardCenter.y)
                    
                    self.likecard.append(self.animalName[self.selectedCount])
                    print(self.likecard)
                    
                    if self.selectedCount == self.animalCards.count - 1{
                        swipeCard.isHidden = true
                    }else{
                        self.selectedCount += 1
                    }
                    self.goodbadImageView.alpha = 0
                    
                })
                return
            }
            //指が離れた時にカードを真ん中に戻す処理を書く。
            UIView.animate(withDuration: 0.2, animations: {
                swipeCard.center = CGPoint(x: self.cardCenter.x,y:self.cardCenter.y)
                swipeCard.transform = .identity
                self.goodbadImageView.alpha = 0
                
                self.animalCards[self.selectedCount].center = CGPoint(x: self.cardCenter.x,y:self.cardCenter.y)
                self.animalCards[self.selectedCount].transform = .identity
            })
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

