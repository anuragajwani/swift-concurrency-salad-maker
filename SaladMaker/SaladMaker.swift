//
//  SaladMaker.swift
//  SaladMaker
//
//  Created by Anurag Ajwani on 12/12/2020.
//

import Foundation

class SaladMaker {
    func make(onIngrdientPrepped: @escaping (Ingredient) -> ()) {
        Ingredient.allCases.forEach { (ingredient) in
            self.prepareIngredient(ingredient)
            onIngrdientPrepped(ingredient)
        }
    }
    
    private func prepareIngredient(_ ingredient: Ingredient) {
        let randomTime = UInt32.random(in: 1...5)
        sleep(randomTime) // chop, cut, etc...
    }
}
