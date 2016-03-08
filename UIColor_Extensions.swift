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

extension UIColor {

// initializes a UIColor instance with the typical 3 integer RBG components
   convenience init(red＃: Int, green＃: Int, blue＃: Int) {
      self.init(red: CGFloat(red＃)/255, green: CGFloat(green＃)/255, blue: CGFloat(blue＃)/255, alpha: 1.0)
   }
   
// initializes a UIColor instance with a 6-digit hexadecimal code in String
   // very useful when pasting color codes from adobe apps like photoshop or illustrator
   // (!) uses my array subindex extension: see Array_Extensions.swift
   convenience init(var hexCode6＃$: String) {
      hexCode6＃$ = hexCode6＃$.uppercaseString
      if let red＃ = hexCode6＃$[0,1]!.intFromHexString＃, green＃ = hexCode6＃$[2,3]!.intFromHexString＃, blue＃ = hexCode6＃$[4,5]!.intFromHexString＃ {
         self.init(red＃: red＃, green＃: green＃, blue＃: blue＃)
      } else { self.init() }
   }

   // crates a random 24-bit color (16,7 millions). Useful for games
   class var randomColor🅞: UIColor {
      var colorCode$ = String()
      for _ in 0...5 {
         let number＃ = Int.random＃(0, max＃: 15)
         var character = String()
         switch number＃ {
            case 0: character = "0"
            case 1: character = "1"
            case 2: character = "2"
            case 3: character = "3"
            case 4: character = "4"
            case 5: character = "5"
            case 6: character = "6"
            case 7: character = "7"
            case 8: character = "8"
            case 9: character = "9"
            case 10: character = "a"
            case 11: character = "b"
            case 12: character = "c"
            case 13: character = "d"
            case 14: character = "e"
            case 15: character = "f"
            default: break
         }
         colorCode$ += character
      }
      return UIColor(hexCode6＃$: colorCode$)
   }

// creates a random basic color. Useful for games
   class var randomBasicColor🅞: UIColor {
      switch arc4random()%11 {
         case 0: return UIColor.greenColor()
         case 1: return UIColor.blueColor()
         case 2: return UIColor.orangeColor()
         case 3: return UIColor.redColor()
         case 4: return UIColor.yellowColor()
         case 5: return UIColor.purpleColor()
         case 6: return UIColor.cyanColor()
         case 7: return UIColor.brownColor()
         case 8: return UIColor.magentaColor()
         case 9: return UIColor.grayColor()
         case 10: return UIColor.lightGrayColor()
         default: return UIColor.darkGrayColor()
      }
   }
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
