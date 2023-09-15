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
                    ZStack {
                        Icons(show: $show, icon: "house", Eoffset: 110, Eanimation: 0.22, delay: 0.14)
                        
                        Button {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                                show.toggle()
                            }
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 60)
                                    .foregroundColor(.black)
                                Image(systemName: "plus")
                                    .font(.system(size: 30, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            .offset(x: -20, y: -30)
                        }

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
                for index in 1...3 {
                    if let symbol = context.resolveSymbol(id: index) {
                        drawingContext.draw(symbol, at: drawPoint)
                    }
                }
            }
        } symbols: {
            Circle()
                .frame(width: 60)
                .tag(1)
//            Circle()
//                .frame(width: 60)
//                .tag(2)
//                .offset(y: show ? -75 : 0)
            ElCircle(show: $show, Eoffset: 80, eanimation: 0.3, tag: 2)
            ElCircle(show: $show, Eoffset: 160, eanimation: 0.2, tag: 3)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ElCircle: View {
    @Binding  var show: Bool
    var Eoffset: CGFloat
    var eanimation: CGFloat
    var tag: Int
    
    var body: some View {
        Circle()
            .frame(width: 60)
            .tag(tag)
            .offset(y: show ? -Eoffset : 0)
            .animation(Animation.spring(response: 1, dampingFraction: 0.8).delay(show ? eanimation : 0.1), value: show)
    }
}

struct Icons: View {
    @Binding  var show: Bool
    let icon: String
    var Eoffset: CGFloat
    var Eanimation: CGFloat
    var delay: CGFloat
    
    var body: some View {
        
        Image(systemName: icon)
            .font(.title)
            .foregroundColor(.white)
            .offset(x: -20, y: show ? -Eoffset : -45)
            .scaleEffect(show ? 1 : 0)
            .opacity(show ? 1 : 0)
            .animation(Animation.spring(response: 1, dampingFraction: 0.8).delay(show ? Eanimation : delay), value: show)
            .onTapGesture {
                print(icon)
                withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                    show.toggle()
                }
            }
    }
}
