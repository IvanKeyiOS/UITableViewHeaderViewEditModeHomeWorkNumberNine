//
//  TableViewHeader.swift
//  UITableView
//
//  Created by Иван Курганский on 02/08/2023.
//

import UIKit
struct TableHeaderViewModel {
    let title: Character
}

final class TableHeaderView: UIView {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: TableHeaderViewModel) {
        titleLabel.text = String(viewModel.title)
    }
    
    private func setupLabel() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
                    titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                    titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                    titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                    titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)])
    }
}
