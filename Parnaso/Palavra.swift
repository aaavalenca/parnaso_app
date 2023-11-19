//
//  Palavra.swift
//  Parnaso
//
//  Created by aaav on 18/11/23.
//

import Foundation

struct Palavras : Codable{
    let results : [Palavra]
}

struct Palavra : Codable {
    let categoria : String
    let palavra : String
    let prioridade : Int
}
