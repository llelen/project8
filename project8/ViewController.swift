//https://www.hackingwithswift.com/read/8/2/building-a-uikit-user-interface-programmatically//  ViewController.swift
//  project8
//
//  Created by Ayane on 3/9/19.
//  Copyright © 2019 Ayane. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var scoreLable : UILabel!
    var cluesLable : UILabel!
    var answersLable : UILabel!
    var currentAnswerInTextFiled : UITextField!
    var letterButtons = [UIButton]()
    var clueString = ""//what we will put on clue lable
    var solutionElementsPositions = [Int]()

    
    var score = 0 {
        didSet {
            scoreLable.text = "Score: \(score)"
        }
    }
    var level = 0 //the level that we are in
    var activatedButtons = [UIButton]() //tapped buttons
    var solutions = [String]()   //this are all the words that we have to guess

    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 10
        view.layer.borderColor = UIColor.purple.cgColor
        
        
        scoreLable = UILabel()
        scoreLable.translatesAutoresizingMaskIntoConstraints = false
        scoreLable.textAlignment = .right
        scoreLable.text = "Score: 0"
        view.addSubview(scoreLable)
        
       
        cluesLable = UILabel()
        cluesLable.translatesAutoresizingMaskIntoConstraints = false
        cluesLable.text = "Clues"
        cluesLable.numberOfLines = 0
        cluesLable.font = UIFont.systemFont(ofSize: 24)
        cluesLable.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)//lower it is, xcode will care less for what constrains it has and will stretch as much as needed to feel the screen
        view.addSubview(cluesLable)
        
        answersLable = UILabel()
        answersLable.translatesAutoresizingMaskIntoConstraints = false// tamic if we type will bring this
        answersLable.text = "Answers"
        answersLable.textAlignment = .right
        answersLable.numberOfLines = 0
        answersLable.font = UIFont.systemFont(ofSize: 24)
        answersLable.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answersLable)
        
        currentAnswerInTextFiled = UITextField()
        currentAnswerInTextFiled.translatesAutoresizingMaskIntoConstraints = false
        currentAnswerInTextFiled.font = UIFont.systemFont(ofSize: 44)
        currentAnswerInTextFiled.placeholder = "Tap letters to guess"
        currentAnswerInTextFiled.textAlignment = .center
        currentAnswerInTextFiled.isUserInteractionEnabled = false
        view.addSubview(currentAnswerInTextFiled)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("Submit", for: .normal)
        submit.addTarget( self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submit)
        
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        clear.setTitle("Clear", for: .normal)

        view.addSubview(clear)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            scoreLable.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLable.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            cluesLable.topAnchor.constraint(equalTo: scoreLable.bottomAnchor),
            cluesLable.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLable.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            
            answersLable.topAnchor.constraint(equalTo: scoreLable.bottomAnchor),
            answersLable.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answersLable.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            
            cluesLable.heightAnchor.constraint(equalTo: answersLable.heightAnchor),
            
            currentAnswerInTextFiled.topAnchor.constraint(equalTo: cluesLable.bottomAnchor, constant: 20),
            currentAnswerInTextFiled.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5),
            currentAnswerInTextFiled.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            submit.topAnchor.constraint(equalTo: currentAnswerInTextFiled.bottomAnchor),
            submit.heightAnchor.constraint(equalToConstant: 44),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            
            clear.topAnchor.constraint(equalTo: currentAnswerInTextFiled.bottomAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44),
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20)

            ])
        
        let width = 150
        let height = 80
        
        for row in 0...3{
            for sector in 0...4{
                let letterButton = UIButton(type: .system)
                
                letterButton.setTitle("WWW", for: .normal)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 34)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                let frame = CGRect(x: sector * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                letterButtons.append(letterButton)
                buttonsView.addSubview(letterButton)
            }
        }
        
