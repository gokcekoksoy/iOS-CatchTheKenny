//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Gökçe Köksoy on 6.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //Variables
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var beerArray = [UIImageView] ()
    var hideTimer = Timer ()
    var highScore = 0
    
    
    
    //Views
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var brandLogo: UIImageView!
    
    @IBOutlet weak var beer1: UIImageView!
    @IBOutlet weak var beer2: UIImageView!
    @IBOutlet weak var beer3: UIImageView!
    @IBOutlet weak var beer4: UIImageView!
    @IBOutlet weak var beer5: UIImageView!
    @IBOutlet weak var beer6: UIImageView!
    @IBOutlet weak var beer7: UIImageView!
    @IBOutlet weak var beer8: UIImageView!
    @IBOutlet weak var beer9: UIImageView!
    
    @IBOutlet weak var brandLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //HighscoreCheck
        
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
        
        beer1.isUserInteractionEnabled = true
        beer2.isUserInteractionEnabled = true
        beer3.isUserInteractionEnabled = true
        beer4.isUserInteractionEnabled = true
        beer5.isUserInteractionEnabled = true
        beer6.isUserInteractionEnabled = true
        beer7.isUserInteractionEnabled = true
        beer8.isUserInteractionEnabled = true
        beer9.isUserInteractionEnabled = true

        scoreLabel.text = "Score: \(score)"
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        beer1.addGestureRecognizer(recognizer1)
        beer2.addGestureRecognizer(recognizer2)
        beer3.addGestureRecognizer(recognizer3)
        beer4.addGestureRecognizer(recognizer4)
        beer5.addGestureRecognizer(recognizer5)
        beer6.addGestureRecognizer(recognizer6)
        beer7.addGestureRecognizer(recognizer7)
        beer8.addGestureRecognizer(recognizer8)
        beer9.addGestureRecognizer(recognizer9)
        
        beerArray = [beer1, beer2, beer3, beer4, beer5, beer6, beer7, beer8, beer9]
        
        
        //Timers
        
        counter = 10
        timeLabel.text = "Time: \(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(hideBeer), userInfo: nil, repeats: true)
        
        hideBeer()
        
    }
    
    @objc func hideBeer (){
        for beer in beerArray {
            beer.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(beerArray.count - 1)))
        beerArray[random].isHidden = false
    }
    
    @objc func increaseScore () {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown (){
        counter -= 1
        timeLabel.text = "Time: \(counter)"
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for beer in beerArray {
                beer.isHidden = true
            }
            
            //Highscore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            //Alert
            
            let alert = UIAlertController(title: "Time's up!", message: "Do you wanna play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Nope", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) {
                (UIAlertAction) in
                
            // kullanıcı nope butonuna tıklarsa ikinci sayfaya geç
                
                
                
                
                
                
                
                
                
                
                
                
                
                //ReplayFunction
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideBeer), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
    
        }
    }
}

