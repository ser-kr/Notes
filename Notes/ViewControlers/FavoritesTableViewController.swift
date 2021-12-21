//
//  FavoritesTableViewController.swift
//  Notes
//
//  Created by SK on 06.12.2021.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    var viewModel: FaviritesViewModel = FaviritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.reloadInputViews()
        self.viewModel.updateModel()
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.shownNotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath)
        if viewModel.shownNotes[indexPath.row].favorites == true {
            cell.textLabel?.text = viewModel.shownNotes[indexPath.row].headText
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let unliked = unlikeAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [unliked])
    }
    
    func unlikeAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.viewModel.deleteFromFavorites(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
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
