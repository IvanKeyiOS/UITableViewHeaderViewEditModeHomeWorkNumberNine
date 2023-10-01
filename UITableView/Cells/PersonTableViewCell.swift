//
//  PersonTableViewCell.swift
//  UITableView
//
//  Created by Иван Курганский on 30/07/2023.
//

import UIKit

struct PersonTableViewModel {
    let title: NSAttributedString
}

final class PersonTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var personLabel: UILabel!
    
    func configure(with viewModel: PersonTableViewModel) {
        personLabel.attributedText = viewModel.title
    }
}
    




//struct PersonTableViewModel {
//    let title: NSAttributedString
//}
//
//final class PersonTableViewCell: UITableViewCell {
//    
//    @IBOutlet private weak var personLabel: UILabel!
//    
//    func configure(with viewModel: PersonTableViewModel) {
//        personLabel.attributedText = viewModel.title
//        
//        personLabel.layer.borderColor
//    }
//}
