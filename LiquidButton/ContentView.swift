//  /*
//
//  Project: LiquidButton
//  File: ContentView.swift
//  Created by: Elaidzha Shchukin
//  Date: 15.09.2023
//
//  Status: in progress | Not decorated
//
//  */

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Rectangle()
                .mask(canvas)
                .overlay {
                    Circle()
                        .frame(width: 60)
                    Image(systemName: "plus")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.gray)
                }
        }
    }
    var canvas: some View {
        Canvas { context, size in
            context.drawLayer { drawingContext in
                let drawPoint = CGPoint(x: size.width - 50, y: size.height - 60)
                for index in 1...2 {
                    if let symbol = context.resolveSymbol(id: index) {
                        drawingContext.draw(symbol, at: drawPoint)
                    }
                }
            }
        } symbols: {
            Circle().frame(width: 60)
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
