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
    var itemTypes = [ItemType]()
    var pickerData = [Any]()
    
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
//        
//        generateTestStores()
//        generateTestItemTypes()
        getStores()
        getItemTypes()
        storePicker.reloadAllComponents()
        
        if itemToEdit != nil {
            loadItemData()
        }
    }
    
    func generateTestStores() {
        let store1 = Store(context: context)
        store1.name = "Store 1"
        let store2 = Store(context: context)
        store2.name = "Store 2"
        let store3 = Store(context: context)
        store3.name = "Store 3"
        let store4 = Store(context: context)
        store4.name = "Store 4"
        let store5 = Store(context: context)
        store5.name = "Store 5"
        let store6 = Store(context: context)
        store6.name = "Store 6"
        let store7 = Store(context: context)
        store7.name = "Store 7"
        
        ad.saveContext()
    }
    
    func generateTestItemTypes() {
        let type1 = ItemType(context: context)
        type1.type = "Item type 1"
        let type2 = ItemType(context: context)
        type2.type = "Item type 2"
        let type3 = ItemType(context: context)
        type3.type = "Item type 3"
        let type4 = ItemType(context: context)
        type4.type = "Item type 4"
        let type5 = ItemType(context: context)
        type5.type = "Item type 5"
        let type6 = ItemType(context: context)
        type6.type = "Item type 6"
        let type7 = ItemType(context: context)
        type7.type = "Item type 7"
        let type8 = ItemType(context: context)
        type8.type = "Item type 8"
        
        ad.saveContext()
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let test = pickerData[component]
        if let stores = test as? [Store] {
            return stores[row].name
        }
        
        if let itemTypes = test as? [ItemType] {
            return itemTypes[row].type
        }
        
        return ""
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let dataArray = pickerData[component] as? [Any] {
            return dataArray.count
        }
        return 0
    }
    
    func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [nameSort]

        do {
            stores = try context.fetch(fetchRequest)
            pickerData.append(stores)
        } catch {
            // TODO: Handle the error
        }
    }
    
    func getItemTypes() {
        let fetchRequest: NSFetchRequest<ItemType> = ItemType.fetchRequest()
        let typeSort = NSSortDescriptor(key: "type", ascending: true)
        fetchRequest.sortDescriptors = [typeSort]
        
        do {
            itemTypes = try context.fetch(fetchRequest)
            pickerData.append(itemTypes)
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
        item.toItemType = itemTypes[storePicker.selectedRow(inComponent: 1)]
        
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
            
            if let itemType = item.toItemType {
                for (index, it) in itemTypes.enumerated() {
                    if itemType.type == it.type {
                        storePicker.selectRow(index, inComponent: 1, animated: false)
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
