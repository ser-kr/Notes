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
    var addNoteViewModel = EditNoteViewModel()
    
    var onSave: ((_ note: Note)-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTitleTextField.text =  addNoteViewModel.note.headText
        editDetailTextField.text = addNoteViewModel.note.detailText
        editImageView.image = UIImage(contentsOfFile: addNoteViewModel.note.attachImage?.relativePath ?? "")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.onSave?(addNoteViewModel.note)
        self.view.endEditing(true)
    }
    
    @IBAction func editAttachImageButton(_ sender: Any) {
        print("Press Attach")
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
}
extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageURL = info[.imageURL] as? URL
        self.addNoteViewModel.note.attachImage = imageURL
        self.editImageView.image = UIImage(contentsOfFile: imageURL?.relativePath ?? "")
        
        // self.editImageView   //.setImage(UIImage(contentsOfFile: imageURL?.relativePath ?? ""), for: .normal)
        // self.selectImageButton.setImage(UIImage(contentsOfFile: imageURL?.relativePath ?? ""), for: .normal)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension EditViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        
        addNoteViewModel.note.detailText = textView.text
    }
}

//extension EditViewController: UITextFieldDelegate {
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        //onSave?(textField.text
//        addNoteViewModel.note.headText = textField.text ?? ""
//    }
//}
extension EditViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        //onSave?(addNoteViewModel.note)
        addNoteViewModel.note.headText = textField.text ?? ""
    }
    
}
