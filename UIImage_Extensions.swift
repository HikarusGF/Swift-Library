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


extension UIImage {

// scales an image to the specified dimensions to optimize memory
   func scaleToSize(widthⓖ: CGFloat, heightⓖ: CGFloat) -> UIImage {
      UIGraphicsBeginImageContext(CGSizeMake(widthⓖ, heightⓖ))
      self.drawInRect(CGRectMake(0,0, widthⓖ, heightⓖ))
      let output🅞 = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return output🅞
   }
// scales an image by a specified factor to optimize memory
   func scaleToFactor(factorⓖ: CGFloat) -> UIImage {
      let widthⓖ = self.size.width * factorⓖ
      let heightⓖ = self.size.height * factorⓖ
      UIGraphicsBeginImageContext(CGSizeMake(widthⓖ, heightⓖ))
      self.drawInRect(CGRectMake(0,0, widthⓖ, heightⓖ))
      let output🅞 = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return output🅞
   }
   
// next 2 functions convert an image to JPG or PNG format and return an NSData
	// useful for saving images in CoreData
   func toJPGData(compressionQualityⓖ: CGFloat = 0.7) -> NSData? { return UIImageJPEGRepresentation(self, compressionQualityⓖ) }
   func toPNGData() -> NSData? { return UIImagePNGRepresentation(self) }
   
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
