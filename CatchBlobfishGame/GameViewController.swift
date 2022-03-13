//
//  ViewController.swift
//  CatchBlobfishGame
//
//  Created by 冨樫由城乃 on 2022/03/06.
//

import UIKit

class ViewController: UIViewController {
    
    //Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var blobArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    //Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var blob1: UIImageView!
    @IBOutlet weak var blob2: UIImageView!
    @IBOutlet weak var blob3: UIImageView!
    @IBOutlet weak var blob4: UIImageView!
    @IBOutlet weak var blob5: UIImageView!
    @IBOutlet weak var blob6: UIImageView!
    @IBOutlet weak var blob7: UIImageView!
    @IBOutlet weak var blob8: UIImageView!
    @IBOutlet weak var blob9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        scoreLabel.text = "Score: \(score)"
        
        //Highscore check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        //Images
        
        blobArray =  [blob1, blob2, blob3, blob4, blob5, blob6, blob7, blob8, blob9]
        
        for blob in blobArray {
            blob.isUserInteractionEnabled = true
        }

        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        blob1.addGestureRecognizer(recognizer1)
        blob2.addGestureRecognizer(recognizer2)
        blob3.addGestureRecognizer(recognizer3)
        blob4.addGestureRecognizer(recognizer4)
        blob5.addGestureRecognizer(recognizer5)
        blob6.addGestureRecognizer(recognizer6)
        blob7.addGestureRecognizer(recognizer7)
        blob8.addGestureRecognizer(recognizer8)
        blob9.addGestureRecognizer(recognizer9)
        
        
        //Timers
        counter = 10
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(hideBlob), userInfo: nil, repeats: true)
        
        hideBlob()
        
    }
    
    @objc func hideBlob(){
        for blob in blobArray {
            blob.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(blobArray.count - 1)))
        blobArray[random].isHidden = false
    }
    
    @objc func increaseScore(){
        
        score += 1
        scoreLabel.text = "Score: \(score)"
    
    }
    
    @objc func countDown(){
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for blob in blobArray {
                blob.isHidden = true
            }
            
            //HighScore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            //alert
            
            let alert = UIAlertController(title: "Time is Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                //replay function
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.hideBlob), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
    
    }


}

//Other function
//難易度の設定によってBlobが現れる速度を変える　Easy0.8 Medium 0.7 Difficult 0.5とか。
