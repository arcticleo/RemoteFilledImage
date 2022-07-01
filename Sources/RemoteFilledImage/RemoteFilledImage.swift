import SwiftUI

public enum AspectRatio: CGFloat {
    case square = 1
    case threeToFour = 0.75
    case fourToThree = 1.75
    case sixteenToNine = 1.78
    case fiveToThree = 1.67
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

public struct RemoteFilledImage: View {
    let imageURL: String
    let aspectRatio: AspectRatio

    public init(imageURL: String, aspectRatio: AspectRatio) {
        self.imageURL = imageURL
        self.aspectRatio = aspectRatio
    }
    
    public var body: some View {
        Group {
            AsyncImage(url: URL(string: imageURL), scale: aspectRatio.rawValue) { image in
                image
                    .fitToAspectRatio(aspectRatio)
            } placeholder: {
                ZStack {
                    Image("gray.fill")
                        .fitToAspectRatio(aspectRatio)
                    ProgressView()
                }
            }
            .clipped()
        }
    }
}
