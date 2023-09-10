//
//  ExampleUsage.swift
//
//  Created by John Baker on 9/10/23.
//

import Foundation

/* Add this snippet to your environment
 extension NetworkRequest where ResponseType == <#ResponseName#> {
     static func <#functionName#> (_: String) -> NetworkRequest<<#ResponseName#>>{
         let urlString = <#urlString#>
         guard let url = URL(string: urlString) else {
             fatalError("Invalid URL: \(urlString)")
         }
         
         return NetworkRequest<<#ResponseName#>>(
             method: <#method#>,
             url: url,
             headers: <#header#>,
             body: <#body#>
         )
     }
 }


 fileprivate struct <#ResponseName#>: NetworkResponse {
     <#var name: String#>
 }
 */

// MARK: - Use code snippet newRequest to create template
fileprivate extension NetworkRequest where ResponseType == [Country] {
    static func searchCountryByName(_ name: String) -> NetworkRequest<[Country]> {
        let urlString = "https://restcountries.com/v3.1/name/\(name)?fullText=true"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        
        return NetworkRequest<[Country]>(
            method: .get,
            url: url,
            headers: nil,
            body: nil
        )
    }
}

fileprivate struct Country: NetworkResponse {
    let name: CountryName
    
    struct CountryName: Codable {
        let common: String
        let official: String
    }
}

fileprivate func exampleUsage() async {
    let networkManager = NetworkManager()

    do {
        let countryName = "YourCountryName" // Replace with the actual country name you want to search
        let response = try await networkManager.performRequest(.searchCountryByName(countryName))
        print(response)
    } catch {
        print("Error: \(error)")
    }
}

