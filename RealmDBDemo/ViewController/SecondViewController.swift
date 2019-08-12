//
//  secondViewController.swift
//  RealmSwift
//
//  Created by Shubham on 12/07/17.
//  Copyright © 2017 Shubham. All rights reserved.
//

import UIKit

class secondViewController: UIViewController {

    
    var currentItem:Item?
    var iSAddTapped:Bool?
//    var iSSave:Bool?
    
    @IBOutlet var txtNote: UITextField!
    @IBOutlet var btnUpdate: UIButton!
    @IBOutlet var btnSave: UIButton!
     @IBOutlet var imgPic: UIImageView!
    
    @IBAction func actionPickImage(_ sender: UIButton) {
        AttachmentHandler.shared.showAttachmentActionSheet(vc: self)
        AttachmentHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            print("👏🏻",image)
            self.imgPic.image = image
        }
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        let item = Item()
        
        if(currentItem == nil) {
            item.ID = DBManager.sharedInstance.getDataFromDB().count
        }
        let newImageData = imgPic.image?.jpegData(compressionQuality: 0.4)
        item.picture = newImageData
        item.textString = txtNote.text!
        DBManager.sharedInstance.addData(object: item)
        self.navigationController?.popViewController(animated: true)
      //  self.dismiss(animated: true) { }
        
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        if let item = currentItem {
            DBManager.sharedInstance.deleteFromDb(object: item)
            self.navigationController?.popViewController(animated: true)
          //  self.dismiss(animated: true) { }
        }
        
    }
    
     @IBAction func updateButtonClicked(_ sender: Any) {
         if let item = currentItem {
            let newImageData = imgPic.image?.jpegData(compressionQuality: 0.4)
            DBManager.sharedInstance.updateToDb(object: item, id: item.ID, dataToUpdate: txtNote.text!, imgToUpload: newImageData!)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let item = currentItem {
            txtNote.text = item.textString
            if let bla3 = currentItem?.picture {
                let cellImage =  UIImage(data: bla3 as Data)
                self.imgPic?.image = cellImage
            }
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if iSAddTapped == true{
            btnUpdate.isHidden = true
            btnSave.isHidden = false
        } else if iSAddTapped == false{
            btnUpdate.isHidden = false
            btnSave.isHidden = true
        } 
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
