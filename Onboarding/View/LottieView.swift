//
//  LottieView.swift
//  Onboarding
//
//  Created by Tung Vu Duc on 17/02/2021.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
    @Binding var page: CGFloat
    let animationView = AnimationView()

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animation = Animation.named("carousel")
        
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFill
//        animtionView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // after trying and failing I managed to find out that each person will appear in every 0.22 of the whole progress
        // so better use index instead of offset x
        animationView.currentProgress = page * 0.22
    }
    
}
