//
//  EntranceView.swift
//  PasswordScreen
//
//  Created by Berkay Sutlu on 21.10.2023.
//

import SwiftUI

struct EntranceView: View {
    @State private var isClicked = false
    @State private var showFullScreenView = false
    
    
    var body: some View {
        VStack {
            if isClicked {
                Image(systemName: "lock.open")
            }
            else {
                Image(systemName: "lock")
            }
            
        }.scaleEffect(isClicked ? 1.2 : 1.0)
            .animation(.easeInOut(duration: 0.6))
            .onTapGesture {
                isClicked.toggle()
                if isClicked {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        showFullScreenView = true
                    }
                }
            }
            .background(Circle().stroke(lineWidth: 2).frame(width: 100, height: 100))
            .font(.title).background(Circle().stroke(lineWidth: 2).frame(width: 100,height: 100)).font(.title)
            .fullScreenCover(isPresented: $showFullScreenView) {
                // The view to present in full screen
                ContentView()
            }
        
        
    }
}

#Preview {
    EntranceView().preferredColorScheme(.dark)
}



