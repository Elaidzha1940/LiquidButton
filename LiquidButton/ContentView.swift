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
    @State var show: Bool = false
    var body: some View {
        VStack {
            Rectangle()
                .mask(canvas)
                .overlay {
                    Button {
                        show.toggle()
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 60)
                                .foregroundColor(.black)
                            Image(systemName: "plus")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(.gray)
                        }
                        .offset(x: -20, y: -30)
                    }
                    .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottomTrailing)
                }
        }
    }
    
    var canvas: some View {
        Canvas { context, size in
            context.addFilter(.alphaThreshold(min: 0.4))
            context.addFilter(.blur(radius: 10))
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
            Circle().frame(width: 60)
                .tag(2)
                .offset(y: show ? -50 : 0)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
