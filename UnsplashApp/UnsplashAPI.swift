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
    
    func unsplashApiBaseUrl() -> URLComponents {
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.queryItems = [URLQueryItem(name: "client_id", value: clientId)]
            return components
        }
    
    func feedUrl(orderBy: String = "popular", perPage: Int = 10) -> URL? {
            var components = unsplashApiBaseUrl()
            components.path = "/photos"
            components.queryItems?.append(contentsOf: [
                URLQueryItem(name: "order_by", value: orderBy),
                URLQueryItem(name: "per_page", value: String(perPage))
            ])
            return components.url
        }

    
}
