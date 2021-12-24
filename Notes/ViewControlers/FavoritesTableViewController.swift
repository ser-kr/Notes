//
//  FavoritesTableViewController.swift
//  Notes
//
//  Created by SK on 06.12.2021.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    var viewModel: NotesViewModel = NotesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try viewModel.updateNotes()
        } catch {
            print(error)
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        view.reloadInputViews()
        do {
            try viewModel.updateNotes()
        } catch {
            print(error)
        }
        self.tableView.reloadData()
        print("Favorites didappear \(viewModel.notes.count)")
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath)
        if viewModel.notes[indexPath.row].favorites == true {
        cell.textLabel?.text = viewModel.notes[indexPath.row].headText
            //favoriteCell.tLabel.text = "asdasdasd"
            //favoriteCell.note = viewModel.notes[indexPath.row]
           // notesCell.note = viewModel.notes[indexPath.row] //viewModel.goods[indexPath.row]
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
