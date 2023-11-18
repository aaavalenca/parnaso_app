//
//  API.swift
//  Parnaso
//
//  Created by aaav on 18/11/23.
//

import Foundation

func fetchWordsFromAPI(){
    let url = URL(string: "https://dicio-rimas-app-b3865f437d45.herokuapp.com/rhyme/casa")!
    print(url)
    let task = URLSession.shared.dataTask(with: url, completionHandler:  { data, response, error in
        guard let data = data, error == nil else {
            print("error1")
            return
        }
        
        var result : [Palavra]?
        do {
            result = try JSONDecoder().decode([Palavra].self, from: data)
        }
        catch{
            print("error2")
        }
        
        guard let json = result else {
            return
        }
        print(json)
    }
    )
    task.resume()
    
    
}
