//
//  RecepieDetailsTests.swift
//  KitchenHelperTests
//
//  Created by dfg on 08.01.2023.
//


import XCTest
@testable import KitchenHelper

class RecepieDetailsTests: XCTestCase {
    
    // check whether InteractorRecepieDetails saves categories
    func testRecepiesDetailsInteractorCreateCoreDataItem() throws {
        let recepieDetailsInteractor = InteractorRecepieDetails()
        
        recepieDetailsInteractor.createItem(id: "123", name: "testItem", imageUrl: "123",category: "category", area: "RU", instructions: "instructions", tagsString: "tags", youtubeUrlString: "https://www.youtube.com/watch?v=gWNrFi_LdUk", ingredient1: "ingredient1", ingredient2: "ingredient2", ingredient3: "ingredient3", ingredient4: "ingredient4", ingredient5: "ingredient5", ingredient6: "ingredient6", ingredient7: "ingredient7")
        
        recepieDetailsInteractor.getAllItems()
        
        let allItems = recepieDetailsInteractor.savedCategories
        
        
        XCTAssertEqual(allItems.last?.name, "testItem")
      
    }
    
    // check whether InteractorRecepieDetails deletes all categories
    func testRecepiesDetailsInteractorDeleteAllItems() throws {
        let recepieDetailsInteractor = InteractorRecepieDetails()
        
        recepieDetailsInteractor.createItem(id: "123", name: "testItem", imageUrl: "123",category: "category", area: "RU", instructions: "instructions", tagsString: "tags", youtubeUrlString: "https://www.youtube.com/watch?v=gWNrFi_LdUk", ingredient1: "ingredient1", ingredient2: "ingredient2", ingredient3: "ingredient3", ingredient4: "ingredient4", ingredient5: "ingredient5", ingredient6: "ingredient6", ingredient7: "ingredient7")
        
        recepieDetailsInteractor.getAllItems()
        
        var allItems = recepieDetailsInteractor.savedCategories
        
        XCTAssertEqual(allItems.last?.name, "testItem")
        
        recepieDetailsInteractor.deleteAllItems()
        
        recepieDetailsInteractor.getAllItems()
        
        allItems = recepieDetailsInteractor.savedCategories
        

        XCTAssertEqual(allItems.count, 0)
    }
}

