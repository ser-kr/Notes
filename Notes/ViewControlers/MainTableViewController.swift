//
//  MainTableViewController.swift
//  Notes
//
//  Created by SK on 06.12.2021.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var viewModel: NotesViewModel = NotesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try viewModel.updateNotes()
        } catch {
            print(error)
        }
        print("viewDidLoad count \(viewModel.notes.count)")
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//       // view.reloadInputViews()
//        print(viewModel.notes.count)
//        do {
//            //try viewModel.saveNotes()
//            try viewModel.saveNotes()
//            try viewModel.updateNotes()
//
//        } catch {
//            print(error)
//        }
//        print("viewDidApear count \(viewModel.notes.count)")
//    }

    
    
    @IBAction func mainSaveButton(_ sender: Any) {
        do {
            try viewModel.saveNotes()
        } catch {
            print(error)
        }
        
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return viewModel.notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath)
        
        if let notesCell = cell as? MainTableViewCell {
            notesCell.note = viewModel.notes[indexPath.row] //viewModel.goods[indexPath.row]
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
                   do {
                       try self.viewModel.deleteGood(index: indexPath.row)
                       tableView.deleteRows(at: [indexPath], with: .fade)
                   } catch {
                       print(error)
                   }
               } else if editingStyle == .insert {
    }
    }

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let addItem = segue.destination as? EditTableViewController {
//
//            let addNoteViewModel = AddNoteViewModel()
//
//            if let selected = tableView.indexPathForSelectedRow {
//                let toEdit = viewModel.notes[selected.row]
//                addNoteViewModel.note = toEdit
//
//                addItem.onSave = { saved in
//                    self.viewModel.notes[selected.row] = saved
//                }
//
//            } else {
//                addItem.onSave = { note in
//                    self.viewModel.addNote(note: note)
//                    self.tableView.reloadData()
//                }
//            }
//
//            addItem.addNoteModel = addNoteViewModel
//
//        }
//    }

    

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
