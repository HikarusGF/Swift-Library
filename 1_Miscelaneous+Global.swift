/*
                             .-----------------------------------------------------------------------------.
                           /  .-.                                                                      .-.  \
                          |  /   \    Hikarus Guijarro-Fayard - iOS developer specialized in Swift    /   \  |
                          | |\_.  |                     http://ikiteruningen.net                     |    /| |
                          |\|  | /|                 https://github.com/ikiteruningen                 |\  | |/|
                          | `---' |                                                                  | `---' |
                          \       |------------------------------------------------------------------|       /
                           \     /                                                                    \     /
                            `---'                                                                      `---'
*/

// I use these for clarity and linguistical consitency in some of my functions although I've removed them from the sample codes in GitHub
let YES = true
let NO = false

// returns the application path. Very useful for reading the CoreData SQLite file with another app and DEBUG CoreData processes
var applicationPath$: String { return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] }

// experiment with an operator for the function pow(): 2**3 = 8
infix operator **{ associativity left precedence 160 } // ⬆︎⌥D
func **(base＃: Double, power＃: Double) -> Double { return pow(base＃, power＃) }
// experiment with square root operator: √9 = 3
prefix operator √{} // ⌥V : can be used just √X without ()
prefix func √ (number: Double) -> Double { return sqrt(number) }

// interesting EXPERIMENTAL operator and function to create a pointer to value-types
func ~<T> (pointer: UnsafeMutablePointer<T>, newValue: T ) { pointer.memory = newValue }
func pointerTo<T>(inout object🅞: T) -> UnsafeMutablePointer<T> { return withUnsafeMutablePointer(&object🅞) {UnsafeMutablePointer<T>($0) } }

// This is another presonal preference. This one is all over my code
extension Optional {
   func isNotNilⓑ() -> Bool { return self != nil }
   func isNilⓑ() -> Bool { return self == nil }
}


class HK＋ {
   
   // returns the type-name of ANY variable, including value-types
   class func getTypeName$<T>(object$﹖: T) -> String { return String(object$﹖.dynamicType) }
   
   /*
   VERY USEFUL: The next 3 functions handle notifications
   to post and register or unregister as observer of a scpedific notification
   */
   func postNotification(notification$ notification$: String, sender🅞: AnyObject? = nil) {  NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: notification$, object: sender🅞)) }
   func registerObserver(observer🅞 observer🅞: AnyObject, handlerƒ$: Selector, notification$: String, sender🅞: AnyObject? = nil) { // if the handler has parameters its name must be suffixed with ":"
      NSNotificationCenter.defaultCenter().addObserver(observer🅞, selector: handlerƒ$, name: notification$, object: sender🅞) }
   func unregisterObserver(Oobserver🅞 observer🅞: AnyObject, notification$: String, sender🅞: AnyObject? = nil) {  NSNotificationCenter.defaultCenter().removeObserver(observer🅞, name: notification$, object: sender🅞) }
   
   // self-explanatory
   static var deviceLanguage$＋: String { get { return NSLocale.currentLocale().objectForKey(NSLocaleLanguageCode) as! String } }
   static var deviceCountry$＋: String { get { return  NSLocale.currentLocale().objectForKey(NSLocaleCountryCode) as! String } }
}

// returns the class name of reference-type variables: any descendent of NSObject
extension NSObject { var className$: String { return self.dynamicType.description().componentsSeparatedByString(".").last!.removeCharacter$("_") } }



/* VARIABLE-TYPE SUFFIX CRITERION ------------------------------------------------------------------------------------------

I've built a custom keyboard layout to include these suffix I find very useful in my code
Some characters like { ＃ ＋ ﹙﹚ ﹖ ﹫} have resemblance to the standard pound, plus, parenthesis, question mark, At-Sign...
but are really alternate ASCII characters that can perfectly be used in Swift code

you can of course remove them from the code :)

Boolean              ⓑ
String               $
number               ＃
Int                  ＃i
Float                ＃f
Double               ＃d
CGFloat              ⓖ
CGPoint              ⓖ²    2 dimensional CGFloats
CGRect               ⓖ⁴    4 dimensional CGFloats
Binary/Data          ß     For NSData, and images or videos in CoreData
Core Image           ⓘ
NSDate               ㊐
Object               🅞
Tuple                🅣
Array                🅐
Set                  ...     ? not sure about this one...
Dictionary           🅓
Enumeration          🅔
Structure            🅢
Library Class        ＋     (suffix)
Additive parameter   ＋     (prefix)
Complex Structure    ﹙﹚
Undetermined         ﹖     for Undetermined types: Optional or AnyObject
Implicitly unwrapped ﹗
Protocol             Ⓟ
Function             ƒ
Pointer              ⓟ⃗
PhotoAsset           ⓐ
Collection           🅒
URL                  🅤
IBOutlets            ﹫

Example: an array of dictionaries with a string key which value is a tuple of an enum and a number
myVariable＃🅔🅣$🅓🅐

-------------------------------------------------------------------------------------------------------------------- */
