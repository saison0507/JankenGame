//
//  JankenJudgeResult.swift
//  JankenGame
//
//  Created by 石坂拓人 on 2025/05/27.
//

import Foundation

class JankenJudgeResult {
    private let jankenUserPlayer: JankenUserPlayer
    private let jankenRivalPlayer: JankenCPUPlayer
    
   init(jankenUserPlayer: JankenUserPlayer, jankenCPUPlayer: JankenCPUPlayer) {
        self.jankenUserPlayer = jankenUserPlayer
        self.jankenRivalPlayer = jankenCPUPlayer
    }
    
    func judgeResult() -> JankenGameResult {
        switch (jankenUserPlayer.CHOSEN_HAND, jankenRivalPlayer.CHOSEN_HAND) {
        case (.guHand, .chokiHand), (.chokiHand, .paHand), (.paHand, .guHand):
            return .WIN
        case (.guHand, .paHand), (.paHand, .chokiHand), (.chokiHand, .guHand):
            return .LOSE
        default:
            return .DRAW
        }
    }
}
