//
//  ArticlesDetailsTableViewCell.swift
//  Bornlogic-Test
//
//  Created by Erick Martins on 12/05/24.
//

import UIKit

class ArticlesDetailsTableViewCell: UITableViewCell {

    var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellImageView)
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 48),
            cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -48),
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            cellImageView.heightAnchor.constraint(equalToConstant: 200),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 16)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(content: String, imageUrl: String) {
        selectionStyle = .none
        descriptionLabel.text = "Description: \(content)"
        
        if let imageUrl = URL(string: imageUrl) {
            ImageLoader.loadImage(from: imageUrl) { (image) in
                DispatchQueue.main.async {
                    self.cellImageView.image = image
                }
            }
        } else {
            cellImageView.image = UIImage(named: "placeholder")
        }
    }
}
