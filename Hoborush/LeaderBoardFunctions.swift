//
//  LeaderBoardFunctions.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 10/12/22.
//

import Foundation

public struct salvataggio: Codable {
    var nome: String
    let punti: Int
    
    init(nome: String, punti: Int) {
        self.nome = nome
        self.punti = punti
    }
}

func updateHighScore(giocatore: salvataggio ) -> Void
{
    var newScores = loadScores()
    newScores.append(giocatore)
    print("CRASH4")
    newScores.sort(by: {$0.punti < $1.punti})
    print("CRASH5")
    newScores.reverse()
    print("CRASH6")
    if(newScores.count > 3){
        newScores.removeLast(newScores.count - 3)
        print("CRASH6.5")
    }
    print("CRASH7")
    if let data = try? PropertyListEncoder().encode(newScores) {
            UserDefaults.standard.set(data, forKey: "pisello")
        }
    print("\(newScores)")
}
func loadScores() -> [salvataggio]
{
    let standard = salvataggio(nome: "ABC", punti: 0)
    var scores: [salvataggio] = [standard]
    /*if let rawData = UserDefaults.standard.data(forKey: "pisello"){
        if let savedScores = rawData as? [salvataggio]{
            scores = savedScores
        }
    }*/
    let defaults = UserDefaults.standard
            if let data = defaults.data(forKey: "pisello") {
                 scores = try! PropertyListDecoder().decode([salvataggio].self, from: data)
                
            }
    
    scores.sort(by: {$0.punti < $1.punti})
    print("CRASH3")
    scores.reverse()
    return scores
}

