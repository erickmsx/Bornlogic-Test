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
    func fetchItems(completion: @escaping(Result<HomeModel, Error>) -> Void)
}

class HomeInteractor: HomeInteractorProtocol {
    
    static let shared = HomeInteractor()
    weak var presenter: HomePresenterProtocol?
    
    func fetchItems(completion: @escaping(Result<HomeModel, Error>) -> Void) {
        
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
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError.requestFailed))
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.requestFailed))
                print("Invalid response")
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                print("No data received")
                return
            }
            
            do {
                let items = try JSONDecoder().decode(HomeModel.self, from: data)
                self.presenter?.itemsFetched(result: .success(items), publishDate: date)
            } catch {
                completion(.failure(NetworkError.invalidData))
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
            return "Erro ao calcular a data anterior"
        }
    }
}

