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
    @Published var grid: [[PawnState]] = [[PawnState]](repeating: [PawnState](repeating: .empty, count: 6), count: 7)
    @Published var playerTurn = PawnState.circle
    @Published var gameState:GameState = .playing
    
    func reset() {
        grid = [[PawnState]](repeating: [PawnState](repeating: .empty, count: 6), count: 7)
        gameState = .playing
    }
    
    func play(x: Int) {
        let y:Int = grid[x].firstIndex(of: .empty) ?? 0
        guard grid[x].contains(.empty) else {
            return
        }
        print(y)
        if (playerTurn == .circle) {
            grid[x][y] = .cross
        } else {
            grid[x][y] = .circle
        }
        print(grid[x][y])
        playerTurn = (playerTurn == .circle ? .cross : .circle)
    }
    
    func verifyGameState() -> GameState {
        for row in 0..<grid.count {
            for col in 0..<grid[0].count {
                if grid[row][col] != .empty {
                    if checkWin(row: row, col: col) {
                        return grid[row][col] == .cross ? .win1 : .win2
                    }
                }
            }
        }
        
        let isDraw = grid.allSatisfy ({ $0.allSatisfy ({ $0 != .empty }) })
        return isDraw ? .draw : .playing
    }
    
    func checkWin(row: Int, col: Int) -> Bool {
        let directions = [
            (x: 1, y: 0),
            (x: 0, y: 1),
            (x: 1, y: 1),
            (x: 1, y: -1)
        ]
        
        let currentPlayer = grid[row][col]
        
        for direction in directions {
            var count = 0
            
            for i in 0..<4 {
                let newRow = row + i * direction.y
                let newCol = col + i * direction.x
                
                if newRow >= 0, newRow < grid.count, newCol >= 0, newCol < grid[0].count, grid[newRow][newCol] == currentPlayer {
                    count += 1
                } else {
                    break
                }
            }
            
            if count == 4 {
                return true
            }
        }
        
        return false
    }
    
    func getCaseState(row: Int, col: Int) -> PawnState {
        return grid[row][col]
    }
}
