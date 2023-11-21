//
//  API.swift
//  Parnaso
//
//  Created by aaav on 18/11/23.
//

import Foundation

func fetchWordsFromAPI(word:  String) async -> [Palavra]{
    
    if let encodedString = word.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
        
//    let url = URL(string: "https://aaavalenca.pythonanywhere.com/rhyme/\(encodedString)")!
    let url = URL(string: "https://dicio-rimas-app-b3865f437d45.herokuapp.com/rhyme/\(encodedString)")!
//        print(url)
        var request = URLRequest(url: url)
        request.timeoutInterval = 30
        let session = URLSession.shared
        
        do {
            let (data, _) = try await session.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let wordResult = try decoder.decode([Palavra].self, from: data)
            return wordResult
        } catch {
            print(error)
        }
        return []
    }
    else {
        return []
    }
}
