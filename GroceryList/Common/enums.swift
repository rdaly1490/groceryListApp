//
//  enums.swift
//  GroceryList
//
//  Created by Rob Daly on 10/12/18.
//  Copyright © 2018 Rob Daly. All rights reserved.
//

import Foundation

enum GroceryType: Int {
    case unknown = 0
    case dairy = 1
    case vegetables = 2
    case fruits = 3
    case bakingAndGrains = 4
    case addedSweeteners = 5
    case spices = 6
    case meats = 7
    case fish = 8
    case seafood = 9
    case condiments = 10
    case oils = 11
    case seasonings = 12
    case sauces = 13
    case legumes = 14
    case alcohol = 15
    case soup = 16
    case nuts = 17
    case dairyAlternatives = 18
    case dessertsAndSnacks = 19
    case beverages = 20
    
    static let allGroceryTypes: [GroceryType] = [.unknown, .dairy, .vegetables, .fruits, .bakingAndGrains, .addedSweeteners, .spices, .meats, .fish, .seafood, .condiments, .oils, .seasonings, .sauces, .legumes, .alcohol, .soup, .nuts, .dairyAlternatives, .dessertsAndSnacks, .beverages]
    
    func getGroceryTypeName() -> String {
        switch self {
            case .unknown: return "Misc."
            case .dairy: return "Dairy"
            case .vegetables: return "Vegetables"
            case .fruits: return "Fruits"
            case .bakingAndGrains: return "Baking And Grains"
            case .addedSweeteners: return "Added Sweeteners"
            case .spices: return "Spices"
            case .meats: return "Meats"
            case .fish: return "Fish"
            case .seafood: return "Seafood"
            case .condiments: return "Condiments"
            case .oils: return "Oils"
            case .seasonings: return "Seasonings"
            case .sauces: return "Sauces"
            case .legumes: return "Legumes"
            case .alcohol: return "Alcohol"
            case .soup: return "Soup"
            case .nuts: return "Nuts"
            case .dairyAlternatives: return "Dairy Alternatives"
            case .dessertsAndSnacks: return "Desserts And Snacks"
            case .beverages: return "Beverages"
        }
    }
}
