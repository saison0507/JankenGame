//
//  JankenGameManager.swift
//  JankenGame
//
//  Created by 石坂拓人 on 2025/05/26.
//

import Foundation

class JankenGameManager {
    private let userPlayer: JankenUserPlayer
    private let computerPlayer: JankenCPUPlayer
    private let jankenJudgeResult: JankenJudgeResult
    init(userPlayer: JankenUserPlayer, computerPlayer: JankenCPUPlayer) {
        self.userPlayer = userPlayer
        self.computerPlayer = computerPlayer
        self.jankenJudgeResult = JankenJudgeResult(jankenUserPlayer: userPlayer, jankenCPUPlayer: computerPlayer)
    }
    
    func playJankenGame() -> JankenGameResult {
        return jankenJudgeResult.judgeResult()
    }
}
