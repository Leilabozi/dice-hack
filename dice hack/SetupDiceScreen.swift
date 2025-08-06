import SwiftUI

enum Screen {
    case start
    case setupDice
    case roll
}

struct SetupDiceScreen: View {
    var onNext: ([DiceSide]) -> Void
    @Binding var diceSides: [DiceSide]
    
    // Define 2 columns grid
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // Computed property to check if all dice sides have text
    private var allSidesHaveText: Bool {
        diceSides.allSatisfy { !$0.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }
    
    var body: some View {
            VStack(spacing: 20) {
                // Clean, productivity-focused header
                VStack(spacing: 8) {
                    Text("Configure Your Dice")
                        .font(.system(size: 28, weight: .bold, design: .default))
                        .foregroundColor(.prodPrimary)
                        .multilineTextAlignment(.center)
                    
                    Text("Define what each side represents")
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .foregroundColor(.prodPrimary.opacity(0.7))
                        .multilineTextAlignment(.center)
                }
                .padding(.top)
                
                // Dice sides in a clean grid
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach($diceSides) { $diceSide in
                        HStack(spacing: 12) {
                            diceSide.image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48, height: 48)
                                .shadow(color: .prodShadow.opacity(0.1), radius: 4, x: 0, y: 2)
                            
                            CustomPlaceholderTextField(text: $diceSide.text, placeholder: "Enter option...")
                                .foregroundColor(.prodText)
                                .padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.prodCard)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(diceSide.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? Color.prodError : Color.prodSuccess, lineWidth: 1.5)
                                        )
                                )
                        }
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.prodCard)
                                .shadow(color: .prodShadow.opacity(0.08), radius: 6, x: 0, y: 3)
                        )
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Clean, modern button
                Button(action: {
                    onNext(diceSides)
                }) {
                    Text("Continue")
                        .font(.system(size: 18, weight: .semibold, design: .default))
                        .padding(.horizontal, 40)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(allSidesHaveText ? Color.prodSuccess : Color.prodTextLight.opacity(0.3))
                                .shadow(color: .prodShadow.opacity(0.1), radius: 8, x: 0, y: 4)
                        )
                        .foregroundColor(.white)
                }
                .disabled(!allSidesHaveText)
                .buttonStyle(PlainButtonStyle())
                .padding(.bottom)
            }
            .frame(width: 450, height: 450)
            .background(Color.prodBackground)
        }
    }
