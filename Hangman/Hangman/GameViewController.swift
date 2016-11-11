//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    var lives = 6
    var phrase : String?
    @IBOutlet weak var guess: UITextField!
    
    @IBOutlet weak var pastGuesses: UILabel!
    @IBOutlet weak var guessButton: UIButton!

    @IBOutlet weak var phraseLabel: UILabel!
    @IBOutlet weak var hangman: UIImageView!
    let winGame = UIAlertController(title: "You Won!", message: nil, preferredStyle: UIAlertControllerStyle.alert)
    let loseGame = UIAlertController(title: "You Lost!", message: nil, preferredStyle: UIAlertControllerStyle.alert)
    

    @IBAction func guessButton(_ sender: UIButton) {
        if let letter = guess.text {
            if !(pastGuesses.text?.contains(letter))! && guess.text != "" {
                var updateString = ""
                var counter = 0
                var correct = 0
                for x in (phrase?.characters)! {
                    print(letter)
                    print(x)
                    print(phrase?[(phrase?.index((phrase?.startIndex)!, offsetBy: counter))!])
                    var temp = ""
                    temp.append(x)
                    temp = temp.lowercased()
                    if x == letter[letter.startIndex] || letter[letter.startIndex] == temp[temp.startIndex] {
                        updateString.append(x)
                        correct = 1
                    } else {
                        if (phrase?[(phrase?.index((phrase?.startIndex)!, offsetBy: counter))!])! == " " {
                            updateString.append(" ")
                        } else if phraseLabel.text![(phraseLabel.text?.index((phraseLabel.text?.startIndex)!, offsetBy: counter))!] != "_" {
                            updateString.append(x)
                        } else {
                            updateString.append("_")
                        }
                    }
                    counter += 1
                }
                phraseLabel.text = updateString
                if (correct == 0 && !(pastGuesses.text?.contains(letter))!) {
                    pastGuesses.text?.append(letter)
                    lives -= 1
                    switch lives {
                    case 5:
                        hangman.image = UIImage(named: "hangman6.gif")
                    case 4:
                        hangman.image = UIImage(named: "hangman5.gif")
                    case 3:
                        hangman.image = UIImage(named: "hangman4.gif")
                    case 2:
                        hangman.image = UIImage(named: "hangman3.gif")
                    case 1:
                        hangman.image = UIImage(named: "hangman2.gif")
                    case 0:
                        hangman.image = UIImage(named: "hangman1.gif")
                    default:
                        break
                    }
                    if (lives == 0) {
                        self.present(loseGame, animated: true, completion: nil)
                    }
                } else if !updateString.contains("_") {
                    self.present(winGame, animated: true, completion: nil)
                }
                guess.text = ""
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupParams()
        winGame.addAction(UIAlertAction(title: "New Game", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in self.setupParams()}))
        loseGame.addAction(UIAlertAction(title: "New Game", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in self.setupParams()}))
        view.addSubview(hangman)
    }
    
    func setupParams() {
        lives = 6
        pastGuesses.text = ""
        
        hangman.image = UIImage(named: "hangman7.gif")
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()
        view.addSubview(hangman)
        phraseLabel.text = ""
        for x in (phrase?.characters)! {
            if x == " " {
                phraseLabel.text?.append(x)
            } else {
                phraseLabel.text?.append("_")
            }
        }
        print(phrase)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
