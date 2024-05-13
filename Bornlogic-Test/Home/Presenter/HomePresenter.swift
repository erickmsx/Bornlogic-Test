//
//  HomePresenter.swift
//  Bornlogic-Test
//
//  Created by Erick Martins on 11/05/24.
//

import Foundation
import UIKit

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func articlesFetched(result: Result<HomeModel, Error>, publishDate: String)
    
    //TableView funcs
    func numberOfItems() -> Int
    func item(at index: Int) -> Articles?
    func didSelectItem(at index: Int)
}

class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeViewProtocol?
    var router: HomeRouterProtocol?
    var homeModel: HomeModel?
    var interactor: HomeInteractorProtocol
    var publishDate: String = ""
    
    init(interactor: HomeInteractorProtocol) {
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        interactor.fetchArticles()
    }
    
    //MARK: Requests
    func articlesFetched(result: Result<HomeModel, Error>, publishDate: String) {
        switch result{
        case .success(let data):
            DispatchQueue.main.async{
                self.publishDate = publishDate
                self.homeModel = data
                self.view?.reloadTableView()
            }
        case .failure(let error):
            print("\(error)")
        }
    }
    
    func articlesFetchedMock(){
        let homeModel = interactor.fetchArticlesMock()
        self.homeModel = homeModel
    }
    
    //MARK: TableView
    func numberOfItems() -> Int {
        return homeModel?.articles.count ?? 0
    }
    
    func item(at index: Int) -> Articles? {
        return homeModel?.articles[index]
    }
    
    func didSelectItem(at index: Int) {
        if let article = homeModel?.articles[index] {
            router?.navigateToNextScreen(from: view!, article: article, publishDate: publishDate)
        }
    }
}
