//
//  ContentView.swift
//  PasswordScreen
//
//  Created by Berkay Sutlu on 20.10.2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    enum activeKeyboard: Hashable {
        case p1
        case p2
        case p3
        case p4
        case button
    }
    
    
    @State var passCorrect = false
    @FocusState var activeTF: activeKeyboard?
    
    @State var p1 = ""
    @State var p2 = ""
    @State var p3 = ""
    @State var p4 = ""
    @State var realPassword = "1234"
    @State var fullPassword = ""
    @State var incorrectPassword = false
    
    
    var body: some View {
        if passCorrect {
            MainView()
        } else {
            VStack{
                HStack {
                    SecureField("", text: $p1)
                        .focused($activeTF, equals: .p1)
                        .frame(width: 70,height: 80).fontWeight(.bold).font(.title).multilineTextAlignment(.center).foregroundColor(.black).background(.white).cornerRadius(20)
                    
                        .onChange(of: p1, initial: true) { oldValue, newValue in
                            if p1.count == 1 {
                                activeTF = .p2
                            }
                        }
                    
                    
                    SecureField("", text: $p2)
                        .focused($activeTF, equals: .p2)
                        .frame(width: 70,height: 80).fontWeight(.bold).font(.title).multilineTextAlignment(.center).foregroundColor(.black).background(.white).cornerRadius(20)
                    
                        .onChange(of: p2, initial: true) { oldValue, newValue in
                            if p2.count == 1 {
                                activeTF = .p3
                            }
                        }
                    
                    SecureField("", text: $p3)
                        .focused($activeTF, equals: .p3)
                        .frame(width: 70,height: 80).fontWeight(.bold).font(.title).multilineTextAlignment(.center).foregroundColor(.black).background(.white).cornerRadius(20)
                    
                        .onChange(of: p3, initial: true) { oldValue, newValue in
                            if p3.count == 1 {
                                activeTF = .p4
                            }
                        }
                    
                    SecureField("", text: $p4)
                        .focused($activeTF, equals: .p4)
                        .frame(width: 70,height: 80).fontWeight(.bold).font(.title).multilineTextAlignment(.center).foregroundColor(.black).background(.white).cornerRadius(20)
                    
                        .onChange(of: p4, initial: true) { oldValue, newValue in
                            if p4.count == 1 {
                                fullPassword = p1 + p2 + p3 + p4
                                isPassValid()
                                
                            }
                        }
                }.keyframeAnimator(initialValue: CGFloat.zero, trigger: incorrectPassword, content: { content, value in
                    content
                        .offset(x: value)
                }, keyframes: { _ in
                    KeyframeTrack {
                        CubicKeyframe(30, duration: 0.07)
                        CubicKeyframe(-30, duration: 0.07)
                        CubicKeyframe(20, duration: 0.07)
                        CubicKeyframe(-20, duration: 0.07)
                        CubicKeyframe(0, duration: 0.07)
                    }
                })
                .onAppear{
                    activeTF = .p1
                }
                HStack {
                    Spacer()
                    Button(action: {
                        //
                    }, label: {
                        Text("Forgot Pin?").font(.title3).foregroundStyle(.white.opacity(0.7))
                })
                }.padding(.trailing,45) // FORGOT PIN
                
                
                
                VStack(alignment: .leading) {
                    HStack {
                        Button {
                            numpadAction("1")
                            
                        } label: {
                            Text("1").frame(width: UIScreen.main.bounds.width / 3).frame(height: 100)
                        }
                        
                        Button {
                            numpadAction("2")
                        } label: {
                            Text("2").frame(width: UIScreen.main.bounds.width / 3).frame(height: 100)
                        }
                        
                        Button {
                            numpadAction("3")
                        } label: {
                            Text("3").frame(width: UIScreen.main.bounds.width / 3).frame(height: 100)
                        }
                    }
                    
                    HStack {
                        Button {
                            numpadAction("4")
                        } label: {
                            Text("4").frame(width: UIScreen.main.bounds.width / 3).frame(height: 100)
                        }
                        
                        Button {
                            numpadAction("5")
                        } label: {
                            Text("5").frame(width: UIScreen.main.bounds.width / 3).frame(height: 100)
                        }
                        
                        Button {
                            numpadAction("6")
                        } label: {
                            Text("6").frame(width: UIScreen.main.bounds.width / 3).frame(height: 100)
                        }
                    }
                    
                    HStack {
                        Button {
                            numpadAction("7")
                        } label: {
                            Text("7").frame(width: UIScreen.main.bounds.width / 3).frame(height: 100)
                        }
                        
                        Button {
                            numpadAction("8")
                        } label: {
                            Text("8").frame(width: UIScreen.main.bounds.width / 3).frame(height: 100)
                        }
                        
                        Button {
                            numpadAction("9")
                        } label: {
                            Text("9").frame(width: UIScreen.main.bounds.width / 3).frame(height: 100)
                        }
                    }
                    HStack {
                        Button {
                            // DELETE BUTTON
                            if activeTF == .p1 {
                                p1 = ""
                            } else if activeTF == .p2 {
                                p1 = ""
                                activeTF = .p1
                            } else if activeTF == .p3 {
                                p2 = ""
                                activeTF = .p2
                            } else if activeTF == .p4 {
                                p3 = ""
                                activeTF = .p3
                            }
                            
                        } label: {
                            Image(systemName: "delete.left").frame(width: UIScreen.main.bounds.width / 3).frame(height: 100)
                        }
                        
                        Button {
                            numpadAction("0")
                        } label: {
                            Text("0").frame(width: UIScreen.main.bounds.width / 3).frame(height: 100)
                        }
                        
                        
                    }
                    

                }.padding(.top,100).foregroundColor(.white) // NUMPAD
                
            }
        }
        
        
    }
    
    func isPassValid(){
        if fullPassword.isEmpty {
            print("password empty")
        }
        if realPassword == fullPassword {
            passCorrect = true
        } else {
            print("WrongPassword")
            incorrectPassword.toggle()
            resetFields()
            
        }
        
    }
    func resetFields() {
        p1 = ""
        p2 = ""
        p3 = ""
        p4 = ""
        activeTF = .p1
        
    }
    
    func numpadAction(_ digit: String) {
        if activeTF == .p1 {
            p1 += digit
        } else if activeTF == .p2 {
            p2 += digit
        } else if activeTF == .p3 {
            p3 += digit
        } else if activeTF == .p4 {
            p4 += digit
        }
    }
}

#Preview {
    ContentView().preferredColorScheme(.dark)
}

