//
//  EditViewController.swift
//  Notes
//
//  Created by SK on 17.12.2021.
//

import UIKit

class EditViewController: UIViewController {
    @IBOutlet weak var editTitleTextField: UITextField!
    @IBOutlet weak var editDetailTextField: UITextView!
    @IBOutlet weak var editImageView: UIImageView!
    
    var editNoteViewModel = EditNoteViewModel()
    var currentImageURL: URL? = nil
    var onSave: (()-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        editTitleTextField.text =  editNoteViewModel.note.headText
        editDetailTextField.text = editNoteViewModel.note.detailText
        editImageView.image = UIImage(contentsOfFile: editNoteViewModel.note.attachImage?.relativePath ?? "")
        currentImageURL = editNoteViewModel.note.attachImage
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        editNoteViewModel.note.headText = editTitleTextField.text ?? ""
        editNoteViewModel.note.detailText = editDetailTextField.text
        editNoteViewModel.note.attachImage = currentImageURL
        self.onSave?()
        //TODO: What is it?
        self.view.endEditing(true)
    }
    
    @IBAction func editAttachImageButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
}
extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        currentImageURL = info[.imageURL] as? URL
        self.editImageView.image = UIImage(contentsOfFile: currentImageURL?.relativePath ?? "")
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

//extension EditViewController: UITextViewDelegate {
//    func textViewDidEndEditing(_ textView: UITextView) {
//
//        editNoteViewModel.note.detailText = textView.text
//    }
//}
//
//extension EditViewController: UITextFieldDelegate {
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        //onSave?(textField.text
//        editNoteViewModel.note.headText = textField.text ?? ""
//    }
//}
