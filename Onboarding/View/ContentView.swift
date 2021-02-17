//
//  ContentView.swift
//  Onboarding
//
//  Created by Tung Vu Duc on 17/02/2021.
//

import SwiftUI

struct ContentView: View {
    @State var page: CGFloat = 0
    
    var body: some View {
        VStack {
            ZStack {
                LottieView(page: $page)
                    .frame(maxWidth: .infinity, maxHeight: 300)
            }
            .background(Color.orange)
            
            GeometryReader {proxy in
                let rect = proxy.frame(in: .global)
                
                ScrollableTabBar(tabs: employees, rect: rect, page: $page) {
                    VStack {
                        HStack(spacing: 0) {
                            ForEach(employees, id: \.id) { employee in
                                VStack {
                                    HStack {
                                        Text(employee.title)
                                            .font(.system(size: 35, weight: .bold, design: .rounded))
                                        
                                        Spacer()
                                    }
                                    .padding(.bottom, 10)
                                    
                                    Text(employee.description)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    Spacer()
                }
            }
            
            PageControl(currentIndex: $page)
                .padding(.bottom, 65)
        }

    }
}

struct PageControl: View {
    @Binding var currentIndex: CGFloat
    
    var body: some View {
        ZStack {
            if Int(currentIndex) == employees.count - 1 {
                Button(action: {}, label: {
                    Text("Start")
                        .fontWeight(.bold)
                        .padding()
                        .padding(.horizontal, 50)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                })
            } else {
                HStack {
                    ForEach(0..<employees.count) { index in
                        Circle()
                            .fill(Int(currentIndex) == index ? Color.primary : Color.secondary)
                            .frame(width: 8, height: 8)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
