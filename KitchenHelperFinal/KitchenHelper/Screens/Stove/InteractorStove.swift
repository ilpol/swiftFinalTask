//
//  InteractorStove.swift
//  KitchenHelper
//
//  Created by dfg on 22.11.2022.
//

import UIKit
import Vision
import UserNotifications

protocol AnyInteractorStove {
    var presenter: AnyPresenterStove? {get set}
}

class StoveInteractor: AnyInteractorStove {
    var presenter: AnyPresenterStove?
}