//        cluesLable.backgroundColor = .red
//        answersLable.backgroundColor = .blue
//        currentAnswer.backgroundColor = .yellow
//        clear.backgroundColor = .green
//        submit.backgroundColor = .green
//        buttonsView.backgroundColor = .brown
//        scoreLable.backgroundColor = #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadLevel()
    }
    
    func levelUp(_ action:UIAlertAction){
        level += 1
        solutions.removeAll()
        loadLevel()
        for l in letterButtons{
            l.isHidden = false
        }
    }

    @objc func submitTapped(_ sender: UIButton){
       
        guard let submittedText = currentAnswerInTextFiled.text else {return}
            //check if the textfield has input text
        
        //if solutions array contains the guessed word, return us it's position
            if let SolutionPosition = solutions.index(of: submittedText){
                solutionElementsPositions.append(SolutionPosition)
                activatedButtons.removeAll()
                //get array from answerlable text
                var splitAnswers = answersLable.text?.components(separatedBy: "\n")
                //replace the element in array in given position(like 7 letter) with the entered guessed word
                splitAnswers?[SolutionPosition] = submittedText
                //again make a string from array and put it in answerlable.text
                answersLable.text = splitAnswers?.joined(separator: "\n")
                
                currentAnswerInTextFiled.text = ""
                score += 1
                
                if solutionElementsPositions.count == solutions.count{
                    let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                    present(ac, animated: true)
                }
                
        }
            else{
                score -= 1
                let alert = UIAlertController(title: "Wrong", message: "Try again", preferredStyle: .alert)
                let alertButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(alertButton)
                present(alert, animated: true)
        }
            
            
        }//submitTapped
    
   
        
    
    
    @objc func clearTapped(_ sender: UIButton){
        //clear tetxfield
        currentAnswerInTextFiled.text = ""
        //show all the letterbuttons again
        for button in activatedButtons{
            button.isHidden = false
        }
        //remove the tapped buttons from array
        activatedButtons.removeAll()
    }
    
    @objc func letterTapped(_ sender: UIButton){
        //check that the button has title(letters on it)
        guard let buttomTitle = sender.titleLabel?.text else {return}
        //add the tittle of tapped button to textfileds text
        currentAnswerInTextFiled.text = currentAnswerInTextFiled.text?.appending(buttomTitle)
        //hide the tapped button
        sender.isHidden = true
        //add tapped button to tapped buttons array
        activatedButtons.append(sender)
    }
    
    
    //to load level(from text file)
    func loadLevel(){
        var bitButtons = [String]()//for 20 letterbuttons text
        var clue   = ""
        var answer = ""
        var solutionString = ""//what we will put in answer lable text untill the answer is given. like "7 letters"
        //get the text as a string from our text file where the level is
        if let stringUrl = Bundle.main.url(forResource: "text\(level)", withExtension: ".txt"){
            if let textfileString = try? String.init(contentsOf: stringUrl){
                
                //get array from separating the string by ("\n) character [HA|UNT|ED: Ghosts in residence, LE|PRO|SY: A Biblical skin disease....]
                var pairs = textfileString.components(separatedBy: "\n")
                pairs.shuffle()
                for (index,line) in pairs.enumerated(){
                    //get arrays with 2 elements [[HA|UNT|ED: ,Ghosts in residence]
                    var pairsSeparated1 = line.components(separatedBy: ": ")
                    answer = pairsSeparated1[0] //HA|UNT|ED
                    clue = pairsSeparated1[1] //Ghosts in residence
                    //one long string made from cluestring and its index(before it was part of line element
                    clueString = clueString + "\(index + 1). \(clue)\n"
                    //creating the word form HA|UNT|ED
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    
                    // is one long string, we will see this in answer section untill we guess the words
                    solutionString = solutionString + "\(solutionWord.count) Letters\n"//we are adding \n so each word will be on new line, even if it is one big string, it will be in 7 lines
                    //this are all the words that we have to guess
                    solutions.append(solutionWord)
                    //text in buttonLetters , as an arrays
                    let bitButton = answer.components(separatedBy: "|")
                    bitButtons = bitButtons + bitButton //add all 20 bits into one array and shuffle
                    
                }//pairs
            }//let textFileString
        }//let stringUrl
        //triming removes from the front and end  white space, tab, and newline
        answersLable.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)//removing \n
        cluesLable.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        bitButtons.shuffle()
        
        
        for i in 0..<bitButtons.count{
            letterButtons[i].setTitle(bitButtons[i], for: .normal)
        }
        
    }//loadLevel()
}

