//
//  SettingNumberViewController.swift
//  QuickDial
//
//  Created by Sheng Chi Chen on 2017/4/26.
//  Copyright © 2017年 Sheng Chi Chen. All rights reserved.
//

import UIKit

class SettingNumberViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBAction func backToSettingName(_ sender: UIButton) {
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
        numberTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        numberTextField.becomeFirstResponder()
        let appDel = UIApplication.shared.delegate as? AppDelegate
        numberTextField.text = appDel?.tempData.number
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard numberTextField.text != nil else { return false }
        if numberTextField.text == ""{
            let myAlert = UIAlertController(title: "Ooops!", message: "Please enter a contact number", preferredStyle: .alert)
            myAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(myAlert, animated: true, completion: nil)
            return false
        }else{
            if let appDel = UIApplication.shared.delegate as? AppDelegate{
                appDel.tempData.number = numberTextField.text!
                let context = appDel.persistentContainer.viewContext
                do{
                    let results = try context.fetch(Friend.fetchRequest())
                    if let friend = results[appDel.tempData.id] as? Friend{
                        friend.name = appDel.tempData.name
                        friend.number = appDel.tempData.number
                        appDel.saveContext()
                        appDel.friendMatrix[appDel.tempData.id] = friend
                        appDel.tempData.name = ""
                        appDel.tempData.number = ""
                        appDel.tempData.id = -1
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
            let _ = navigationController?.popToRootViewController(animated: true)
            return true
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
