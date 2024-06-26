//
//  ContentView.swift
//  connect-for-dotscreen
//
//  Created by Alexandre Laborde on 24/05/2024.
//

import SwiftUI

enum PawnState {
    case empty
    case cross
    case circle
}

struct GameView: View {
    
    @StateObject var viewModel = GameViewViewModel()
    var body: some View {
        VStack {
            HStack(spacing:0) {
                ForEach(0..<7, id: \.self) { column in
                    ColumnView(column: column)
                        .environmentObject(viewModel)
                }
            }
            .padding()
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(viewModel.playerTurn == .circle ? Color.blue : Color.red)
                if viewModel.getGameState() == GameState.win1 {
                    Text("Player 1 won !")
                        .foregroundColor(.white)
                        .font(.title)
                }
                if viewModel.getGameState() == GameState.win2 {
                    Text("Player 2 won !")
                        .foregroundColor(.white)
                        .font(.title)
                }
                if viewModel.getGameState() == GameState.draw {
                    Text("Draw !")
                        .foregroundColor(.white)
                        .font(.title)
                }
                if viewModel.getGameState() == GameState.playing {
                    Text(viewModel.playerTurn == .circle ? "Player 1" : "Player 2")
                        .foregroundColor(.white)
                        .font(.title)
                }
            }
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .frame(width: 250 ,height: 50)
            if viewModel.getGameState() != GameState.playing {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.green)
                    Text("Replay ?")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .frame(width: 130, height: 40)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .onTapGesture {
                    viewModel.reset()
                }
            }
        }
    }
}

struct ColumnView: View {
    var column: Int
    @EnvironmentObject var viewModel: GameViewViewModel
    @State var refreshview = false
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach((0..<6).reversed(), id: \.self) { row in
                PawnView(col: self.column, row: row, state: self.$viewModel.grid[self.column][row])
                    .environmentObject(self.viewModel)
            }
        }
        .onTapGesture {
            print("tap")
            if viewModel.getGameState() == GameState.playing {
                viewModel.play(x: column)
            }
        }
    }
}

struct PawnView: View {
    @EnvironmentObject var viewModel: GameViewViewModel
    let col: Int
    let row: Int
    @Binding var state: PawnState
    
    var body: some View {

        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 40, height: 40)
                .border(Color.blue, width: 1)
            switch state {
            case .empty:
                Image(systemName: "cross")
                    .foregroundColor(.white)
            case .cross:
                Image(systemName: "cross")
                    .foregroundColor(.red)
            case .circle:
                Image(systemName: "circle.circle")
                    .foregroundColor(.yellow)
            }
        }
    }
}

#Preview {
    GameView()
}
