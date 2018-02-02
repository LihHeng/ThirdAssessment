//
//  OwnersTableViewController.swift
//  ThirdAssessment-LihHeng
//
//  Created by Lih Heng Yew on 02/02/2018.
//  Copyright © 2018 Lih Heng Yew. All rights reserved.
//

import UIKit
import CoreData

class OwnersTableViewController: UITableViewController {

    var fetchResultController = NSFetchedResultsController<OwnerList>()
    
    let ownerMember : [String] = ["Han", "Erwin", "Mei", "Phillip", "Terrance", "Max", "KhangHui", "Marcus", "Melissa", "How", "Tung"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        checkFirstLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func checkFirstLoad() {
        if UserDefaults.standard.bool(forKey: "isNotFirstRun") {
            print("Teams were updated")
            fetchOwner()
        } else {
            print("Loading for first load")
            loadMember()
            fetchOwner()
            UserDefaults.standard.set(true, forKey: "isNotFirstRun")
        }
    }
    
    func loadMember() {
        
        for member in ownerMember {
            guard let insertTeam = NSEntityDescription.insertNewObject(forEntityName: "OwnerList", into: DataController.moc) as? OwnerList else { return }
            
            insertTeam.name = member
        }
        DataController.saveContext()
        tableView.reloadData()

    }
    func fetchOwner() {
        let request = NSFetchRequest<OwnerList>(entityName: "OwnerList")
        
        let sortName = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortName]
        
        fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: DataController.moc, sectionNameKeyPath: nil, cacheName: nil)
//        fetchResultController.delegate = self
        
        do {
            try fetchResultController.performFetch()
            tableView.reloadData()
        } catch {
            print("Error Fetching Student Data")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ownerCell", for: indexPath)
        let currentStudent = fetchResultController.object(at: indexPath)
        cell.textLabel?.text = "\(currentStudent.name ?? "")"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let vc = sb.instantiateViewController(withIdentifier: "PropertiesTableViewController") as? PropertiesTableViewController {
            vc.selectedOwner = fetchResultController.object(at: indexPath)
            
            if tableView.allowsMultipleSelectionDuringEditing == false {
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }



    // MARK: - Table view data source



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

}


