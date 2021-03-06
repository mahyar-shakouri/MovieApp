//
//  SecondViewController.swift
//  MovieApp
//
//  Created by MahyarShakouri on 8/26/1400 AP.
//

import UIKit
import RealmSwift

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var seasonTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var realm : Realm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.saveButton.isEnabled = false
        self.saveButton.backgroundColor = UIColor.init(red: 128/255, green: 102/255, blue: 56/255, alpha: 1.0)
        self.titleTextField.delegate = self
        
        realm = try! Realm()
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            
            if updatedText.count > 1 {
                self.saveButton.isEnabled = true
                self.saveButton.backgroundColor = UIColor.init(red: 255/255, green: 162/255, blue: 5/255, alpha: 1.0)
            }
            else {
                self.saveButton.isEnabled = false
                self.saveButton.backgroundColor = UIColor.init(red: 128/255, green: 102/255, blue: 56/255, alpha: 1.0)
            }
        }
        return true
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        let movie = Movie()
        
        movie.title = titleTextField.text ?? ""
        movie.year = Int(yearTextField.text ?? "") ?? 0
        movie.numOfSeasons = Int(seasonTextField.text ?? "") ?? 0
        
        try! realm?.write {
            realm?.add(movie)
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "showList")
        self.navigationController?.show(vc!, sender: nil)
        
    }
}
