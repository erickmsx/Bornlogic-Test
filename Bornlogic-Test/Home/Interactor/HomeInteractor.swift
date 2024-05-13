//
//  HomeInteractor.swift
//  Bornlogic-Test
//
//  Created by Erick Martins on 11/05/24.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidData
}

protocol HomeInteractorProtocol: AnyObject {
    func fetchArticles()
    func fetchArticlesMock() -> HomeModel
}

class HomeInteractor: HomeInteractorProtocol {
    
    static let shared = HomeInteractor()
    weak var presenter: HomePresenterProtocol?
    
    func fetchArticles() {
        
        let apiKey = "91af6e9ba0394c3fa88767b59d8754f6"
        let baseUrl = "https://newsapi.org/v2/everything"
        
        let date = getPreviousDate()
        
        var components = URLComponents(string: baseUrl)
        components?.queryItems = [
            URLQueryItem(name: "q", value: "tesla"),
            URLQueryItem(name: "from", value: date),
            URLQueryItem(name: "sortBy", value: "publishedAt"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        guard let url = components?.url else {
            presenter?.articlesFetched(result: .failure(NetworkError.invalidURL), publishDate: "")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                self.presenter?.articlesFetched(result: .failure(NetworkError.requestFailed), publishDate: "")
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                self.presenter?.articlesFetched(result: .failure(NetworkError.requestFailed), publishDate: "")
                print("Invalid response")
                return
            }
            
            guard let data = data else {
                self.presenter?.articlesFetched(result: .failure(NetworkError.invalidData), publishDate: "")
                print("No data received")
                return
            }
            
            do {
                let items = try JSONDecoder().decode(HomeModel.self, from: data)
                self.presenter?.articlesFetched(result: .success(items), publishDate: date)
            } catch {
                self.presenter?.articlesFetched(result: .failure(NetworkError.invalidData), publishDate: date)
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func getPreviousDate() -> String {
        let currentDate = Date()
        
        var dateComponents = DateComponents()
        dateComponents.day = -1
        
        let calendar = Calendar.current
        if let previousDate = calendar.date(byAdding: dateComponents, to: currentDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let dateString = dateFormatter.string(from: previousDate)
            return dateString
        } else {
            return "Error getting the data"
        }
    }
    
    func fetchArticlesMock() -> HomeModel {
        return HomeModel(articles: [Articles(title: "titleTest", urlToImage: "urlTest", description: "descriptionTest", author: "authorTest", content: "contentTest")])
    }
}

