//
//  ItemDetailsViewController.swift
//  DreamLister
//
//  Created by Per Kristensen on 10/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleTextField: CustomTextField!
    @IBOutlet weak var priceTextField: CustomTextField!
    @IBOutlet weak var detailsTextField: CustomTextField!
    
    var stores = [Store]()
    var itemToEdit: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        storePicker.dataSource = self
        storePicker.delegate = self
        
//        let store1 = Store(context: context)
//        store1.name = "Test1"
//        let store2 = Store(context: context)
//        store2.name = "Test"
//        let store3 = Store(context: context)
//        store3.name = "Test"
//        let store4 = Store(context: context)
//        store4.name = "Test"
//        let store5 = Store(context: context)
//        store5.name = "Test"
//        let store6 = Store(context: context)
//        store6.name = "Test"
//        let store7 = Store(context: context)
//        store7.name = "Test"
        
//        ad.saveContext()
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
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
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
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
            
            if let store = item.toStore {
                for (index, s) in stores.enumerated() {
                    if store.name == s.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                    }
                }
            }
        }
        
    }
}
