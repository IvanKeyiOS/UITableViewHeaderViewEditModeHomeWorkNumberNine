//
//  CreateNewContactViewController.swift
//  UITableView
//
//  Created by Иван Курганский on 31/07/2023.
//

import UIKit

final class CreateNewContactViewController: UIViewController {
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    
    var saveCompletion: ((Person) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension CreateNewContactViewController {
    
    private func dismiss() {
        dismiss(animated: true)
    }
    
    @IBAction private func cancelAction() {
        dismiss()
    }
    
    @IBAction private func saveAction() {
        let person = Person(name: nameTextField.text ?? "", surname: surnameTextField.text ?? "")
        saveCompletion?(person)
        dismiss()
    }
}
