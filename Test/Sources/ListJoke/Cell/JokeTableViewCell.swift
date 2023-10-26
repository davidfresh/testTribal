//
//  JokesTableViewCell.swift
//  Test
//
//  Created by David on 26/10/23.
//

import Foundation
import UIKit

final class JokesTableViewCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 12)
        return titleLabel
    }()
    
    private var joke: JokeViewModel?
    
    static let reuseIdentifier = String(describing: self)
    
    static func registerCellForTable(_ tableView: UITableView) {
        tableView.register(JokesTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(joke: JokeViewModel) {
        self.joke = joke
        setupCell()
    }
}

private extension JokesTableViewCell {
    func createViews() {
        selectionStyle = .gray
        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        addConstraintsForViews()
    }
    
    func addConstraintsForViews() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10) 
        ])
    }
    
    func setupCell() {
        guard let viewModel = joke else {
            titleLabel.isHidden = true
            return
        }
        titleLabel.text = viewModel.value
    }
}
