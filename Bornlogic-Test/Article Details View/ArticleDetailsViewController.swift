//
//  ArticleDetailsViewController.swift
//  Bornlogic-Test
//
//  Created by Erick Martins on 11/05/24.
//

import UIKit

class ArticleDetailsViewController: UIViewController {
    
    // Other properties, outlets, etc.
    var article: Articles
    
    // Label to display the article ID
    let articleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // Custom initializer to receive article ID
    init(article: Articles) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the label to the view
        view.addSubview(articleLabel)
        
        // Configure label
        articleLabel.text = "Article ID: \(article.description ?? "")"
        
        // Set label constraints
        NSLayoutConstraint.activate([
            articleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            articleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            articleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            articleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
}

