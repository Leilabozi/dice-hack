import SwiftUI

struct CustomPlaceholderTextField: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color.prodTextLight.opacity(0.6))
                    .font(.system(size: 14, weight: .medium, design: .default))
                    .padding(.leading, 4)
            }
            TextField("", text: $text)
                .foregroundColor(.prodText)
                .font(.system(size: 14, weight: .medium, design: .default))
                .padding(4)
        }
    }
}


