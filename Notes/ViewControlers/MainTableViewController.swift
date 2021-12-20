//
//  MainTableViewController.swift
//  Notes
//
//  Created by SK on 06.12.2021.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var viewModel: MainViewModel = MainViewModel()
    
    @IBAction func addNoteButton(_ sender: Any) {
        let newNote = Note()
        viewModel.addNote(note: newNote)
        if let editViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as? EditViewController {
            editViewController.editNoteViewModel.note = newNote
            editViewController.onSave = {
                try! self.viewModel.saveNotes()
                self.tableView.reloadData()
            }
            self.navigationController?.pushViewController(editViewController, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.shownNotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath)
        if let notesCell = cell as? MainTableViewCell {
            notesCell.note = viewModel.shownNotes[indexPath.row]
        }
        return cell
    }
 
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favorite = favoriteAction(at: indexPath)
        favorite.backgroundColor = .green
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete, favorite])
    }
    
    func favoriteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Favorite") { (action, view, completion) in
            self.viewModel.togleFavorite(index: indexPath.row)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let editViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as? EditViewController  {
            editViewController.editNoteViewModel.note = viewModel.shownNotes[indexPath.row]
            editViewController.onSave = {
                try! self.viewModel.saveNotes()
                self.tableView.reloadData()
            }
            self.navigationController?.pushViewController(editViewController, animated: true)
        } else {
            print("Error EditViewController")
        }
    }
}
extension MainTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.filter(text: searchText)
        self.tableView.reloadData()
    }
    
}



//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let addItem = segue.destination as? EditViewController {
//
//            let addNoteViewModel = EditNoteViewModel()
//
//            if let selected = tableView.indexPathForSelectedRow {
//                let toEdit = viewModel.shownNotes[selected.row]
//                addNoteViewModel.note = toEdit
//                addItem.onSave = { saved in
//
//                    self.viewModel.editNote(index: selected.row, newValue: saved)
//                   // self.viewModel.editUserItem(indexPath: selected, newValue: value)
//                     //self.viewModel.shownNotes[selected.row] = saved
//                    //self.viewModel.shownNotes[selected.row] = saved
//                    //try! self.viewModel.notesService.saveNotes()
//                    self.tableView.reloadData()
//                    //TODO: Save here
//                }
//            } else {
//                addItem.onSave = { note in
//                    self.viewModel.addNote(note: note)
//                    self.tableView.reloadData()
//                }
//            }
//            addItem.editNoteViewModel = addNoteViewModel
//        }
//    }
