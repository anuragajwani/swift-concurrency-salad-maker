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
            async let lettuce = prepareIngredient(.lettuce)
            async let tomatoes = prepareIngredient(.tomatoes)
            async let redOnion = prepareIngredient(.redOnion)
            async let sweetcorn = prepareIngredient(.sweetcorn)
            async let tuna = prepareIngredient(.tuna)
            let ingredients = await [lettuce, tomatoes, redOnion, sweetcorn, tuna]
            ingredients.forEach(onIngrdientPrepped)
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
