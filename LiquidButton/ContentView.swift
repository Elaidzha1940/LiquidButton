//  /*
//
//  Project: LiquidButton
//  File: ContentView.swift
//  Created by: Elaidzha Shchukin
//  Date: 15.09.2023
//
//  Status: #Completed | Decorated
//
//  */

import SwiftUI

struct ContentView: View {
    @State var show: Bool = false
    
    let gradientColors = [
        Color(red: 115/255, green: 220/255, blue: 255/255, opacity: 1),
        Color(red: 117/255, green: 102/255, blue: 255/255, opacity: 1)]
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: gradientColors),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
                    Rectangle()
                        .mask(canvas)
                        .overlay {
                            ZStack {
                                // Adding NavigationLink to make icons clickable and navigate
                                NavigationLink(
                                    destination: PlusView(),
                                    label: {
                                        Icons(show: $show, icon: "plus", Eoffset: 270, Eanimation: 0.4, delay: 0.34)
                                    })
                                    .buttonStyle(PlainButtonStyle()) // Make sure the link looks like an icon, not a button

                                NavigationLink(
                                    destination: ArrowView(),
                                    label: {
                                        Icons(show: $show, icon: "arrow.right", Eoffset: 190, Eanimation: 0.3, delay: 0.24)
                                    })
                                    .buttonStyle(PlainButtonStyle())

                                NavigationLink(
                                    destination: MinusView(),
                                    label: {
                                        Icons(show: $show, icon: "minus", Eoffset: 110, Eanimation: 0.2, delay: 0.14)
                                    })
                                    .buttonStyle(PlainButtonStyle())

                                Button {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                        show.toggle()
                                    }
                                } label: {
                                    ZStack {
                                        Circle()
                                            .frame(width: 60)
                                            .foregroundStyle(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [
                                                        Color.white.opacity(0.9),
                                                        Color.green.opacity(0.9),
                                                        Color.green]),
                                                    startPoint: .top,
                                                    endPoint: .bottom))
                                        
                                        Image(systemName: "plus")
                                            .font(.system(size: 30, weight: .bold))
                                            .foregroundColor(.white)
                                            .rotationEffect(.degrees(show ? -45 : 0))
                                    }
                                    .offset(x: -20, y: -30)
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        }
                }
            }
        }
    }
    
    var canvas: some View {
        Canvas { context, size in
            context.addFilter(.alphaThreshold(min: 0.4))
            context.addFilter(.blur(radius: 10))
            context.drawLayer { drawingContext in
                let drawPoint = CGPoint(x: size.width - 50, y: size.height - 60)
                for index in 1...4 {
                    if let symbol = context.resolveSymbol(id: index) {
                        drawingContext.draw(symbol, at: drawPoint)
                    }
                }
            }
        } symbols: {
            Circle()
                .frame(width: 55)
                .tag(1)
            ElCircle(show: $show, Eoffset: 80, eanimation: 0.2, tag: 2)
            ElCircle(show: $show, Eoffset: 240, eanimation: 0.4, tag: 4)
            ElCircle(show: $show, Eoffset: 160, eanimation: 0.3, tag: 3)
        }
    }
}

struct ElCircle: View {
    @Binding var show: Bool
    var Eoffset: CGFloat
    var eanimation: CGFloat
    var tag: Int
    
    var body: some View {
        Circle()
            .frame(width: 55)
            .tag(tag)
            .offset(y: show ? -Eoffset : 0)
            .animation(.spring(response: 1.2, dampingFraction: 0.8).delay(eanimation), value: show)
    }
}

struct Icons: View {
    @Binding var show: Bool
    let icon: String
    var Eoffset: CGFloat
    var Eanimation: CGFloat
    var delay: CGFloat
    
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 25, weight: .semibold))
            .foregroundColor(.white)
            .offset(x: -20, y: show ? -Eoffset : -45)
            .scaleEffect(show ? 1 : 0.8)
            .opacity(show ? 1 : 0)
            .animation(.spring(response: 1.2, dampingFraction: 0.8).delay(Eanimation), value: show)
    }
}

// Views for navigation
struct PlusView: View {
    var body: some View {
        Text("You are on PlusView!")
            .font(.largeTitle)
            .navigationBarTitle("Plus View", displayMode: .inline)
    }
}

struct ArrowView: View {
    var body: some View {
        Text("You are on ArrowView!")
            .font(.largeTitle)
            .navigationBarTitle("Arrow View", displayMode: .inline)
    }
}

struct MinusView: View {
    var body: some View {
        Text("You are on MinusView!")
            .font(.largeTitle)
            .navigationBarTitle("Minus View", displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//            .animation(.easeInOut(duration: 0.5).delay(eanimation), value: show)
