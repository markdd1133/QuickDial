//
//  ViewController.swift
//  QuickDial
//
//  Created by Sheng Chi Chen on 2017/4/26.
//  Copyright © 2017年 Sheng Chi Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: BigLabelButton!
    @IBOutlet weak var button2: BigLabelButton!
    @IBOutlet weak var button3: BigLabelButton!
    @IBOutlet weak var button4: BigLabelButton!
    @IBOutlet weak var button5: BigLabelButton!
    var buttonArray:[BigLabelButton]?
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    @IBAction func dial(_ sender: BigLabelButton) {
        let appDel = UIApplication.shared.delegate as? AppDelegate
        if let name = appDel?.friendMatrix[sender.tag].name,
            let number = appDel?.friendMatrix[sender.tag].number{
            if name != ""{
                if let url = URL(string: "tel://" + number){
                    if UIApplication.shared.canOpenURL(url){
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonArray = [button1,button2,button3,button4,button5]
        
        if buttonArray != nil{
            for button in buttonArray! {
                let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPress(sender:)))
                lpgr.minimumPressDuration = 1.5
                button.addGestureRecognizer(lpgr)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else{ return }
        if buttonArray != nil{
            for i in 0...4 {
                buttonArray![i].bigLabel.text = appDel.friendMatrix[i].name
            }
            var isEmpty = true
            for friend in appDel.friendMatrix {
                if let okName = friend.name{
                    if okName != ""{
                        isEmpty = false
                    }
                }
            }
            if isEmpty == true{
                buttonArray![1].bigLabel.text = "Long Press"
            }
        }
        appDel.tempData.name = ""
        appDel.tempData.number = ""
    }
    
    func longPress(sender:UILongPressGestureRecognizer){
        if sender.state == .began{
            print("Button:\(sender.view?.tag)")
            if let tagNumber = sender.view?.tag{
                let appDel = UIApplication.shared.delegate as? AppDelegate
                appDel?.tempData.id = tagNumber
                if let name = appDel?.friendMatrix[tagNumber].name{
                    if name == ""{
                        performSegue(withIdentifier: "showSettingName", sender: sender.view?.backgroundColor)
                    }else{
                        performSegue(withIdentifier: "showDeleteEdit", sender: sender.view?.backgroundColor)
                    }
                }
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSettingName"{
            let dvc = segue.destination as? SettingNameViewController
            dvc?.backgroundColorInfo = sender as? UIColor
        }else if segue.identifier == "showDeleteEdit"{
            let dvc = segue.destination as? DeleteEditViewController
            dvc?.backgroundColorInfo = sender as? UIColor
        }
    }
    
    override func viewDidLayoutSubviews() {
        let viewWidth = view.frame.size.width
        let viewHeight = view.frame.size.height
        if let okArray = buttonArray{
            for button in okArray {
                button.bigLabel.frame = CGRect(x: 28, y: 0, width: viewWidth - 28, height: viewHeight / 5)
                button.bigLabel.font = UIFont(name: "Arial-BoldMT", size: viewHeight * 0.075)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

