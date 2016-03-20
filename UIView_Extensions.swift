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


extension UIView {
   
   // returns the main window
   var rootView: UIView { return self.window! }
   // returns an view's absolute coordinates in its superview's reference
   var absoluteOriginⓖ²: CGPoint { return self.superview!.convertPoint(self.frame.origin, toView: self.window) }
   
   // these functions are for nomenclature purposes and code clarity
   var visibleⓑ: Bool { get { return !self.hidden } set { self.hidden = !newValue } }
   var transparentⓑ: Bool { return self.alpha == 0 }
   var opacityⓖ: CGFloat { get { return self.alpha } set { self.alpha = newValue } }
   var opaqueⓑ: Bool { return self.alpha != 0 }
   func transparent() { self.alpha = 0 }
   func opaque() { self.alpha = 1 }
   
   // returns the application's firstResponder is applied to the root view or window
   var activeControl🅞: UIResponder? { return self.findActiveControl🅞() }
   private func findActiveControl🅞() -> UIResponder? {
      if self.isFirstResponder() { return self }
      for subView in self.subviews { if let responder = subView.findActiveControl🅞() { return responder } }
      return nil
   }
   
   /*
   This function takes parameters to set a view's frame. Ommited parameter will keep their value
   Boolean "additive parameters" indicate whether the value should replace the current or be added to it
   I've included this function as an extension of UIView as well with the name setFrame()
   */
   func setFrame(xⓖ xⓖ: CGFloat? = nil, ＋Xⓑ: Bool = false, yⓖ: CGFloat? = nil, ＋Yⓑ: Bool = false, widthⓖ: CGFloat? = nil, ＋Wⓑ: Bool = false, heightⓖ: CGFloat? = nil, ＋Hⓑ: Bool = false) {
      var _xⓖ: CGFloat, _yⓖ: CGFloat, _widthⓖ : CGFloat, _heightⓖ: CGFloat
      _xⓖ = xⓖ.isNilⓑ() ? self.frame.origin.x : ( ＋Xⓑ ? self.frame.origin.x + xⓖ! : xⓖ! )
      _yⓖ = yⓖ.isNilⓑ() ? self.frame.origin.y : ( ＋Yⓑ ? self.frame.origin.y + yⓖ! : yⓖ! )
      _widthⓖ = widthⓖ.isNilⓑ() ? self.frame.width : ( ＋Wⓑ ? self.frame.width + widthⓖ! : widthⓖ! )
      _heightⓖ = heightⓖ.isNilⓑ() ? self.frame.height : ( ＋Hⓑ ? self.frame.height + heightⓖ! : heightⓖ! )
      self.frame = CGRectMake(_xⓖ, _yⓖ, _widthⓖ, _heightⓖ)
   }
   
   // centers the view with respect to an object's frame's center, independently of the relative size of both objects
   func centerInObjectFrame(object﹖ object﹖: AnyObject) {
      if let castView🅞 = object﹖ as? UIView {
         let containerFrameⓖ⁴ = castView🅞.frame
         let Wⓖ = containerFrameⓖ⁴.width, Hⓖ = containerFrameⓖ⁴.height
         var wⓖ = self.frame.width, hⓖ = self.frame.height
         if wⓖ > Wⓖ || hⓖ > Wⓖ {
            let wExcessⓖ = wⓖ - Wⓖ, hExcessⓖ = hⓖ - Wⓖ
            if wExcessⓖ > hExcessⓖ {
               let scaleFactorⓖ = wⓖ / Wⓖ
               wⓖ = Wⓖ
               hⓖ = hⓖ / scaleFactorⓖ
            } else {
               let scaleFactorⓖ = hⓖ / Hⓖ
               hⓖ = Hⓖ
               wⓖ = wⓖ / scaleFactorⓖ
            }
         }
         self.frame = CGRect(x: (Wⓖ - wⓖ) / 2, y: (Hⓖ - hⓖ) / 2, width: wⓖ, height: hⓖ)
      }
   }
   
   // centers the view with respect to an object's bounds
   func centerAroundObjectBounds(object﹖ object﹖: AnyObject) {
      if let castView🅞 = object﹖ as? UIView {
         let containedBoundsⓖ⁴ = castView🅞.bounds
         let wⓖ = containedBoundsⓖ⁴.width, hⓖ = containedBoundsⓖ⁴.height
         let Wⓖ = self.frame.width, Hⓖ = self.frame.height
         if Wⓖ < wⓖ || Hⓖ < hⓖ { return }
         self.frame = CGRect(x: -(Wⓖ - wⓖ) / 2, y: -(Hⓖ - hⓖ) / 2, width: Wⓖ, height: Hⓖ)
      }
   }
   
   func dismissKeyboard() { self.endEditing(true) }
   
   // next 3 functions take a SNAPSHOT of a view and its subviews and return a UIImage, UIImageView or UIView respectively
   // very useful for certain animations and effects
   func rasterizeToImage() -> UIImage {
      UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
      self.layer.renderInContext(UIGraphicsGetCurrentContext()!) // this like and the next are equivalent
      //      self.drawViewHierarchyInRect(self.bounds, afterScreenUpdates: YES)  // this like and the previous are equivalent
      let snapshot = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return snapshot
   }
   func rasterizeToImageView() -> UIImageView { return UIImageView(image: self.rasterizeToImage()) }
   func rasterizeToView() -> UIView { return self.snapshotViewAfterScreenUpdates(true) }
   
