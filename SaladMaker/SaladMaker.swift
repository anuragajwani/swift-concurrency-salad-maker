//
//  SaladMaker.swift
//  SaladMaker
//
//  Created by Anurag Ajwani on 12/12/2020.
//

import Foundation

class SaladMaker {
    func make(onIngrdientPrepped: @escaping (Ingredient) -> ()) {
        Task(priority: .userInitiated) {
            for ingredient in Ingredient.allCases {
                await prepareIngredient(ingredient)
                onIngrdientPrepped(ingredient)
            }
        }
    }

    private func prepareIngredient(_ ingredient: Ingredient) async {
        return await withCheckedContinuation({ continuation in
            // using DispatchQueue here instead of Task due to unexpected behaviour
            DispatchQueue.global(qos: .userInitiated).async {
                let randomTime = UInt32.random(in: 1...5)
                sleep(randomTime)
                continuation.resume()
            }
        })
    }
}
