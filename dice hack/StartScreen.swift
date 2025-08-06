import SwiftUI

struct StartScreen: View {
    var onStart: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
                .frame(height: 150) // 1/3 of 450 frame
            
            // Clean, productivity-focused title
            VStack(spacing: 16) {
                Text("DiceHack")
                    .font(.system(size: 44, weight: .bold, design: .default))
                    .foregroundColor(.prodPrimary)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("make decisions • stay productive")
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .foregroundColor(.prodPrimary.opacity(0.7))
                    .frame(maxWidth: .infinity, alignment: .center)
            }

            Spacer()

            // Clean, modern button
            Button(action: onStart) {
                Text("Get Started")
                    .font(.system(size: 18, weight: .semibold, design: .default))
                    .padding(.horizontal, 40)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.prodPrimary)
                            .shadow(color: .prodShadow.opacity(0.1), radius: 8, x: 0, y: 4)
                    )
                    .foregroundColor(.white)
            }
            .buttonStyle(PlainButtonStyle())

            Spacer()
        }
        .frame(width: 450, height: 450)
        .background(Color.prodBackground)
    }
}
