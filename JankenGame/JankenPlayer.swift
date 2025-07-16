//
//  JankenPlayer.swift
//  JankenGame
//
//  Created by 石坂拓人 on 2025/05/27.
//

import Foundation

protocol JankenPlayer {
    var PLAYER_NAME: String? { get }
    var CHOSEN_HAND: JankenHand? { get }
}

protocol JankenUserPlayerProtocol: JankenPlayer {
    func chooseJankenHand(choosehand: JankenHand)
}

protocol JankenCPUPlayerProtocol: JankenPlayer {
    func chooseJankenHand()
}

class JankenUserPlayer: JankenUserPlayerProtocol {
    let PLAYER_NAME: String? = nil
    var CHOSEN_HAND: JankenHand? = nil
    
    func chooseJankenHand(choosehand: JankenHand) {
        CHOSEN_HAND = choosehand
    }
}

class JankenCPUPlayer: JankenCPUPlayerProtocol {
    let PLAYER_NAME: String? = nil
    var CHOSEN_HAND: JankenHand? = nil
    
    func chooseJankenHand() {
        let randonHand = JankenHand.allCases.randomElement()
        CHOSEN_HAND = randonHand
    }
}
