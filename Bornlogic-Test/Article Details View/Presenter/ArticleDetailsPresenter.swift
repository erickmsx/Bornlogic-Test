//
//  ArticleDetailsPresenter.swift
//  Bornlogic-Test
//
//  Created by Erick Martins on 12/05/24.
//

import Foundation

protocol ArticleDetailsProtocol{
    func numberOfItems() -> Int
    func item(at index: Int) -> Articles?
    func didSelectItem(at index: Int)
}

class ArticleDetailsPresenter: ArticleDetailsProtocol{
    
    private var homeModel: HomeModel?
    
    //MARK: TABLE VIEW
    func numberOfItems() -> Int {
        return homeModel?.articles.count ?? 0
    }
    
    func item(at index: Int) -> Articles? {
        return homeModel?.articles[index]
    }
    
    func didSelectItem(at index: Int) {
        
    }
    
}
