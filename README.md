# RemoteFilledImage

SwiftUI utility view for loading an async remote image in a container of a set aspect ratio.

Thanks to [Kari Grooms' great write-up](https://medium.com/expedia-group-tech/resizing-images-in-swiftui-e65ced420b81).

## Usage

Example:

```swift
RemoteFilledImage(imageURL: "https://picsum.photos/id/1062/500", aspectRatio: .sixteenToNine)
```

A custom placeholder can be provided in a trailing closure:

```swift
RemoteFilledImage(imageURL: imageURL, aspectRatio: .fourToThree) {
    ZStack {
        Image("gray.fill")
            .fitToAspectRatio(.fourToThree)
        Color.gray
        ProgressView()
    }
}
```

## Aspect Ratios

Allowed `aspectRatio` values are:

- sixteenToNine
- fiveToThree
- fourToThree
- square
- threeToFour
- threeToFive
- nineToSixteen

If neither of these work, it is also allowed to pass in a `CGFloat` value.
