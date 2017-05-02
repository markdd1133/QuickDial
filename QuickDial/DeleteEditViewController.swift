//
//  DeleteEditViewController.swift
//  QuickDial
//
//  Created by Sheng Chi Chen on 2017/4/26.
//  Copyright © 2017年 Sheng Chi Chen. All rights reserved.
//

import UIKit

class DeleteEditViewController: UIViewController {
    
    @IBAction func backToMenu(_ sender: UIButton) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteEntry(_ sender: UIButton) {
        if let appDel = UIApplication.shared.delegate as? AppDelegate{
            let context = appDel.persistentContainer.viewContext
            do{
                let results = try context.fetch(Friend.fetchRequest())
                if let friend = results[appDel.tempData.id] as? Friend{
                    friend.name = ""
                    friend.number = ""
                    appDel.saveContext()
                    appDel.friendMatrix[appDel.tempData.id] = friend
                }
            }catch{
                print(error.localizedDescription)
            }
        }
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editEntry(_ sender: UIButton) {
        if let appDel = UIApplication.shared.delegate as? AppDelegate{
            if let name = appDel.friendMatrix[appDel.tempData.id].name,
                let number = appDel.friendMatrix[appDel.tempData.id].number{
                appDel.tempData.name = name
                appDel.tempData.number = number
            }
        }
        performSegue(withIdentifier: "edit", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit"{
            let dvc = segue.destination as? SettingNameViewController
            dvc?.backgroundColorInfo = view.backgroundColor
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    var backgroundColorInfo:UIColor?{
        didSet{
            if backgroundColorInfo != nil{
                view.backgroundColor = backgroundColorInfo!
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
