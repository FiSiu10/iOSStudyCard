//
//  SecondViewController.swift
//  StudyCard
//
//  Created by Fiona Siu on 2018-03-01.
//  Copyright © 2018 Fiona Siu. All rights reserved.
//

import UIKit
import os

class SecondViewController: ViewController {
    
    //MARK: Properties
    @IBOutlet weak var saveButton2: UIBarButtonItem!
    @IBOutlet weak var cancelButton2: UIBarButtonItem!
    @IBOutlet weak var questionName: UITextField!
    @IBOutlet weak var questionText: UITextView!
    @IBOutlet weak var answerText: UITextView!
    var list: QuestionItem?
    
    //MARK: Delegate Methods
    @IBAction func cancel2(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton2 else{
            return
        }
        if (questionName.text?.isEmpty)! || (questionText.text?.isEmpty)! || (answerText.text?.isEmpty)! {
            let alertController = UIAlertController(title: "Fields cannot be empty", message: "Start again", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
            return
        }
        list = QuestionItem(questionName: questionName.text!, question: questionText.text!, answer: answerText.text!, correctValue: 0, incorrectValue: 0)
    }

}
