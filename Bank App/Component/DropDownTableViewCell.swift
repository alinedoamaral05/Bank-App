//
//  OccupancyTableViewCell.swift
//  Bank App
//
//  Created by Aline do Amaral on 16/03/23.
//

import UIKit

class DropDownTableViewCell: UITableViewCell {

    private let occupancyLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupUI() {
        addSubview(occupancyLabel)
        
        NSLayoutConstraint.activate([
            occupancyLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            occupancyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
        self.backgroundColor = .red
    }
    
    func labelText(label: String) {
        occupancyLabel.text = label
    }

}
