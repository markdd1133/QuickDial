//
//  SettingNameViewController.swift
//  QuickDial
//
//  Created by Sheng Chi Chen on 2017/4/26.
//  Copyright © 2017年 Sheng Chi Chen. All rights reserved.
//

import UIKit

class SettingNameViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func backToMain(_ sender: UIButton) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    var backgroundColorInfo:UIColor?{
        didSet{
            if backgroundColorInfo != nil{
                view.backgroundColor = backgroundColorInfo!
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        nameTextField.becomeFirstResponder()
        let appDel = UIApplication.shared.delegate as? AppDelegate
        nameTextField.text = appDel?.tempData.name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard nameTextField.text != nil else { return false }
        if nameTextField.text == ""{
            let myAlert = UIAlertController(title: "Ooops!", message: "Please enter a contact name", preferredStyle: .alert)
            myAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(myAlert, animated: true, completion: nil)
            return false
        }else{
            let appDel = UIApplication.shared.delegate as? AppDelegate
            appDel?.tempData.name = nameTextField.text!
            performSegue(withIdentifier: "showSettingNumber", sender: nil)
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSettingNumber"{
            let dvc = segue.destination as? SettingNumberViewController
            dvc?.backgroundColorInfo = view.backgroundColor
        }
    }

}
