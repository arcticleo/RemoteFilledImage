# RemoteFilledImage

SwiftUI utility view for loading an async remote image in a container of a set aspect ratio.

Thanks to [Kari Grooms' great write-up](https://medium.com/expedia-group-tech/resizing-images-in-swiftui-e65ced420b81).

Example:

```swift
RemoteFilledImage(imageURL: "https://picsum.photos/id/1062/500", aspectRatio: .sixteenToNine)
```
