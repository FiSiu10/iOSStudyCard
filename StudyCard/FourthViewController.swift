//
//  FourthViewController.swift
//  StudyCard
//
//  Created by Fiona Siu on 2018-03-05.
//  Copyright © 2018 Fiona Siu. All rights reserved.
//

import UIKit
import os

class FourthViewController: ViewController {
    
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var incorrectLabel: UILabel!
    @IBOutlet weak var answerText: UILabel!
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var incorrectButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    var answer: String?
    var correctValue: Int?
    var incorrectValue: Int?
    
    @IBAction func clear(_ sender: Any) {
        correct = 0
        incorrect = 0
    }
    
    var correct: Int = 0 {
        didSet{
            correctLabel.text = "\(correct)"
        }
    }
    
    var incorrect: Int = 0 {
        didSet{
            incorrectLabel.text = "\(incorrect)"
        }
    }
    
    @IBAction func correct(_ sender: Any) {
        correct += 1
        
        let alertController = UIAlertController(title: "Great Job!", message: nil, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
        }
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    @IBAction func incorrect(_ sender: Any) {
        incorrect += 1
        
        let alertController = UIAlertController(title: "It's okay!", message: "Try again", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        answerText.text = answer
        clearButton.layer.cornerRadius = 6
        correctButton.layer.cornerRadius = 6
        incorrectButton.layer.cornerRadius = 6
        
        if (correctValue == nil){
            correct = 0
        }
        correct = correctValue!
        
        if (incorrectValue == nil){
            incorrect = 0
        }
        incorrect = incorrectValue!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
    
    @IBAction override func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        correctValue = correct
        incorrectValue = incorrect
    }

}
