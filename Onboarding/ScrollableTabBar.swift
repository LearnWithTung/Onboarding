//
//  ScrollableTabBar.swift
//  OnboardingAnimated
//
//  Created by Tung Vu Duc on 10/02/2021.
//

import SwiftUI

struct ScrollableTabBar<Content: View>: UIViewRepresentable {
    
    let content: Content
    
    let scrollView = UIScrollView()
    
    var rect: CGRect
    
    var tabs: [Any]
    
    @Binding var page: CGFloat
    
    init(tabs: [Any], rect: CGRect, page: Binding<CGFloat>, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.rect = rect
        self.tabs = tabs
        self._page = page
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        setupScrollView()
        
        scrollView.contentSize = CGSize(width: rect.width * CGFloat(tabs.count), height: rect.height)
        
        scrollView.addSubview(extractView())
        scrollView.delegate = context.coordinator
        
        return scrollView
    }
    
    func makeCoordinator() -> Coordinator {
        return ScrollableTabBar.Coordinator(parent: self)
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
    }
    
    // setting up scrollView
    
    func setupScrollView() {
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    func extractView() -> UIView {
        let controller = UIHostingController(rootView: content)
        controller.view.frame = CGRect(x: 0, y: 0, width: rect.width * CGFloat(tabs.count), height: rect.height)
        
        return controller.view!
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ScrollableTabBar
        
        init(parent: ScrollableTabBar) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.page = scrollView.contentOffset.x / scrollView.frame.width
        }
    }
    
}

struct ScrollableTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
