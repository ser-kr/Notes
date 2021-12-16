//
//  EditTableViewController.swift
//  Notes
//
//  Created by SK on 06.12.2021.
//

import UIKit

class EditTableViewController: UITableViewController {

    @IBOutlet weak var editTitleTextField: UITextField!
    @IBOutlet weak var editDetailTextField: UITextView!
    @IBOutlet weak var editImageView: UIImageView!

    var addNotesModel = AddNoteViewModel()
    
    var onSave: ((_ note: Note)-> Void)?
    
    
    
    
    @IBAction func editAttachImageButton(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
       // editTitleTextField.text = addNotesModel.notes.headText
       // editDetailTextField.text = addNotesModel.notes.detailText
        

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        self.onSave?(addNotesModel.notes) //addItemViewModel.good)
        self.navigationController?.popViewController(animated: true)
       
           
        
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        if self.isMovingFromParent {
//            // Your code...
//        }
//    }
//
}
    
extension EditTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            editImageView.image = image
            //imageFeed.append(image)
        }
        self.editImageView.reloadInputViews() //.galleryCollectionViev.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

    
    
    
    
   
    
//    extension EditTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            let imageURL = info[.imageURL] as? URL
//           // self.addItemViewModel.editUserPic(url: imageURL)
//           // self.selectImageButton.setImage(UIImage(contentsOfFile: imageURL?.relativePath ?? ""), for: .normal)
//            picker.dismiss(animated: true, completion: nil)
//        }
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            picker.dismiss(animated: true, completion: nil)
//        }
//
//    }
//
//    extension AddItemViewController: UITextViewDelegate {
//        func textViewDidEndEditing(_ textView: UITextView) {
//            addItemViewModel.good.description = textView.text
//        }
//    }
//
//    extension AddItemViewController: UITextFieldDelegate {
//        func textFieldDidEndEditing(_ textField: UITextField) {
//
//            if textField == nameField {
//                addItemViewModel.good.name = textField.text ?? ""
//            } else if textField == quantityField {
//                addItemViewModel.good.quantity = Int(textField.text ?? "0") ?? 0
//            }
//
//
//        }
//}
