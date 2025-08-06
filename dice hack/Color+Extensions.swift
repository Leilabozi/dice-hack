import SwiftUI

extension Color {
    // Custom initializer to create Color from hex string
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }
        
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        let r, g, b: Double
        if hex.count == 7 {
            r = Double((color & 0xFF0000) >> 16) / 255
            g = Double((color & 0x00FF00) >> 8) / 255
            b = Double(color & 0x0000FF) / 255
        } else {
            r = 0; g = 0; b = 0
        }
        
        self.init(red: r, green: g, blue: b)
    }
    
    // Productivity-focused purple color palette
    static let prodBackground = Color(hex: "#FAFAFA")      // Clean white background
    static let prodCard = Color(hex: "#FFFFFF")            // Pure white cards
    static let prodPrimary = Color(hex: "#6366F1")         // Main purple
    static let prodSecondary = Color(hex: "#8B5CF6")       // Secondary purple
    static let prodAccent = Color(hex: "#A855F7")          // Accent purple
    static let prodText = Color(hex: "#1F2937")            // Dark gray text
    static let prodTextLight = Color(hex: "#6B7280")       // Light gray text
    static let prodSuccess = Color(hex: "#10B981")         // Green for success
    static let prodError = Color(hex: "#EF4444")           // Red for errors
    static let prodBorder = Color(hex: "#E5E7EB")          // Light gray borders
    static let prodShadow = Color(hex: "#000000")          // Black for shadows
}
