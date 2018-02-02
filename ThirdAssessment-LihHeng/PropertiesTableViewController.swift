//
//  PropertiesTableViewController.swift
//  ThirdAssessment-LihHeng
//
//  Created by Lih Heng Yew on 02/02/2018.
//  Copyright © 2018 Lih Heng Yew. All rights reserved.
//

import UIKit
import CoreData

class PropertiesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var selectedOwner : OwnerList?
    var fetchResultController = NSFetchedResultsController<PropertyList>()
    
    func addButton() {
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(sender:)))
        navigationItem.rightBarButtonItems = [add]
    }
    @objc func addButtonTapped(sender: UIBarButtonItem) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController else {return}
        vc.selectedOwner = selectedOwner

        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        addButton()
//        fetchProperty()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
//    func fetchProperty() {
//        let request = NSFetchRequest<PropertyList>(entityName: "PropertyList")
//
//        let sortName = NSSortDescriptor(key: "name", ascending: true)
//        request.sortDescriptors = [sortName]
//
//        fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: DataController.moc, sectionNameKeyPath: nil, cacheName: nil)
//            fetchResultController.delegate = self
//
//        do {
//            try fetchResultController.performFetch()
//            tableView.reloadData()
//        } catch {
//            print("Error Fetching Student Data")
//        }
//    }

  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return fetchResultController.fetchedObjects?.count ?? 0
        return selectedOwner?.hasProperty?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "propertyCell", for: indexPath)
        
        if let properties = selectedOwner?.hasProperty?.allObjects as? [PropertyList] {
            let currentProperty = properties[indexPath.row]
//            let currentProperty = fetchResultController.object(at: indexPath)
            cell.textLabel?.text = currentProperty.name
            cell.detailTextLabel?.text = "\(currentProperty.location ?? ""), \(currentProperty.price ?? "")"
//            cell.textLabel?.text = currentProperty.hasOwner?.name
//            cell.detailTextLabel?.text = currentProperty.hasOwner.
        }
        
//        selectedOwner?.addToHasProperty(<#T##value: PropertyList##PropertyList#>)
        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let vc = sb.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            vc.selectedProperty = fetchResultController.object(at: indexPath)
            vc.selectedOwner = selectedOwner
            
//            if tableView.allowsMultipleSelectionDuringEditing == false {
                navigationController?.pushViewController(vc, animated: true)
//            }
        }
    }
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.beginUpdates()
//        print("will change")
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        print("DidChange")
//        print("old : ", indexPath)
//        print("new : ", newIndexPath)
//
//        switch type {
//        case .insert:
//            print("Insert")
//            if let new = newIndexPath {
//                tableView.insertRows(at: [new], with: .right)
//            }
//        case .update:
//            print("Update")
//            if let old = indexPath {
//                tableView.reloadRows(at: [old], with: .middle)
//            }
//        case .move:
//            print("Move")
//            if let old = indexPath,
//                let new = newIndexPath {
//                tableView.performBatchUpdates({tableView.moveRow(at: old, to: new)}, completion: { (complete) in
//                    self.tableView.reloadRows(at: [new], with: .none)
//                })
//            }
//        case .delete:
//            print("Delete")
//            if let old = indexPath {
//                tableView.deleteRows(at: [old], with: .left)
//            }
//        }
//    }
//
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.endUpdates()
//        print("finished cahnge")
//    }
    
}


