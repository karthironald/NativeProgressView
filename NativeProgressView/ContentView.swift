//
//  ContentView.swift
//  NativeProgressView
//
//  Created by Karthick Selvaraj on 25/06/20.
//

import SwiftUI

struct ContentView: View {
    
    let timer = Timer.publish(every: 0.25, on: .main, in: .default).autoconnect()
    @State private var progress: CGFloat = 0.0
    var total: CGFloat = 1.0
    
    var body: some View {
        VStack(spacing: 50) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .foregroundColor(.blue)
            
            ProgressView(label: {
                Button(action: {}, label: {
                    Text("Cancel")
                        .font(.subheadline)
                        .bold()
                        .padding(5)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                })
                .scaleEffect(0.5, anchor: .center)
            })
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            
            ProgressView(value: progress, total: total)
                .progressViewStyle(CustomLinearProgressViewStyle2(progress: progress, total: total))
            
            ProgressView(progress >= total ? "Downloaded" : "Downloading...", value: progress, total: total)
                .progressViewStyle(CustomLinearProgressViewStyle1(progress: progress, total: total))
            
            ProgressView(value: progress, total: total, label: {
                HStack {
                    Button(action: {
                        self.progress -= 0.1
                    }, label: {
                        Image(systemName: "sun.min.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .aspectRatio(contentMode: .fit)
                    })
                    Spacer()
                    Button(action: {
                        self.progress += 0.1
                    }, label: {
                        Image(systemName: "sun.max.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .aspectRatio(contentMode: .fit)
                    })
                }
            })
            .progressViewStyle(CustomLinearProgressViewStyle1(progress: progress, total: total))
        }
        .padding(20)
        .onReceive(timer) { _ in
            if progress < 1 {
                self.progress += 0.1
            } else {
                timer.upstream.connect().cancel()
            }
        }
    }
    
}

struct CustomLinearProgressViewStyle1: ProgressViewStyle {
    
    var progressColour: Color = .blue
    var successColour: Color = .green
    var progress: CGFloat
    var total: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .foregroundColor(progress >= total ? successColour : progressColour)
            .accentColor(progress >= total ? successColour : progressColour)
            .animation(Animation.linear(duration: 1))
    }
    
}

struct CustomLinearProgressViewStyle2: ProgressViewStyle {

    var progressColour: Color = .blue
    var successColour: Color = .green
    var progress: CGFloat
    var total: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .padding(.all, 10)
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
            .foregroundColor(progress >= total ? successColour : progressColour)
            .accentColor(progress >= total ? successColour : progressColour)
            .animation(Animation.linear(duration: 1))
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


