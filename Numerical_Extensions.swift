/*
					Hikarus Guijarro-Fayard - iOS developer specialized in Swift
					http://ikiteruningen.net
					https://github.com/HikarusGF
*/

extension Int {

// returns a random number within the given integer range
   static func random＃(min＃: Int = 0, max＃: Int) -> Int { return Int(arc4random_uniform(UInt32((max＃ - min＃) + 1))) + min＃ }

/*
   These properties return a tuple with a calendar unit and the integer's value
   I sued them in conjuntion with my NSDate custom operators for adding and substracting
   * see Date-Operations.swift
*/
   var years＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int) { return (NSCalendarUnit.Year, self) }
   var months＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int) { return (NSCalendarUnit.Month, self) }
   var days＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int){ return (NSCalendarUnit.Day, self) }
   var hours＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int)  { return (NSCalendarUnit.Hour, self) }
   var minutes＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int) { return (NSCalendarUnit.Minute, self) }
   var seconds＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int)  { return (NSCalendarUnit.Second, self) }
   
// alghough and integer has no decimals it's sometimes convenient to format them with .00 in currency contexts
   var formattedWith2Digits$: String { get { return String(format: "%02d", self) } }
}

extension Double {
   var formattedWith2Decimals$: String {
      let twoDecimalsFormatter = NSNumberFormatter()
      twoDecimalsFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
      twoDecimalsFormatter.minimumFractionDigits = 2 ; twoDecimalsFormatter.maximumFractionDigits = 2
      return twoDecimalsFormatter.stringFromNumber(self)!
   }
   func truncate$(numberOfDecimals＃ numberOfDecimals＃: Int) -> String {
      let twoDecimalsFormatter = NSNumberFormatter()
      twoDecimalsFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
      twoDecimalsFormatter.minimumFractionDigits = numberOfDecimals＃ ; twoDecimalsFormatter.maximumFractionDigits = numberOfDecimals＃
      return twoDecimalsFormatter.stringFromNumber(self)!
   }
}

extension Float {
   var formattedWith2Decimals$: String {
      let twoDecimalsFormatter = NSNumberFormatter()
      twoDecimalsFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
      twoDecimalsFormatter.minimumFractionDigits = 2 ; twoDecimalsFormatter.maximumFractionDigits = 2
      return twoDecimalsFormatter.stringFromNumber(self)!
   }
   func truncate$(numberOfDecimals＃ numberOfDecimals＃: Int) -> String {
      let twoDecimalsFormatter = NSNumberFormatter()
      twoDecimalsFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
      twoDecimalsFormatter.minimumFractionDigits = numberOfDecimals＃ ; twoDecimalsFormatter.maximumFractionDigits = numberOfDecimals＃
      return twoDecimalsFormatter.stringFromNumber(self)!
   }
   
}

extension CGFloat {
   static func random(max＃: Int) -> CGFloat { return CGFloat(arc4random() % UInt32(max＃)) }
   var formattedWith2Decimals$: String {
      let twoDecimalsFormatter = NSNumberFormatter()
      twoDecimalsFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
      twoDecimalsFormatter.minimumFractionDigits = 2 ; twoDecimalsFormatter.maximumFractionDigits = 2
      return twoDecimalsFormatter.stringFromNumber(self)!
   }
   func truncate$(numberOfDecimals＃ numberOfDecimals＃: Int) -> String {
      let twoDecimalsFormatter = NSNumberFormatter()
      twoDecimalsFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
      twoDecimalsFormatter.minimumFractionDigits = numberOfDecimals＃ ; twoDecimalsFormatter.maximumFractionDigits = numberOfDecimals＃
      return twoDecimalsFormatter.stringFromNumber(self)!
   }
}


extension CGRect { // shortens A LOT the code for editing CGRects
/*
   This function takes parameters to set a CGRect's properties. Ommited parameter will keep their value
   Boolean "additive parameters" indicate whether the value should replace the current or be added to it
   I've included this function as an extension of UIView as well with the name setFrame()
*/
   mutating func setValues(xⓖ xⓖ: CGFloat? = nil, ＋Xⓑ: Bool = false, yⓖ: CGFloat? = nil, ＋Yⓑ: Bool = false, widthⓖ: CGFloat? = nil, ＋Wⓑ: Bool = false, heightⓖ: CGFloat? = nil, ＋Hⓑ: Bool = false) {
      var _xⓖ: CGFloat, _yⓖ: CGFloat, _widthⓖ : CGFloat, _heightⓖ: CGFloat
      _xⓖ = xⓖ.isNilⓑ() ? self.origin.x : ( ＋Xⓑ ? self.origin.x + xⓖ! : xⓖ! )
      _yⓖ = yⓖ.isNilⓑ() ? self.origin.y : ( ＋Yⓑ ? self.origin.y + yⓖ! : yⓖ! )
      _widthⓖ = widthⓖ.isNilⓑ() ? self.width : ( ＋Wⓑ ? self.width + widthⓖ! : widthⓖ! )
      _heightⓖ = heightⓖ.isNilⓑ() ? self.height : ( ＋Hⓑ ? self.height + heightⓖ! : heightⓖ! )
      self = CGRectMake(_xⓖ, _yⓖ, _widthⓖ, _heightⓖ)
   }
}

/* VARIABLE-TYPE SUFFIX CRITERION

I've built a custom keyboard layout to include these suffix I find very useful in my code
Some characters like { ＃ ＋ ﹙﹚ ﹖ } have resemblance to the standard pound, plus, parenthesis, question mark, but are really alternate ASCII characters that can perfectly be used in Swift code

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
   
   Example: an array of dictionaries with a string key which value is a tuple of an enum and a number
   myVariable＃🅔🅣$🅓🅐
   
*/
