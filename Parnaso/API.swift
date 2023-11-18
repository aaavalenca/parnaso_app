//
//  API.swift
//  Parnaso
//
//  Created by aaav on 18/11/23.
//

import Foundation

func fetchWordsFromAPI(word:  String) async -> [Palavra]{
        let url = URL(string: "https://dicio-rimas-app-b3865f437d45.herokuapp.com/rhyme/\(word)")!
        
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
    //func fetchWordsFromAPI(word: String){
    //    let url = URL(string: "https://dicio-rimas-app-b3865f437d45.herokuapp.com/rhyme/\(word)")!
    //    let task = URLSession.shared.dataTask(with: url, completionHandler:  { data, response, error in
    //        guard let data = data, error == nil else {
    //            print("error1")
    //            return
    //        }
    //
    //        var result : [Palavra]?
    //        do {
    //            result = try JSONDecoder().decode([Palavra].self, from: data)
    //            return
    //        }
    //        catch{
    //            print("error2")
    //        }
    //
    //        guard let json = result else {
    //            return
    //        }
    //    }
    //    )
    //    task.resume()
    //}
