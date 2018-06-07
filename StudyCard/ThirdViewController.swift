//
//  ThirdViewController.swift
//  StudyCard
//
//  Created by Fiona Siu on 2018-03-05.
//  Copyright © 2018 Fiona Siu. All rights reserved.
//

import UIKit
import os

class ThirdViewController: ViewController {

    
    @IBOutlet weak var checkAnswer: UIButton!
    @IBOutlet weak var questionText: UILabel!
    var list: QuestionItem?
    var answer: String?
    var questionName: String?
    var correctValue: Int?
    var incorrectValue: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAnswer.layer.cornerRadius = 6

        if let list = list {
            questionText.text = list.question;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "ShowAnswer"{
            guard let tempViewController = segue.destination as? UINavigationController else{
                fatalError("Unexpected destination \(segue.destination)")
            }
            guard let detailViewController = tempViewController.topViewController as? FourthViewController else{
                fatalError("Unexpected destination \(segue.destination)")
            }
            detailViewController.answer = list?.answer
            detailViewController.correctValue = list?.correctValue
            detailViewController.incorrectValue = list?.incorrectValue
        }
    }
    
    @IBAction override func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation



}
