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
    
    override func viewDidAppear(_ animated: Bool) {
        do {
            try viewModel.saveNotes()
        } catch {
            print(error)
        }
    }
    @IBAction func mainSaveButton(_ sender: Any) {
        do {
            try viewModel.saveNotes()
        } catch {
            print(error)
        }
        print("save count \(viewModel.notes.count)")
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
 
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       let favorite = favoriteAction(at: indexPath)
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete, favorite])
    }
    func favoriteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Favorite") { (action, view, completion) in
            self.viewModel.notes[indexPath.row].favorites.toggle()
            completion(true)
        }
    return action
    }
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            do {
                try self.viewModel.deleteNote(index: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print(error)
            }
            completion(true)
        }
    return action
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addItem = segue.destination as? EditViewController {
            let addNoteViewModel = AddNoteViewModel()
            
            if let selected = tableView.indexPathForSelectedRow {
                let toEdit = viewModel.notes[selected.row]
                addNoteViewModel.note = toEdit
                
                addItem.onSave = { saved in
                    self.viewModel.notes[selected.row] = saved
                }
            } else {
                addItem.onSave = { note in
                    self.viewModel.addNote(note: note)
                    self.tableView.reloadData()
                }
            }
            addItem.addNoteViewModel = addNoteViewModel
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let editViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as? EditViewController  {
            editViewController.addNoteViewModel.note.headText = viewModel.notes[indexPath.row].headText
            editViewController.addNoteViewModel.note.detailText = viewModel.notes[indexPath.row].detailText
            print(viewModel.notes[indexPath.row].headText)
            self.navigationController?.pushViewController(editViewController, animated: true)
        }
    }
    
}
extension MainTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            do {
                try self.viewModel.updateNotes()
            } catch {
                
            }
        } else {
            self.viewModel.filter(text: searchText)
        }
        self.tableView.reloadData()
    }
}





//Swipe Delete
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            do {
//                try self.viewModel.deleteNote(index: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: .fade)
//            } catch {
//                print(error)
//            }
//        } else if editingStyle == .insert {
//        }
//    }
