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
    func itemsFetched(result: Result<HomeModel, Error>)
    
    //collection view
    func numberOfItems() -> Int
    func item(at index: Int) -> Articles?
    func didSelectItem(at index: Int)
    func cellTextColor() -> UIColor
    func cellTextFontSize() -> CGFloat
}

class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeViewProtocol?
    var router: HomeRouterProtocol?
    private var homeModel: HomeModel?
    var interactor: HomeInteractorProtocol
    
    init(interactor: HomeInteractorProtocol) {
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        interactor.fetchItems { result in
            switch result {
            case .success(let items):
                print(items)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: REQUEST
    func itemsFetched(result: Result<HomeModel, Error>) {
        switch result{
        case .success(let data):
            DispatchQueue.main.async{
                self.homeModel = data
                self.view?.reloadTableView()
            }
        case .failure(let error):
            print("\(error)")
        }
    }
    
    //MARK: TableView
    func numberOfItems() -> Int {
        return homeModel?.articles.count ?? 0
    }
    
    func item(at index: Int) -> Articles? {
        return homeModel?.articles[index]
    }
    
    func cellTextColor() -> UIColor {
        return .white
    }
    
    func cellTextFontSize() -> CGFloat {
        return 16
    }
    
    func didSelectItem(at index: Int) {
        router?.navigateToNextScreen(from: view!)
    }
}
