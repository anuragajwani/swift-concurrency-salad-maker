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
            await withTaskGroup(of: Ingredient.self, body: { group in
                for ingredient in Ingredient.allCases {
                    group.addTask(priority: .userInitiated) {
                       await self.prepareIngredient(ingredient)
                    }
                }
                for await ingredientPrepped in group {
                    onIngrdientPrepped(ingredientPrepped)
                }
            })
        }
    }

    private func prepareIngredient(_ ingredient: Ingredient) async -> Ingredient {
        return await withCheckedContinuation({ continuation in
            // using DispatchQueue here instead of Task due to unexpected behaviour
            DispatchQueue.global(qos: .userInitiated).async {
                let randomTime = UInt32.random(in: 1...5)
                sleep(randomTime)
                continuation.resume(returning: ingredient)
            }
        })
    }
}
