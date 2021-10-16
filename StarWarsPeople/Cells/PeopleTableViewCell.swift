//
//  PeopleTableViewCell.swift
//  StarWarsPeople
//
//  Created by Adonis Rumbwere on 14/10/2021.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {
    static let identifier = "PeopleTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    //Override the initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 20,
                                 y: 15,
                                 width: contentView.frame.size.width - 120,
                                 height: contentView.frame.size.height/2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: PeopleTableViewCellViewModel){
        nameLabel.text = viewModel.name
    }

}
