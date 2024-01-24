//
//  UnsplashAPI.swift
//  UnsplashApp
//
//  Created by Arthur LE-DEVEDEC on 1/23/24.
//

import Foundation

struct UnsplashAPI{
    
    let scheme = "https"
    let host = "api.unsplash.com"
    let clientId = ConfigurationManager.instance.plistDictionnary.clientId
    
    func unsplashApiBaseUrl(path: String) -> URLComponents {
        print("url")
        var urlComponents = URLComponents()

        urlComponents.scheme = "https"
        urlComponents.host = "api.unsplash.com"
        urlComponents.path = path

        let clientId = ConfigurationManager.instance.plistDictionnary.clientId
        let clientIDQueryItem = URLQueryItem(name: "client_id", value: clientId)
        urlComponents.queryItems = [clientIDQueryItem]

        return urlComponents
    }

    func feedUrl(path: String, orderBy: String = "popular", perPage: Int = 10) -> URL? {
        print("url1")
        var urlComponents = unsplashApiBaseUrl(path: path)

        let orderByQueryItem = URLQueryItem(name: "order_by", value: orderBy)
        let perPageQueryItem = URLQueryItem(name: "per_page", value: String(perPage))

        urlComponents.queryItems?.append(contentsOf: [orderByQueryItem, perPageQueryItem])

        return urlComponents.url
    }

    
}
