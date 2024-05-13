//
//  HomeViewModel_Tests.swift
//  Bornlogic-TestTests
//
//  Created by Erick Martins on 13/05/24.
//

import XCTest
@testable import Bornlogic_Test

class HomeViewModel_Tests: XCTestCase {
    
    let presenter = HomePresenter(interactor: HomeServiceMock())
    
    class HomeServiceMock: HomeInteractorProtocol {
        func fetchArticles() {
        }
        
        func fetchArticlesMock() -> HomeModel {
            return HomeModel(articles: [Articles(title: "titleTest", urlToImage: "urlTest", description: "descriptionTest", author: "authorTest", content: "contentTest")])
        }
    }
    
    func testFetchArticles() {
        
        presenter.articlesFetchedMock()
        
        XCTAssertNotNil(presenter.homeModel)
        XCTAssertEqual(presenter.homeModel?.articles[0].author, "authorTest", "Title should match")
    }
}
