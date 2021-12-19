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
    var addNoteViewModel = AddNoteViewModel()
    
    //var editNoteViewModel = Note(headText: "", detailText: "", favorites: true, attachImage: nil)
    var onSave: ((_ note: Note)-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editTitleTextField.text =  addNoteViewModel.note.headText
        editDetailTextField.text = addNoteViewModel.note.detailText
        editImageView.image = UIImage(contentsOfFile: "addNoteViewModel.note.attachImage")  //addNoteViewModel.note.attachImage
        //editImageView.image = addNoteViewModel.editNotesPic(url: URL)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.onSave?(addNoteViewModel.note)
       
        
    }
    
    @IBAction func editAttachImageButton(_ sender: Any) {
        print("Press Attach")
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        // self.view.endEditing(true)
        // self.onSave?(addNoteViewModel.note)
        //self.navigationController?.popViewController(animated: true)
    }
}
extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageURL = info[.imageURL] as? URL
        self.addNoteViewModel.editNotesPic(url: imageURL)   // self.addItemViewModel.editUserPic(url: imageURL)
        //self.editImageView.image =
        self.editImageView.image = UIImage(contentsOfFile: imageURL?.relativePath ?? "");//addNoteViewModel.note.attachImage
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
        addNoteViewModel.note.detailText = textView.text // addItemViewModel.good.description = textView.text
    }
}

extension EditViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        addNoteViewModel.note.headText = textField.text ?? ""  //addItemViewModel.good.name = textField.text ?? ""
    }
}
