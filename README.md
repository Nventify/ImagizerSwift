# ImagizerSwift
The official Swift client for the ImagizerEngine

## Installation for [Cocoapods](https://github.com/CocoaPods/CocoaPods)
```ruby
use_frameworks!

target 'MyApp' do
  pod 'ImagizerSwift'
end
```

## Installation for [Carthage](https://github.com/Carthage/Carthage)
```
github "Nventify/ImagizerSwift"
```

## Usage

```swift
// Import the ImagizerSwift framework
import ImagizerSwift

// Initialize the Imagizer Client
let imagizerClient = ImagizerClient(host: "example.com")

// Build a URL with params
// http://example.com/image.jpg?width=400&height=400&crop=fit
imagizerClient.buildUrl("image.jpg", params: [
  "width": 400, 
  "height": 500,
  "crop": "fit"
])
```
