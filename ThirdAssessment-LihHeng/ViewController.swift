//
//  ViewController.swift
//  ThirdAssessment-LihHeng
//
//  Created by Lih Heng Yew on 02/02/2018.
//  Copyright © 2018 Lih Heng Yew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var selectedProperty : PropertyList?
    var selectedOwner : OwnerList?
    var addMode = true
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
        doneButton()
        
        if let property = selectedProperty {
            addMode = false
            nameTextField.text = property.name
            locationTextField.text = property.location
            priceTextField.text = property.price
        }
        
//        if addMode {
//            addButton.setTitle("ADD", for: .normal)
//            //hide rightbarbutton
//            navigationItem.rightBarButtonItem = nil
//        } else {
//            addButton.setTitle("UPDATE", for: .normal)
//        }
        
    }

    func doneButton() {
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped(sender:)))
        navigationItem.rightBarButtonItems = [done]
    }
    
    @objc func doneButtonTapped(sender: UIBarButtonItem) {
        if let name = nameTextField.text,
            let location = locationTextField.text,
            let price = priceTextField.text,
            name != "",
            location != "",
            price != "" {
            
            if addMode {
                createProperty(name: name, location: location, price: price)
            } else {
                updateProperty(name: name, location: location, price: price)
            }
            
            //after save, go back to first page
            navigationController?.popViewController(animated: true)
        }
    }
    
    func updateProperty(name: String, location: String, price: String) {
        guard let property = selectedProperty
            else{return}
        property.name = name
        property.location = location
        property.price = price
        
        DataController.saveContext()
    }
    
    func createProperty(name: String, location: String, price: String) {
        
        let newProperty = PropertyList(entity: PropertyList.entity(), insertInto: DataController.moc)
        newProperty.name = name
        newProperty.location = location
        newProperty.price = price
        
        selectedOwner?.addToHasProperty(newProperty)
        
        
        //terminate and save
        DataController.saveContext()
    }



}

