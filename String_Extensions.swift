/*
                             .-----------------------------------------------------------------------------.
                            /  .-.                                                                      .-.  \
                           |  /   \    Hikarus Guijarro-Fayard - iOS developer specialized in Swift    /   \  |
                           | |\_.  |                     http://ikiteruningen.net                     |    /| |
                           |\|  | /|                    https://github.com/HikarusG                   |\  | |/|
                           | `---' |                                                                  | `---' |
                           \       |------------------------------------------------------------------|       /
                            \     /                                                                    \     /
                             `---'                                                                      `---'
*/

extension String {
   
   var isEmptyⓑ: Bool { return self == "" }
   var length＃: Int { return self.characters.count }
   var maxIndex＃: Int  { return self.characters.count - 1 }
   
 // Returns the character at the index
   subscript(index＃: Int) -> String? {
      if self.length＃ == 0 { return nil }
      return self.substringWithRange(Range(start: self.startIndex.advancedBy(index＃), end: self.startIndex.advancedBy(index＃ + 1)))
   }
   
// Returns the substring in the given Int range. Max-overflow-proof
   subscript(start＃: Int, end＃: Int) -> String? {
      let maxEnd＃ = min(self.maxIndex＃, end＃)
      if start＃ < 0 || start＃ > maxEnd＃ { return nil }
      return self.substringWithRange(Range(start: self.startIndex.advancedBy(start＃), end: self.startIndex.advancedBy(maxEnd＃ + 1)))
   }
   
   func left$(length＃: Int) -> String { if length＃ <= self.length＃ { return self[0, length＃-1]! } else { return self } }
   func right$(length＃: Int) -> String { if length＃ <= self.length＃ { return self[self.length＃ - length＃, self.length＃-1]! } else { return self } }

// returns the localized version of an operating system string
   var localized$: String { return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "") }

   var capitalizedFirst$: String  { return String(characters.prefix(1)).uppercaseString + String(self.characters.dropFirst()) }
   mutating func capitalizeFirst() { self.replaceRange(startIndex...startIndex, with: String(self[startIndex]).uppercaseString) }

// removes spaces and new line characters
   var trimmed$: String { return (self as NSString).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) }
   func removeCharacter$(character$: String) -> String { return self.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: character$)) }

// creates an NSDate from YYY/MM/dd format String
   var toDate㊐: NSDate { let dateFormatter = NSDateFormatter(); dateFormatter.dateFormat = "YYYY/MM/dd"; return dateFormatter.dateFromString(self)! }
   // the next 3 functions get date components from a YYYY/MM/dd formatted string
   var yearComponent$: String? { // takes format "YYYY/MM/DD"
      if self.length＃ != 10 { return nil }
      return self[0, 3]
   }
   var monthComponent$: String? { // takes format "YYYY/MM/DD"
      if self.length＃ != 10 { return nil }
      return self[5, 6]
   }
   var dayComponent$: String? { // takes format "YYYY/MM/DD"
      if self.length＃ != 10 { return nil }
      return self[8, 9]
   }
   
// creates an NSDate (sets time) from 24h format hour
   var toTime㊐: NSDate { let timeFormatter = NSDateFormatter(); timeFormatter.dateFormat = "HH:mm"; return timeFormatter.dateFromString(self)! }
   
// these two functions use my class HKDate＋ to determine if it's a week day or a week end day
// See Date-Operations.swift
   func isWeekEndⓑ() -> Bool { if HKDate＋.WeekDayFromLocalizedString$🅔🅓[self] == .Saturday || HKDate＋.WeekDayFromLocalizedString$🅔🅓[self] == .Sunday { return true } else { return false } }
   func isWeekDayⓑ() -> Bool { if self.isWeekEndⓑ() { return false } else { return true } }

// convenient dot-notation versions of the numerical-type constructors that take a string
   var int＃: Int? { return Int(self) ?? nil }
   var double＃: Double? { return Double(self) ?? nil }
   var float＃: Float? { return Float(self) ?? nil }
   var CGFloatⓖ: CGFloat? { return self.float＃.isNilⓑ() ? nil : CGFloat(self.float＃!) }
   
// converts a string hexadecimal digit into an integer
// used for my UIColor hexCode convenience initializer. See UIColor-Extensions.swift
   var intFromHexString＃: Int? { // gets a string representing an hexadecimal number in the standard format 0x0000..., and returns its Integer value
      let hexDigits$🅓 = ["0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "A": 10, "B": 11, "C": 12, "D": 13, "E": 14, "F": 15]
      func formatIsCorrectⓑ() -> Bool {
         var veredictⓑ: Bool = true
         for char$ in self.characters { if !char$.isHexDigitⓑ { veredictⓑ = false ; break } }
         return veredictⓑ
      }
      let returnInt＃ = hexDigits$🅓[self[0]!]! * 16 + hexDigits$🅓[self[1]!]!
      return formatIsCorrectⓑ() ? returnInt＃ : nil
   }
   func toChar$ (position＃: Int = 0) -> Character? { return position＃ > self.length＃ - 1 ? nil : Character(self[position＃]!) } // returns the requested character in a string converted to type Character

// These functions are a shortcut for using componentsSeparatedByString but Implicitly taking the dot "." as separator character

   // returns an array with a string for each component
   var components$🅐: [String] { return self.componentsSeparatedByString(".") }
   
   var firstComponent$: String? { return self.componentsSeparatedByString(".").first }
   var lastComponent$: String? { return self.componentsSeparatedByString(".").last }
   
}

/* VARIABLE-TYPE SUFFIX CRITERION ---------------------------------------------------------------------------------
 
I've built a custom keyboard layout to include these suffix I find very useful in my code
Some characters like { ＃ ＋ ﹙﹚ ﹖ } have resemblance to the standard pound, plus, parenthesis, question mark,
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
   
   Example: an array of dictionaries with a string key which value is a tuple of an enum and a number
   myVariable＃🅔🅣$🅓🅐
   
----------------------------------------------------------------------------------------------------------------- */
