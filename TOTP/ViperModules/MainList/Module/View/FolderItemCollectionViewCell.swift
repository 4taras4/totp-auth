//
//  FolderItemCollectionViewCell.swift
//  TOTP
//
//  Created by Taras Markevych on 15.02.2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//

import UIKit

class FolderItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .systemBackground
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.masksToBounds = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setup(item: Folder) {
        nameLabel.text = item.name
    }
}
