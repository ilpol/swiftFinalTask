//
//  heplers.swift
//  KitchenHelper
//
//  Created by dfg on 09.01.2023.
//

import UIKit
import CoreData

protocol HeplersProtocol {
    
}

class Heplers: HeplersProtocol {

    static let shared = Heplers()
    
    func getContext() -> NSManagedObjectContext {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        return context
    }
}
