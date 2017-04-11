//
//  ItemDetailsViewController.swift
//  DreamLister
//
//  Created by Per Kristensen on 10/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleTextField: CustomTextField!
    @IBOutlet weak var priceTextField: CustomTextField!
    @IBOutlet weak var detailsTextField: CustomTextField!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        storePicker.dataSource = self
        storePicker.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        // generateTestStores()
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
    }
    
    func generateTestStores() {
        let store1 = Store(context: context)
        store1.name = "Test1"
        let store2 = Store(context: context)
        store2.name = "Test"
        let store3 = Store(context: context)
        store3.name = "Test"
        let store4 = Store(context: context)
        store4.name = "Test"
        let store5 = Store(context: context)
        store5.name = "Test"
        let store6 = Store(context: context)
        store6.name = "Test"
        let store7 = Store(context: context)
        store7.name = "Test"
        
        ad.saveContext()
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            stores = try context.fetch(fetchRequest)
            storePicker.reloadAllComponents()
        } catch {
            // TODO: Handle the error
        }
    }
    @IBAction func savePressed(_ sender: UIButton) {
        var item: Item!
        
        let picture = Image(context: context)
        picture.image = thumbImageView.image
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        item.created = NSDate()
        item.toImage = picture
        
        if let title = titleTextField.text {
            item.title = title
        }
        
        if let price = priceTextField.text {
            item.price = (price as NSString).doubleValue
        }
        
        if let details = detailsTextField.text {
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
       
        _ = navigationController?.popViewController(animated: true)
    }
    
    func loadItemData() {
        if let item = itemToEdit {
            titleTextField.text = item.title
            priceTextField.text = "\(item.price)"
            detailsTextField.text = item.details
            thumbImageView.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                for (index, s) in stores.enumerated() {
                    if store.name == s.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                    }
                }
            }
        }
        
    }
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        if let itemToDelete = itemToEdit {
            context.delete(itemToDelete)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func addImagePressed(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbImageView.image = image
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
