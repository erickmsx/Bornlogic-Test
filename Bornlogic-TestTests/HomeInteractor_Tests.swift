//
//  HomeViewModel_Tests.swift
//  Bornlogic-TestTests
//
//  Created by Erick Martins on 13/05/24.
//

import XCTest
@testable import Bornlogic_Test

class HomeInteractor_Tests: XCTestCase {
    
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
        XCTAssertNotNil(presenter.homeModel?.articles)
        XCTAssertEqual(presenter.homeModel?.articles[0].author, "authorTest", "Author should match")
        XCTAssertEqual(presenter.homeModel?.articles[0].title, "titleTest", "Title should match")
        XCTAssertEqual(presenter.homeModel?.articles[0].urlToImage, "urlTest", "UrlToImage should match")
        XCTAssertEqual(presenter.homeModel?.articles[0].description, "descriptionTest", "Description should match")
        XCTAssertEqual(presenter.homeModel?.articles[0].content, "contentTest", "Content should match")
    }
}
