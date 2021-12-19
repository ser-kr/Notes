//
//  FavoritesTableViewController.swift
//  Notes
//
//  Created by SK on 06.12.2021.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    var viewModel: MainViewModel = MainViewModel()
    
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let favoritesCount = viewModel.notes[indexPath.row]
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
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       let unliked = unlikeAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [unliked])
    }
    func unlikeAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.viewModel.notes[indexPath.row].favorites.toggle()
           // self.tableView.deleteRows(at: [indexPath], with: .fade)
           // self.tableView.reloadData()
            
            completion(true)
        }
    return action
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let editViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as? EditViewController  {
            editViewController.addNoteViewModel.note.headText = viewModel.notes[indexPath.row].headText
            editViewController.addNoteViewModel.note.detailText = viewModel.notes[indexPath.row].detailText
           // editViewController.addNoteViewModel.note.attachImage
            print(viewModel.notes[indexPath.row].headText)
            self.navigationController?.pushViewController(editViewController, animated: true)
        }
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let addItem = segue.destination as? EditViewController {
//            let addNoteViewModel = AddNoteViewModel()
//
//            if let selected = tableView.indexPathForSelectedRow {
//                let toEdit = viewModel.notes[selected.row]
//                addNoteViewModel.note = toEdit
//
//                addItem.onSave = { saved in
//                    self.viewModel.notes[selected.row] = saved
//                }
//            } else {
//                addItem.onSave = { note in
//                    self.viewModel.addNote(note: note)
//                    self.tableView.reloadData()
//                }
//            }
//            addItem.addNoteViewModel = addNoteViewModel
//        }
//    }
    
}
