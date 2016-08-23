# ImagizerSwift
The official Swift client for the ImagizerEngine

## Installation for Cocoapods
```ruby
# For latest release in cocoapods
pod 'ImagizerSwift'
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