   // brings subviews to front in the order specified by the array passed
   func bringSubviewsToFront(subviews: [UIView]) { for subview in subviews { self.bringSubviewToFront(subview) } }
   
   // slide the view up to make room for the screen keyboard when the firstResponder is a UI text control that would be hidden by the keyboard
   // if the control above the keyboard height the view doesn't slide up
   func slideUpForKeyboard(keyboardNotification notification: NSNotification, duration＃: NSTimeInterval = 0.4) {
      var keyboardHeightⓖ = CGFloat()
      if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
         keyboardHeightⓖ = keyboardSize.height
         if let responder = self.activeControl🅞 as? UIView {
            if (responder.className$ == "UITextField") || (responder.className$ == "UITextView") || (responder.className$ == "HikarianUITextView") || (responder.className$ == "HikarianUITextView") {
               if responder.absoluteOriginⓖ².y + responder.frame.height >= (responder.window!.frame.height - keyboardHeightⓖ) {
                  UIView.animateWithDuration(duration＃, delay: 0, options: .CurveEaseOut, animations: { self.frame =  CGRect(x: self.frame.origin.x, y: self.frame.origin.y - keyboardHeightⓖ, width: self.frame.width, height: self.frame.height) }, completion: nil)
                  keyboardIsUpⓑ = true
               }
            }
         }
      }
   }
   
   // performs an animation where the view moves vertical or horizontally by specified amounts
   func slide(vertical verticalⓖ: CGFloat = 0, horizontalⓖ: CGFloat = 0, duration: NSTimeInterval = 0.4) { // slides a UIView by the provided offsets and with the provided duration
      UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { self.setFrame(xⓖ: self.frame.origin.x + horizontalⓖ, yⓖ: self.frame.origin.y + verticalⓖ) }, completion: nil)
   }
   
   // slide a view's subviewd up to make room for the screen keyboard when the firstResponder is a UI text control that would be hidden by the keyboard
   // if the control above the keyboard height the view doesn't slide up
   func slideSubViewsUpForKeyboard(keyboardNotification notification: NSNotification, subViews: [UIView], duration＃: NSTimeInterval = 0.4) { // this is the equivalent of theUIView extension, but slides up an array of UIView inheritants
      if keyboardIsUpⓑ { return }
      var keyboardHeightⓖ = CGFloat()
      if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
         keyboardHeightⓖ = keyboardSize.height
         if let responder = self.activeControl🅞 as? UIView {
            if (responder.className$ == "UITextField") || (responder.className$ == "UITextView") || (responder.className$ == "HikarianUITextField") || (responder.className$ == "HikarianUITextView") {
               if responder.absoluteOriginⓖ².y + responder.frame.height >= (responder.window!.frame.height - keyboardHeightⓖ) {
                  UIView.animateWithDuration(duration＃, delay: 0, options: .CurveEaseOut, animations: { for subView in subViews { subView.setFrame(yⓖ: subView.frame.origin.y - keyboardHeightⓖ) } }, completion: nil)
                  keyboardIsUpⓑ = true
               }
            }
         }
      }
   }
   // slide a view's subviews to make room for the screen keyboard
   func slideSubViews(forKeyboardⓑ forKeyboardⓑ: Bool = false,  subViews: [UIView], verticalⓖ: CGFloat = 0, horizontalⓖ: CGFloat = 0, duration＃: NSTimeInterval = 0.4) {
      if forKeyboardⓑ && !keyboardIsUpⓑ { return }
      for subView in subViews { UIView.animateWithDuration(duration＃, delay: 0, options: .CurveEaseOut, animations: { subView.setFrame(yⓖ: subView.frame.origin.y + keyboardHeightⓖ) }, completion: nil); if forKeyboardⓑ { keyboardIsUpⓑ = false } }
   }
   
   // view fades in to alpha 1
   func fadeIn(duration duration: NSTimeInterval = 1.0, delay: NSTimeInterval = 0.0, completion: ((Bool) -> Void) = { (finishedⓑ: Bool) -> Void in }) {
      UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: { self.alpha = 1.0 }, completion: completion)
   }
   // view fades out to alpha 0
   func fadeOut(duration duration＃: NSTimeInterval = 1.0, delay＃: NSTimeInterval = 0.0, completion: (Bool) -> Void = { (finishedⓑ: Bool) -> Void in }) {
      UIView.animateWithDuration(duration＃, delay: delay＃, options: UIViewAnimationOptions.CurveEaseIn, animations: { self.alpha = 0.0 }, completion: completion)
   }
   // view blinks. Useful to make certain UI components blink and draw the user attention
   // uses the 2-Phase animation in the file UIView_Animations.swift
   func blink(blinks＃: Int) { HKUI＋.animation2𝜙(iterations＃: blinks＃, 𝜙1Duration＃: 0.02,  𝜙1ƒ: { self.alpha = 0 }, 𝜙2ƒ: { self.alpha = 1 }) }
   
   // sets a view's border appearance
   func setBorderStyle(widthⓖ widthⓖ: CGFloat, color🅞: UIColor, cornerRadiusⓖ: CGFloat) {
      self.layer.borderWidth = widthⓖ
      self.layer.borderColor = color🅞.CGColor
      self.layer.cornerRadius = cornerRadiusⓖ
      self.layer.masksToBounds = true
   }
}

/* VARIABLE-TYPE SUFFIX CRITERION ----------------------------------------------------------------------------------------

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
