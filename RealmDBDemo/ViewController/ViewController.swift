//
//  ViewController.swift
//  RealmSwift
//
//  Created by Riccardo Rizzo on 12/07/17.
//  Copyright © 2017 Riccardo Rizzo. All rights reserved.
//

import UIKit
 
class ViewController: UIViewController {

    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var txtCount: UIBarButtonItem!
    
    @IBAction func addButtonClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "secondView") as! secondViewController
        
        vc.iSAddTapped = true
        vc.currentItem = nil
        self.navigationController?.pushViewController(vc, animated: true)
      //  self.present(vc, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        // Do any additional setup after loading the view, typically from a nib.        
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
        
    
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.txtCount.title = "\(DBManager.sharedInstance.getDataFromDB().count)"
        UIApplication.shared.applicationIconBadgeNumber   = DBManager.sharedInstance.getDataFromDB().count
        return DBManager.sharedInstance.getDataFromDB().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as UITableViewCell
        let index = Int(indexPath.row)
        let item = DBManager.sharedInstance.getDataFromDB()[index] as Item
        print("🤧🤧🤧 TableView Cell Index==> \(index)  🤩 Id==> \(item.ID)  👻 Text==> \(item.textString)")
        cell.textLabel?.text = item.textString        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if( indexPath.row > -1) {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "secondView") as! secondViewController
            
            let index = Int(indexPath.row)
            let item = DBManager.sharedInstance.getDataFromDB()[index] as Item
            
            vc.currentItem = item
            vc.iSAddTapped = false
            self.navigationController?.pushViewController(vc, animated: true)
            //self.present(vc, animated: true, completion: nil)
        }
    }
}

