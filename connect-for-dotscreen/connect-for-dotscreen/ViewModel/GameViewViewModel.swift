//
//  GameViewViewModel.swift
//  connect-for-dotscreen
//
//  Created by Alexandre Laborde on 24/05/2024.
//

import Foundation

enum GameState {
    case playing
    case draw
    case win1
    case win2
}

class GameViewViewModel : ObservableObject {
    var grid: [[PawnState]] = [[PawnState]](repeating: [PawnState](repeating: .empty, count: 7), count: 6)
    var playerTurn = true
    var gameState:GameState = .playing
    
    func reset() {
        grid = [[PawnState]](repeating: [PawnState](repeating: .empty, count: 7), count: 6)
        gameState = .playing
    }
    
    func play() {
        let x:Int = 0
        let y:Int = grid[x].firstIndex(of: .empty) ?? 0
        guard !grid[x].contains(.empty) else {
            return
        }
        if (playerTurn) {
            grid[x][y] = .cross
        } else {
            grid[x][y] = .circle
        }
        playerTurn.toggle()
    }
    
    func verifyGameState() -> GameState {
        var last
    }
}
