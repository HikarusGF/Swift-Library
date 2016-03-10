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

extension UIViewController {
   
   // set the UIViewController instance to tune to or stop tuning to a specified notification
   func observe(notification$ notification$: String, handlerƒ$: Selector, sender🅞: AnyObject? = nil) { // if the handler has parameters its name must be suffixed with ":"
      NSNotificationCenter.defaultCenter().addObserver(self, selector: handlerƒ$, name: notification$, object: sender🅞) }
   func stopObserving(notification$ notification$: String, sender🅞: AnyObject? = nil) {  NSNotificationCenter.defaultCenter().removeObserver(self, name: notification$, object: sender🅞) }
   
   // adds to the UIView the observers for when the keyboard shows and hides
   func addKeyboardSlideObservers() {
      // must manually add functions keyboardWillShow() and keyboardWillHide() in VC's code
      NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
      NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
   }
   
   // displays an Alert
   func popMessage(title$ title$: String = "", message$: String, buttonText$: String = "Ok", buttonStyle🅔: UIAlertActionStyle = .Default, buttonHandlerƒ: ((UIAlertAction) -> ())? = nil, completionƒ: (() -> ())? = nil) {
      let alertController🅞 = UIAlertController(title: title$, message: message$, preferredStyle: .Alert)
      alertController🅞.addAction(UIAlertAction(title: buttonText$, style: buttonStyle🅔, handler: buttonHandlerƒ))
      self.presentViewController(alertController🅞, animated: YES, completion: completionƒ)
   }
   
   // displays an Alert configurable with up to 3 buttons
   func popMessageWithOptions(title$ title$: String = "", message$: String, button1Text$: String, button1Style🅔: UIAlertActionStyle = .Default, button1Handlerƒ: ((UIAlertAction) -> ())? = nil, button2Text$: String? = nil, button2Style🅔: UIAlertActionStyle? = nil, button2Handlerƒ: ((UIAlertAction) -> ())? = nil, button3Text$: String? = nil, button3Style🅔: UIAlertActionStyle? = nil, button3Handlerƒ: ((UIAlertAction) -> ())? = nil, completionƒ: (() -> ())? = nil) {
      // UIAlertActionStyle Sets the color and position of the option: .Default = (egrular blue, fifo from top)  | .Destructive = (regular red, fifo from top)  |  .Cancel = (bold blue, bottom)
      let alertController🅞 = UIAlertController(title: title$, message: message$, preferredStyle: .Alert)
      alertController🅞.addAction(UIAlertAction(title: button1Text$, style: button1Style🅔, handler: button1Handlerƒ))
      if button2Text$.isNotNilⓑ() && button2Style🅔.isNotNilⓑ() { alertController🅞.addAction(UIAlertAction(title: button2Text$!, style: button2Style🅔!, handler: button2Handlerƒ)) }
      if button3Text$.isNotNilⓑ() && button3Style🅔.isNotNilⓑ() { alertController🅞.addAction(UIAlertAction(title: button3Text$!, style: button3Style🅔!, handler: button3Handlerƒ)) }
      self.presentViewController(alertController🅞, animated: YES, completion: completionƒ)
   }
   
   // displays an alert with a text field for user input
   func requestUserInput$(title$ title$: String = "", message$: String, buttonStyle🅔: UIAlertActionStyle = .Default, textPlaceholder$: String? = nil, inout outputVariable$: String, inputHandlerƒ: (handleVariable$: String) -> (), completionƒ: (() -> ())? = nil) {
      // must operate with the userInput within the optionHandler: HKUI🅞.requestUserInput(..., inputHandlerƒ: { userInput$ in print("\n USER INPUT = \(userInput$)") })
      let alertController🅞 = UIAlertController(title: title$, message: message$, preferredStyle: .Alert)
      alertController🅞.addTextFieldWithConfigurationHandler { textField🅞 in textField🅞.textAlignment = .Center; if textPlaceholder$.isNotNilⓑ() { textField🅞.placeholder = textPlaceholder$ } }
      alertController🅞.addAction(UIAlertAction(title: "Ok", style: buttonStyle🅔, handler: { alertAction in
         outputVariable$ = alertController🅞.textFields!.first!.text!
         inputHandlerƒ(handleVariable$: outputVariable$)
      }))
      alertController🅞.addAction(UIAlertAction(title: "Cancel", style: buttonStyle🅔, handler: nil))
      self.presentViewController(alertController🅞, animated: YES, completion: completionƒ)
   }
   
   // displays an ActionSheet (slides up from the bottom) configurable with up to 3 buttonss
   func slideMessageWithOptions(title$ title$: String = "", message$: String, button1Text$: String, button1Style🅔: UIAlertActionStyle = .Default, button1Handlerƒ: ((UIAlertAction) -> ())? = nil, button2Text$: String? = nil, button2Style🅔: UIAlertActionStyle? = nil, button2Handlerƒ: ((UIAlertAction) -> ())? = nil, button3Text$: String? = nil, button3Style🅔: UIAlertActionStyle? = nil, button3Handlerƒ: ((UIAlertAction) -> ())? = nil, completionƒ: (() -> ())? = nil) {
      // UIAlertActionStyle Sets the color and position of the button: .Default = (egrular blue, fifo from top)  | .Destructive = (regular red, fifo from top)  |  .Cancel = (bold blue, bottom)
      let alertController🅞 = UIAlertController(title: title$, message: message$, preferredStyle: .ActionSheet)
      alertController🅞.addAction(UIAlertAction(title: button1Text$, style: button1Style🅔, handler: button1Handlerƒ))
      if button2Text$.isNotNilⓑ() && button2Style🅔.isNotNilⓑ() { alertController🅞.addAction(UIAlertAction(title: button2Text$!, style: button2Style🅔!, handler: button2Handlerƒ)) }
      if button3Text$.isNotNilⓑ() && button3Style🅔.isNotNilⓑ() { alertController🅞.addAction(UIAlertAction(title: button3Text$!, style: button3Style🅔!, handler: button3Handlerƒ)) }
      self.presentViewController(alertController🅞, animated: YES, completion: completionƒ)
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

----------------------------------------------------------------------------------------------------------------- */
