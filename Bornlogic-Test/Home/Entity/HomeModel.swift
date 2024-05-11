//
//  HomeModel.swift
//  Bornlogic-Test
//
//  Created by Erick Martins on 11/05/24.
//

import Foundation

struct HomeModel: Codable{
    let articles: [Articles]
}

struct Articles: Codable{
    let title: String
    let urlToImage: String?
    let description: String
    let author: String?
}
