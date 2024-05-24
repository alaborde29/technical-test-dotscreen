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
        HStack {
            ForEach(0...7, id: \.self) { index in
                ColumnView(index: index)
                    .environmentObject(viewModel)
            }
        }
        .padding()
        .onTapGesture {
            
        }
    }
}

struct ColumnView: View {
    @EnvironmentObject var viewModel: GameViewViewModel
    var body: some View {
        let _column: Int
        VStack {
            for index in 0...6 {
                PawnView(state: viewModel.board[column][index])
            }
        }
    }
}

struct PawnView: View {
    @State var state: PawnState
    let index: (Int, Int)
    
    var body: some View {
        switch state {
        case .empty:
            Circle()
                .fill(Color.white)
                .frame(width: 50, height: 50)
        case .cross:
            Image(systemName: "cross")
                .frame(width: 50, height: 50)
                .foregroundColor(.red)
        case .circle:
            Image(systemName: "circle.circle")
                .frame(width: 50, height: 50)
                .foregroundColor(.yellow)
        }
    }
}

#Preview {
    GameView()
}
