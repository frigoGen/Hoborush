//
//  LeaderBoardFunctions.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 10/12/22.
//

import Foundation

func updateHighScore(nome: String, scores: Int ) -> Void
{
    var newScores = loadScores()
    newScores.append((nome,scores))
    print("CRASH4")
    newScores.sort(by: {$0.value < $1.value})
    print("CRASH5")
    newScores.reverse()
    print("CRASH6")
    if(newScores.count == 5){
        newScores.remove(at: newScores.count - 1 )
        print("CRASH6.5")
    }
    UserDefaults.standard.set(newScores,forKey:"leader")
    print("CRASH7")
}
func loadScores() -> [(name: String, value: Int)]
{
    
    var scores: [(name: String, value: Int)] = [("",0)]
    if let rawData = UserDefaults.standard.object(forKey:"leader")
    {
        if let savedScores = rawData as? [(name: String, value: Int)]
        {
            print("CRASH1")
            scores = savedScores
        }
    }
    print("CRASH2")
    scores.sort(by: {$0.value < $1.value})
    print("CRASH3")
    scores.reverse()
    return scores
}

