//
//  JankenChooseHandPresenter.swift
//  JankenGame
//
//  Created by 石坂拓人 on 2025/05/26.
//

import Foundation

class JankenChooseHandPresenter {
    private let jankenUserPlayer: JankenUserPlayer
    private let jankenCPUPlayer: JankenCPUPlayer
    
   init(jankenUserPlayer: JankenUserPlayer, jankenCPUPlayer: JankenCPUPlayer) {
        self.jankenUserPlayer = jankenUserPlayer
        self.jankenCPUPlayer = jankenCPUPlayer
    }
    
    func setUserHand(selectedHand: JankenHand) {
            jankenUserPlayer.chooseJankenHand(choosehand: selectedHand)
            jankenCPUPlayer.chooseJankenHand()
        }
    func createGameManager() -> JankenGameManager {
            return JankenGameManager(userPlayer: jankenUserPlayer, computerPlayer: jankenCPUPlayer)
        }
    
    var userPlayer: JankenUserPlayer {
            return jankenUserPlayer
        }

    var cpuPlayer: JankenCPUPlayer {
            return jankenCPUPlayer
        }

}
