//
//  HomeRouter.swift
//  Bornlogic-Test
//
//  Created by Erick Martins on 11/05/24.
//

import UIKit

protocol HomeRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToNextScreen(from view: HomeViewProtocol)
}

class HomeRouter: HomeRouterProtocol {
    static func createModule() -> UIViewController {
        let network: HomeInteractorProtocol = HomeInteractor.shared
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let presenter = HomePresenter(interactor: network)
        let router = HomeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func navigateToNextScreen(from view: HomeViewProtocol) {
        guard let viewController = view as? UIViewController else {
            fatalError("View should be a UIViewController")
        }
        let articleDetailsVC = ArticleDetailsViewController()
        viewController.navigationController?.pushViewController(articleDetailsVC, animated: true)
    }
}
