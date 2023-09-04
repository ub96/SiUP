import SwiftUI
import UIKit

private enum Status: String {
    case error = "An error has occured, If this happens again then the tweak may not work anymore"
    case notStarted = "Not doing anything rn..."
    case success = "The tweak was sucessfully downloaded"
    case waiting = "Searching our database for your tweak... This shouldn't take long"
}

private struct VisualEffectView: UIViewRepresentable {
    let effect: UIVisualEffect?
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = effect
    }
}

struct ErikaView: View {
    @State var package: String
    @State var version: String
    
    @State private var status: Status = .notStarted
    @State private var progress: String = ""
    
    var body: some View {
        ZStack {
            if #available(iOS 16, *) {
                Color.black
                    .opacity(0.7)
                    .background(.ultraThinMaterial)
            } else {
                VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
            }
            
            VStack {
                Text(status.rawValue)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Text(status != .notStarted ? progress : "\(CurrentTweak.displayName) \(version)")
                    .padding()
                    .foregroundColor(.white)
                
                if status != .error {
                    Button(status == .notStarted ? "Download" : "Get Zappy", action: status == .notStarted ? download : getZappy)
                        .foregroundColor(.white)
                        .padding()
                        .frame(minWidth: 180, minHeight: 70)
                        .buttonStyle(.plain)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                        .padding()
                        .disabled(status == .waiting)
                        .opacity(status == .waiting ? 0.5 : 1.0)
                }
                
                Button("Don't Get Zappy", action: dontGetZappy)
                    .foregroundColor(.white)
                    .padding()
                    .frame(minWidth: 180, minHeight: 70)
                    .buttonStyle(.plain)
                    .background(Color.red)
