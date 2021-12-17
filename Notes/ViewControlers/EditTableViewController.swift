//
//  EditTableViewController.swift
//  Notes
//
//  Created by SK on 06.12.2021.
//

import UIKit

class EditTableViewController: UITableViewController {

//    @IBOutlet weak var editTitleTextField: UITextField!
//    @IBOutlet weak var editDetailTextField: UITextView!
//    @IBOutlet weak var editImageView: UIImageView!

    var addNoteModel = AddNoteViewModel()
    
    var onSave: ((_ note: Note)-> Void)?
    
    
//    @IBAction func saveButton(_ sender: Any) {
//        //self.view.endEditing(true)
//        self.onSave?(addNoteModel.note)
//        print("saveButton")
//       // self.navigationController?.popViewController(animated: true)
//    }
    
    
    @IBAction func editAttachImageButton(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //editTitleTextField.text = addNoteModel.note.headText
       // editDetailTextField.text = addNoteModel.note.detailText
        

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        self.onSave?(addNoteModel.note) //addItemViewModel.good)
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

extension EditTableViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        addNoteModel.note.detailText = textView.text  //addItemViewModel.good.description = textView.text
    }
}

extension EditTableViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
            addNoteModel.note.headText = textField.text ?? "" // addItemViewModel.good.name = textField.text ?? ""
       
     
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
