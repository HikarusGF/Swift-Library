# Swift-Library
### Abstraction layer/framework with extensions for many classes and types

As I was working on my project "Rendezvous" (a social app for sharing events) I realized that many basic operations require a tedious utilization of a number of Swift, Objective-C, and C API functions that in certain cases did not seem to follow a logical paradigm. I decided to encapsulate those operations in class extensions and custom classes in order to make my main code more synthesized, readable, abstract and efficient. Overall I've built around 150 functions some of which I include in this repository for public contribution. _This is my first repository on GitHub. Although I have 23 programming experience I took a break of 6 years to manage a business and recently came back to this industry specializing in iOS with Swift._

**EXTENSIONS**  
* Int: Date-component conversion properties, random...
- Double, Float, CGFloat, CGRect: Currency format & truncation
-String: Many functions we all wish Swift included out of the box
-Array: Subindexes and operations for LIFO & FIFO stacks
-UIView: Functions to quickly set appearance, frame & coordinates. Rasterize to Image & UIImage, manage subViews
          Finding firstResponder, sliding animations for keyboard, blink, fade...
-UIViewController: Send and listen for notifications. Using Alerts & ActionSheets with 4 simple functions
-UIColor: 3xRGB Int initializer, 6-digit hexCode Initializer, randomColor
-UIImage: Scale to size or factor
-NSDate: 3xInteger Init. Custom operators & functions for many NSDate operations & component extraction. String formats.
-PhotoLibraryObserver, PHFetchResult
-CoreData (NSManagedObjectContext, NSManagedObject): Encapsulates main Core Data operations
-MKMapView: Find points of interest & set pins, center around pins, create pins with longPress, set pin appearance, fetch pin address,
             track user movement & draw polyline, remove pins
-CLLocationManagerDelegate: activate & deactivate tracking

**CUSTOM CLASSES**  
-UIView animations: Very simple function to chain up to 3 animations with all parameters
-Grand Central Dispatch: layer of abstraction with all possible threads and queues in 3 simple functions
-NSDate Operators
-Photo Album Lists & Photo Albums: With functions to load albums & pictures
-NSUserDefaults: Read & write with type-specific functions to save the casting
-Location: Encapsulates name, coordinate, and reverse geocoding info (address).
            Instance methods to fech all info, request user authorization
            
**SUBCLASSES**  
-MKMapView
-UIWebView

**OTHER FUNCTIONS & EXPERIMENTS**  
-Application Path
-Pointer to any type
-√ and ** operators
-Type or class name in String format
-Properties for device language & country
  
  
