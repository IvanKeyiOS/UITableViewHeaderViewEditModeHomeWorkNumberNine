//
//  ViewController.swift
//  UITableView
//
//  Created by Иван Курганский on 30/07/2023.
//

import UIKit

struct Person {
    let name: String
    let surname: String
}

final class PersonViewController: UITableViewController {
    
    private var data: [Character: [Person]] = [:] {
        didSet {
            tableView.reloadData()
        }
    }
    private var sectionTitle: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Conatacts 📱"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(AddAction))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = sectionTitle[section]
        let contacts = data[key]
        return contacts?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let key = sectionTitle[indexPath.section]
        guard let contact = data[key] else { return UITableViewCell() }
        let model = contact[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath) as! PersonTableViewCell
        
        let viewModel = makeViewModel(from: model)
        cell.configure(with: viewModel)
        return cell
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TableHeaderView()
        let title = sectionTitle[section]
        view.configure(with: TableHeaderViewModel(title: title))
        return view
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let key = sectionTitle[indexPath.row]
            data.removeValue(forKey: key)
        }
    }
}

private extension PersonViewController {
    
    func makeViewModel(from person: Person) -> PersonTableViewModel {
        let nameAttributed = NSAttributedString(string: person.name,
                                                attributes: [.font: UIFont.systemFont(ofSize: 17,weight: .bold)])
        let surnameAttributed = NSAttributedString(string: person.surname,
                                                   attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .regular)])
        let spaceAttributed = (NSAttributedString(string: " "))
        
        let title = NSMutableAttributedString(attributedString: nameAttributed)
        title.append(spaceAttributed)
        title.append(surnameAttributed)
        
        return PersonTableViewModel(title: title)
    }
    
    func fillContact(person: Person) {
        guard let firstLetter = person.name.first else { return }
        if var buffer = data[firstLetter] {
            buffer.append(person)
            data[firstLetter] = buffer
        } else {
            sectionTitle.append(firstLetter)
            data[firstLetter] = [person]
            
        }
    }
    @objc func AddAction() {
        let storyboard = UIStoryboard(name: "CreateNewContact", bundle: nil)
        guard let vc  = storyboard.instantiateViewController(withIdentifier: "CreateNewContactViewController") as? CreateNewContactViewController else { return }
        vc.saveCompletion = { [weak self] person in
            guard let self else { return }
            self.fillContact(person: person)
        }
        
        navigationController?.present(vc, animated: true)
    }
}
