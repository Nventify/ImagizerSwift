# ImagizerSwift
The official Swift client for the Imagizer Media Engine

The Imagizer Media Engine accelerates media delivery to your mobile Apps or Webpages by dynamically rescaling, cropping, and compressing images in real time. See all Imagizer features in our [doc](http://demo.imagizercdn.com/doc/).


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
Using the free to test Imagizer Demo Service

```swift
// Import the ImagizerSwift framework
import ImagizerSwift

// Initialize the Imagizer Client
let imagizerClient = ImagizerClient()

// Since we are using Imagizer Engine Demo Service
// we'll need to specify our Image storage origin
// Imagizer will fetch your images from this endpoint
imagizerClient.originImageHost = "example.com"

// Enable Auto device pixel ratio setting.
// Device pixel ratio will now be detected
// and automatically applied to image urls
imagizerClient.autoDpr = true

// Build a URL with resize and cropping params
// http://example.com/image.jpg?width=400&height=400&crop=fit&dpr=2&hostname=example.com
let imageUrl1 = imagizerClient.buildUrl("image.jpg", params: [
  "width": 400, 
  "height": 500,
  "crop": "fit"
])

// Build url with compression 
// http://example.com/image.jpg?quality=55&hostname=example.com
let imageUrl2 = imagizerClient.buildUrl("image.jpg", params: [
  "quality": 55
])
```

Using your own Imagizer Instance
``` swift
// Import the ImagizerSwift framework
import ImagizerSwift

// Initialize the Imagizer Client
let imagizerClient = ImagizerClient(host: "example.com")

// Enable Auto device pixel ratio setting.
// Device pixel ratio will now be detected
// and automatically applied to image urls
imagizerClient.autoDpr = true

// Build a URL with resize and cropping params
// http://example.com/image.jpg?width=400&height=400&crop=fit&dpr=2
let imageUrl1 = imagizerClient.buildUrl("image.jpg", params: [
  "width": 400, 
  "height": 500,
  "crop": "fit"
])

// Build url with compression 
// http://example.com/image.jpg?quality=55
let imageUrl2 = imagizerClient.buildUrl("image.jpg", params: [
  "quality": 55
])
```

