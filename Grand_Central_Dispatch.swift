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


// This class encaptulates all grand central dispatch actions without having to know how the C funcions operate
class HKThreading＋ {
   
   enum ThreadDispatchModes🅔 { // used by all functions
      case Synchronous
      case Asynchronous
   }
   
   enum QueueTypes🅔 { // used by LAUNCH_THREAD_NEW_Q()
      case Concurrent
      case Serial
   }
   
   enum QueueQOS🅔: UInt { // Quality Of Service: used by LAUNCH_THREAD_GLOBAL_Q()
      case Unspecified = 0x00
      case Default = 0x15
      case Background = 0x09
      case Utility = 0x11
      case Initiated = 0x19
      case Interactive = 0x21
   }
   
   enum QueuePriorities🅔 { // used by LAUNCH_THREAD_GLOBAL_Q()
      case Default
      case Background
      case Low
      case High
   }
   
   
   // launhes process thread in main queue, with options for synchronicity and delay. bodyƒ() is the closure with the thread code
   class func LAUNCH_THREAD_MAIN_Q(dispatchMode🅔 dispatchMode🅔: ThreadDispatchModes🅔 = .Asynchronous, delayInSeconds＃: NSTimeInterval? = nil, bodyƒ: () -> (), completionƒ: (() -> ())? = nil) {
      if delayInSeconds＃.isNilⓑ() { if dispatchMode🅔 == .Synchronous { dispatch_sync(dispatch_get_main_queue()) { bodyƒ(); completionƒ?() } } else { dispatch_async(dispatch_get_main_queue()) { bodyƒ(); completionƒ?() } }
      } else { dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds＃!*Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { bodyƒ(); completionƒ?() } }
   }
   
   // launches a precess thread in a new specified queue with options for synchronicity, queue type, and delay
   class func LAUNCH_THREAD_NEW_Q(dispatchMode🅔 dispatchMode🅔: ThreadDispatchModes🅔 = .Asynchronous, queueType🅔: QueueTypes🅔, queueName$: String, delayInSeconds＃: NSTimeInterval? = nil, bodyƒ: () -> (), completionƒ: (() -> ())? = nil) {
      var queue: dispatch_queue_t
      switch queueType🅔 {
         case .Concurrent: queue = dispatch_queue_create(queueName$, DISPATCH_QUEUE_CONCURRENT)
         case .Serial:  queue = dispatch_queue_create(queueName$, DISPATCH_QUEUE_SERIAL)
      }
      if delayInSeconds＃.isNilⓑ(){ if dispatchMode🅔 == .Synchronous { dispatch_sync(queue) { bodyƒ(); completionƒ } } else { dispatch_async(queue) { bodyƒ(); completionƒ } }
      } else { dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds＃!*Double(NSEC_PER_SEC))), queue) { bodyƒ(); completionƒ?() } }
   }
   
   // launches a precess thread in a new specified queue with options for synchronicity, priority, quality of service, and delay
   class func LAUNCH_THREAD_GLOBAL_Q(dispatchMode🅔 dispatchMode🅔: ThreadDispatchModes🅔 = .Asynchronous, priority🅔: QueuePriorities🅔? = .Default, qualityOfService🅔: QueueQOS🅔? = nil, delayInSeconds＃: NSTimeInterval? = nil, bodyƒ: () -> (), completionƒ: (() -> ())? = nil ) {
      var queue: dispatch_queue_t
      switch priority🅔! {
         case .Default: if qualityOfService🅔 == nil { queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0) } else { queue = dispatch_get_global_queue(Int(qualityOfService🅔!.rawValue), 0) }
         case .Background: queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)
         case .Low: queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
         case .High: queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
      }
      if delayInSeconds＃.isNilⓑ() { if dispatchMode🅔 == .Synchronous { dispatch_sync(queue) { bodyƒ(); completionƒ?() } } else { dispatch_async(queue) { bodyƒ(); completionƒ?() } }
      } else { dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds＃!*Double(NSEC_PER_SEC))), queue) { bodyƒ(); completionƒ?() } }
   }
   
}


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
