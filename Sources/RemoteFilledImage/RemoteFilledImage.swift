import SwiftUI

public enum AspectRatio: CGFloat {
    case sixteenToNine = 1.78
    case fiveToThree = 1.67
    case fourToThree = 1.33
    case square = 1
    case threeToFour = 0.75
    case threeToFive = 0.6
    case nineToSixteen = 0.56
}

public struct FitToAspectRatio: ViewModifier {
    private let aspectRatio: CGFloat
    
    public init(_ aspectRatio: CGFloat) {
        self.aspectRatio = aspectRatio
    }
    
    public init(_ aspectRatio: AspectRatio) {
        self.aspectRatio = aspectRatio.rawValue
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            Rectangle()
                .fill(Color(.clear))
                .aspectRatio(aspectRatio, contentMode: .fit)
            content
                .scaledToFill()
                .layoutPriority(-1)
        }
        .clipped()
    }
}

public extension Image {
    func fitToAspectRatio(_ aspectRatio: CGFloat) -> some View {
        self.resizable().modifier(FitToAspectRatio(aspectRatio))
    }
    
    func fitToAspectRatio(_ aspectRatio: AspectRatio) -> some View {
        self.resizable().modifier(FitToAspectRatio(aspectRatio))
    }
}

struct PlaceholderView: View {
    let aspectRatio: AspectRatio
    var body: some View {
        ZStack {
            Image("gray.fill")
                .fitToAspectRatio(aspectRatio)
            ProgressView()
        }
    }
}

struct RemoteFilledImage<Placeholder: View>: View {
    let imageURL: String
    let aspectRatio: AspectRatio
    let placeholder: () -> Placeholder
    
    // Initializer with custom placeholder
    init(imageURL: String, aspectRatio: AspectRatio, @ViewBuilder placeholder: @escaping () -> Placeholder) {
        self.imageURL = imageURL
        self.aspectRatio = aspectRatio
        self.placeholder = placeholder
    }
    
    // Initializer with default placeholder
    init(imageURL: String, aspectRatio: AspectRatio) where Placeholder == PlaceholderView {
        self.imageURL = imageURL
        self.aspectRatio = aspectRatio
        self.placeholder = { PlaceholderView(aspectRatio: aspectRatio) }
    }
    
    public var body: some View {
        Group {
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .empty:
                    placeholder()
                case .success(let image):
                    image
                        .fitToAspectRatio(aspectRatio)
                case .failure:
                    placeholder()
                @unknown default:
                    placeholder()
                }
            }
            .clipped()
        }
    }
}
