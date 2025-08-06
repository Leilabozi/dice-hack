import SwiftUI

struct RollScreen: View {
    var diceSides: [DiceSide]
    var onRollAgain: () -> Void
    
    @State private var currentDiceImage: Image = Image("1")
    @State private var isRolling = false
    @State private var rollResult: Int?
    @State private var showResult = false
    @State private var animationCount = 0
    @State private var showPopup = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                // Header with back button
                HStack {
                    Button(action: {
                        onRollAgain()
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                            Text("Back to Edit")
                                .font(.system(size: 16, weight: .medium, design: .default))
                        }
                        .foregroundColor(.prodTextLight)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                
                // Clean, productivity-focused header
                VStack(spacing: 8) {
                    Text("Roll the Dice")
                        .font(.system(size: 28, weight: .bold, design: .default))
                        .foregroundColor(.prodPrimary)
                        .multilineTextAlignment(.center)
                    
                    Text("Let the dice decide")
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .foregroundColor(.prodPrimary.opacity(0.7))
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                // Centered dice display
                currentDiceImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                    .shadow(color: .prodShadow.opacity(0.15), radius: 8, x: 0, y: 4)
                    .scaleEffect(isRolling ? 1.1 : 1.0)
                    .rotation3DEffect(
                        .degrees(isRolling ? 360 : 0),
                        axis: (x: 1, y: 1, z: 0)
                    )
                    .animation(
                        isRolling ? 
                        Animation.easeInOut(duration: 0.3)
                            .repeatCount(10, autoreverses: true) : 
                        .default,
                        value: isRolling
                    )
                
                Spacer()
                
                // Clean, modern button
                Button(action: {
                    if showResult {
                        // Reset and roll again instead of going back
                        showResult = false
                        rollResult = nil
                        showPopup = false
                        rollDice()
                    } else {
                        rollDice()
                    }
                }) {
                    Text(isRolling ? "Rolling..." : (showResult ? "Roll Again" : "Roll"))
                        .font(.system(size: 18, weight: .semibold, design: .default))
                        .padding(.horizontal, 40)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(isRolling ? Color.prodTextLight.opacity(0.3) : (showResult ? Color.prodSecondary : Color.prodPrimary))
                                .shadow(color: .prodShadow.opacity(0.1), radius: 8, x: 0, y: 4)
                        )
                        .foregroundColor(.white)
                }
                .disabled(isRolling)
                .buttonStyle(PlainButtonStyle())
                .padding(.bottom)
            }
            .frame(width: 450, height: 450)
            .background(Color.prodBackground)
            
            // Clean popup result overlay
            if showPopup, let result = rollResult, result > 0, result <= diceSides.count {
                Color.prodShadow.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showPopup = false
                    }
                
                VStack(spacing: 24) {
                    Text("Time to take action")
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .foregroundColor(.prodPrimary.opacity(0.7))
                    
                    // Show dice image instead of number
                    Image("\(result)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .shadow(color: .prodShadow.opacity(0.2), radius: 8, x: 0, y: 4)
                    
                    Text(diceSides[result - 1].text.isEmpty ? "No option set" : diceSides[result - 1].text)
                        .font(.system(size: 20, weight: .medium, design: .default))
                        .foregroundColor(.prodPrimary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button(action: {
                        showPopup = false
                    }) {
                        Text("Close")
                            .font(.system(size: 16, weight: .semibold, design: .default))
                            .padding(.horizontal, 32)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.prodPrimary)
                            )
                            .foregroundColor(.white)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(32)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.prodCard)
                        .shadow(color: .prodShadow.opacity(0.2), radius: 20, x: 0, y: 10)
                )
                .padding(40)
                .transition(.scale.combined(with: .opacity))
                .animation(.spring(response: 0.6, dampingFraction: 0.8), value: showPopup)
            }
        }
    }
    
    private func rollDice() {
        isRolling = true
        showResult = false
        showPopup = false
        animationCount = 0
        
        // Animate through random dice faces
        _ = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            let randomFace = Int.random(in: 1...6)
            currentDiceImage = Image("\(randomFace)")
            animationCount += 1
            
            if animationCount >= 10 {
                timer.invalidate()
                finishRoll()
            }
        }
    }
    
    private func finishRoll() {
        // Final random result
        let finalResult = Int.random(in: 1...6)
        currentDiceImage = Image("\(finalResult)")
        rollResult = finalResult
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isRolling = false
            showResult = true
            showPopup = true
        }
    }
}
