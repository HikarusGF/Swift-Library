/*
      Hikarus Guijarro-Fayard  - iOS developer specialized in Swift
      http://ikiteruningen.net
      https://github.com/HikarusGF
*/

class HKDate＋ {
   
// computed singleton that returns the current date & time, adjusted for local time zone
   static var now㊐: NSDate { return NSDate().adjustedForLocalTimeZone㊐ }
   
// same than previous but in string with a specific format
   static var nowWith6Digits$: String { get { return String(now㊐.year＃).right$(2) + "\(now㊐.month＃.formattedWith2Digits$)\(now㊐.day＃.formattedWith2Digits$)" } }

// an enum structure I use for certain functions. There is no String raw value because it woul
   enum DaysOfTheWeek🅔: String {
      case Monday = "Monday"
      case Tuesday = "Tuesday"
      case Wednesday = "Wednesday"
      case Thursday = "Thursday"
      case Friday = "Friday"
      case Saturday = "Saturday"
      case Sunday = "Sunday"
   }

// these two return if a given date is a weed day or a week end day
   class func IsWeekEndⓑ(dayOfTheWeek: DaysOfTheWeek🅔) -> Bool { if dayOfTheWeek == .Saturday || dayOfTheWeek == .Sunday { return true } else { return false } }
   class func IsWeekDayⓑ(dayOfTheWeek: DaysOfTheWeek🅔) -> Bool { if dayOfTheWeek != .Saturday && dayOfTheWeek != .Sunday { return true } else { return false } }

   class func NextWeekDay㊐(dateFrom㊐ dateFrom㊐: NSDate = NSDate(), weekDay🅔 day🅔: DaysOfTheWeek🅔) -> NSDate { // Makes no sense to make it dependent of an NSDate class or instance
      var checkDay = dateFrom㊐
      var scan＃: Int = 1
      repeat { checkDay = dateFrom㊐.addComponents㊐(days＃: scan＃); scan＃++ } while checkDay.dayOfTheWeek🅔 != day🅔
      return checkDay
   }
   
}

/*
   Operators to add and substract date-component units to dates
   The WrapComponents option prevents overflowing from one unit into the next larger one in case number exceeds unit capacity (ex: 25th hour)
   There doesn't seem to be any documentation on NSCalendarOptions

   USAGE:
      var tomorrow = HKDate＋.now㊐ + 1.day＃㊐🅣
      tomorrow += 1.day＃㊐🅣
      var lastYear = HKDate＋.now㊐ - 1.year＃㊐🅣
      lastYear -= 1.year＃㊐🅣
*/
func + (date㊐: NSDate, offset＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int)) -> NSDate { return NSCalendar.currentCalendar().dateByAddingUnit(offset＃㊐🅣.unit㊐, value: offset＃㊐🅣.value＃, toDate: date㊐, options: .WrapComponents)! }
func - (date㊐: NSDate, offset＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int)) -> NSDate { return NSCalendar.currentCalendar().dateByAddingUnit(offset＃㊐🅣.unit㊐, value: (-offset＃㊐🅣.value＃), toDate: date㊐, options: .WrapComponents)! }
func += (inout date㊐: NSDate, offset＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int)) { date㊐ = NSCalendar.currentCalendar().dateByAddingUnit(offset＃㊐🅣.unit㊐, value: offset＃㊐🅣.value＃, toDate: date㊐, options: .WrapComponents)! }
func -= (inout date㊐: NSDate, offset＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int)) { date㊐ = NSCalendar.currentCalendar().dateByAddingUnit(offset＃㊐🅣.unit㊐, value: -offset＃㊐🅣.value＃, toDate: date㊐, options: .WrapComponents)! }


/*
This operator computes the difference between two dates and returns the result in a tuple with 6 intenger date units
The operation cound also be performed with timeIntervalSince1970, but the number of days per year or month are not constant
so it's not an exact method
*/
func - (date1㊐: NSDate, date2㊐: NSDate) -> (years＃: Int, months＃: Int, days＃: Int, hours＃: Int, minutes＃: Int, seconds＃: Int) {
   var years＃, months＃, days＃, hours＃, minutes＃, seconds＃: Int
   var date1㊐_ = date1㊐, date2㊐_ = date2㊐
   years＃ = date1㊐_.yearsFrom＃(date2㊐_)
   switch years＃ {
   case let y＃ where y＃ > 0: date1㊐_ -= years＃.years＃㊐🅣
   case let y＃ where y＃ < 0: date2㊐_ += years＃.years＃㊐🅣
   default: break
   }
   months＃ = date1㊐_.monthsFrom＃(date2㊐_)
   switch months＃ {
   case let m＃ where m＃ > 0: date1㊐_ -= months＃.months＃㊐🅣
   case let m＃ where m＃ < 0: date2㊐_ += months＃.months＃㊐🅣
   default: break
   }
   days＃ = date1㊐_.daysFrom＃(date2㊐_)
   switch days＃ {
   case let d＃ where d＃ > 0: date1㊐_ -= days＃.days＃㊐🅣
   case let d＃ where d＃ < 0: date2㊐_ += days＃.days＃㊐🅣
   default: break
   }
   hours＃ = date1㊐_.hoursFrom＃(date2㊐_)
   switch hours＃ {
   case let h＃ where h＃ > 0: date1㊐_ -= hours＃.hours＃㊐🅣
   case let h＃ where h＃ < 0: date2㊐_ += hours＃.hours＃㊐🅣
   default: break
   }
   minutes＃ = date1㊐_.minutesFrom＃(date2㊐_)
   switch minutes＃ {
   case let m＃ where m＃ > 0: date1㊐_ -= minutes＃.minutes＃㊐🅣
   case let m＃ where m＃ < 0: date2㊐_ += minutes＃.minutes＃㊐🅣
   default: break
   }
   seconds＃ = date1㊐_.secondsFrom＃(date2㊐_)
   return (years＃, months＃, days＃, hours＃, minutes＃, seconds＃)
}

// these functions compare dates with the total of seconds sonce 1970
func <= (date1㊐: NSDate, date2㊐: NSDate) -> Bool { return date1㊐.timeIntervalSince1970 <= date2㊐.timeIntervalSince1970 }
func >= (date1㊐: NSDate, date2㊐: NSDate) -> Bool { return date1㊐.timeIntervalSince1970 >= date2㊐.timeIntervalSince1970 }
func > (date1㊐: NSDate, date2㊐: NSDate) -> Bool { return date1㊐.timeIntervalSince1970 < date2㊐.timeIntervalSince1970 }
func == (date1㊐: NSDate, date2㊐: NSDate) -> Bool { return date1㊐.timeIntervalSince1970 == date2㊐.timeIntervalSince1970 }

/* HERE'S ANOTHER METHOD TO COMPARE DATES, BUT DOES NOT APPLY TO <= OR >=

    let comparisonResult🅞 = date1㊐.compare(date2㊐)
    switch comparisonResult🅞 {
      case .OrderedAscending: // date1㊐ < date2㊐
      case .OrderedSame: // date1㊐ = date2㊐
      case .OrdeDescending: // date1㊐ > date2㊐
    }

   return date1㊐.compare(date2㊐) == .OrderedAscending
*/
// __________________________________________________________________________________________________________________________________

extension NSDate {
   
// very practical initiallizer with 6 integer components
   convenience init?( year＃: Int, month＃: Int, day＃: Int,  hour＃: Int = 0,  minute＃: Int = 0,  second＃: Int = 0) {
      let dateComponents㊐ = NSDateComponents()
      dateComponents㊐.year = year＃
      dateComponents㊐.month = month＃
      dateComponents㊐.day = day＃
      dateComponents㊐.hour = hour＃
      dateComponents㊐.minute = minute＃
      dateComponents㊐.second = second＃
      let referenceDate㊐ = NSCalendar.currentCalendar().dateFromComponents(dateComponents㊐)
      if referenceDate㊐.isNilⓑ() { return nil }
      self.init(timeInterval: 0, sinceDate: referenceDate㊐!)
   }

// bulk add all components in one line using Int extensions for date components. See Numerical_Extensions.swift
   func addComponents㊐(years＃ years＃: Int = 0, monts＃: Int = 0, days＃: Int = 0, hours＃: Int = 0, minutes＃: Int = 0, seconds＃: Int = 0) -> NSDate {
      var computedDate㊐ = self
      computedDate㊐ += years＃.years＃㊐🅣
      computedDate㊐ += monts＃.months＃㊐🅣
      computedDate㊐ += days＃.days＃㊐🅣
      computedDate㊐ += hours＃.hours＃㊐🅣
      computedDate㊐ += minutes＃.minutes＃㊐🅣
      computedDate㊐ += seconds＃.seconds＃㊐🅣
      return computedDate㊐
   }

// returns the time zone offset of a give date
   var timeZoneOffset＃: Int { return Int(NSTimeInterval(NSTimeZone.localTimeZone().secondsFromGMTForDate(self)))/60/60 }
// returns the date adjusted for local time zone
   var adjustedForLocalTimeZone㊐: NSDate {
      let timeZoneOffset = NSTimeInterval(NSTimeZone.localTimeZone().secondsFromGMTForDate(self))
      return self.dateByAddingTimeInterval(timeZoneOffset)
   }

/*
   The next 11 function create strings with the NSData information
   The first one takes a specified format via parameter and the following 10 have implicit formats
*/
   func formattedTo$(format$: String) -> String {
      let dateFormatter🅞 = NSDateFormatter(); dateFormatter🅞.dateFormat = format$
      return dateFormatter🅞.stringFromDate(self)
   }
   var fullDate$: String {
      let dateFormatter🅞 = NSDateFormatter()
      dateFormatter🅞.dateFormat = "EEEE, MMMM d, YYYY"
      return dateFormatter🅞.stringFromDate(self)
   }
   var trimmedFullDate$: String {
      let dateFormatter🅞 = NSDateFormatter()
      dateFormatter🅞.dateFormat = "EEE, MMM d, YY"
      return dateFormatter🅞.stringFromDate(self)
   }
   var trimmedFullDateNoYear$: String {
      let dateFormatter🅞 = NSDateFormatter()
      dateFormatter🅞.dateFormat = "EEE, MMM d"
      return dateFormatter🅞.stringFromDate(self)
   }
   var sixDigitDateMMddYY$: String {
      let dateFormatter🅞 = NSDateFormatter()
      dateFormatter🅞.dateFormat = "MM/dd/YY"
      return dateFormatter🅞.stringFromDate(self)
   }
   var fourDigitDate$: String {
      let dateFormatter🅞 = NSDateFormatter()
      dateFormatter🅞.dateFormat = "MM/dd"
      return dateFormatter🅞.stringFromDate(self)
   }
   var fourDigitDateWithWeekDay$: String {
      let dateFormatter🅞 = NSDateFormatter()
      dateFormatter🅞.dateFormat = "EEE MM/dd"
      return dateFormatter🅞.stringFromDate(self)
   }
   var month$: String {
      let dateFormatter🅞 = NSDateFormatter()
      dateFormatter🅞.dateFormat = "MMMM"
      return dateFormatter🅞.stringFromDate(self)
   }
   var time24h$: String {
      let timeFormatter🅞 = NSDateFormatter()
      timeFormatter🅞.dateFormat = "hh:mm"
      return timeFormatter🅞.stringFromDate(self)
   }
   var time12h$: String {
      let timeFormatter🅞 = NSDateFormatter()
      timeFormatter🅞.dateFormat = "HH:mma"
      return timeFormatter🅞.stringFromDate(self)
   }
   var compactDateTime$: String {
      let timeFormatter🅞 = NSDateFormatter()
      timeFormatter🅞.dateFormat = "EEEE, MMMM dd @HH:mma"
      return timeFormatter🅞.stringFromDate(self)
   }
   
// returns an enum value with the day of the week
   var dayOfTheWeek🅔: HKDate＋.DaysOfTheWeek🅔 {
      let dateFormatter🅞 = NSDateFormatter(); dateFormatter🅞.dateFormat = "EEEE"
      var dayOfTheWeek🅔 = HKDate＋.DaysOfTheWeek🅔.Monday
      switch dateFormatter🅞.stringFromDate(self) {
         case "Monday", "月曜日": dayOfTheWeek🅔 = .Monday
         case "Tuesday", "火曜日": dayOfTheWeek🅔 = .Tuesday
         case "Wednesday", "水曜日": dayOfTheWeek🅔 = .Wednesday
         case "Thursday", "木曜日": dayOfTheWeek🅔 = .Thursday
         case "Friday", "金曜日": dayOfTheWeek🅔 = .Friday
         case "Saturday", "土曜日": dayOfTheWeek🅔 = .Saturday
         case "Sunday", "日曜日": dayOfTheWeek🅔 = .Sunday
         default: break
      }
      return dayOfTheWeek🅔
   }
   
// returns a string with the day of the week in full length
   var dayOfTheWeekLong$: String {
      let dateFormatter🅞 = NSDateFormatter(); dateFormatter🅞.dateFormat = "EEEE"
      return dateFormatter🅞.stringFromDate(self)
   }
// returns a string with the day of the week in 3-digit capital letter format
   var dayOfTheWeekShort$: String {
      let dateFormatter🅞 = NSDateFormatter(); dateFormatter🅞.dateFormat = "EEE"
      return dateFormatter🅞.stringFromDate(self).left$(3).uppercaseString
   }

// these functions return an integer with the value of the date component specified
   var year＃: Int { return NSCalendar.currentCalendar().components(.Year, fromDate: self).year }
   var yearWith2Digits$: String { return String(NSCalendar.currentCalendar().components(.Year, fromDate: self).year).right$(2) }
   var month＃: Int { return NSCalendar.currentCalendar().components(.Month, fromDate: self).month }
   var day＃: Int { return NSCalendar.currentCalendar().components(.Day, fromDate: self).day }
   var hour＃: Int { return NSCalendar.currentCalendar().components(.Hour, fromDate: self).hour }
   var minute＃: Int { return NSCalendar.currentCalendar().components(.Minute, fromDate: self).minute }
   var second＃: Int { return NSCalendar.currentCalendar().components(.Second, fromDate: self).second }

// equivalent to the number of days in a given month
   var lastDayOfTheMonth＃: Int {
      let calendar = NSCalendar.currentCalendar()
      let components = NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: self)
      components.month += 1
      components.day = 0
      return calendar.dateFromComponents(components)!.month＃
   }

// the next 12 functions compute the number of specific calendar units from and to another NSDate
   func yearsFrom＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Year, fromDate: date㊐, toDate: self, options: []).year }
   func monthsFrom＃(date㊐ :NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Month, fromDate: date㊐, toDate: self, options: []).month }
   func weeksFrom＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.WeekOfYear, fromDate: date㊐, toDate: self, options: []).weekOfYear }
   func daysFrom＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Day, fromDate: date㊐, toDate: self, options: []).day }
   func hoursFrom＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Hour, fromDate: date㊐, toDate: self, options: []).hour }
   func minutesFrom＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Minute, fromDate: date㊐, toDate: self, options: []).minute }
   func secondsFrom＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Second, fromDate: date㊐, toDate: self, options: []).second }
   
   func yearsTo＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Year, fromDate: self, toDate: date㊐, options: []).year }
   func monthsTo＃(date㊐ :NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Month, fromDate: self, toDate: date㊐, options: []).month }
   func weeksTo＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.WeekOfYear, fromDate: self, toDate: date㊐, options: []).weekOfYear }
   func daysTo＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Day, fromDate: self, toDate: date㊐, options: []).day }
   func hoursTo＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Hour, fromDate: self, toDate: date㊐, options: []).hour }
   func minutesTo＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Minute, fromDate: self, toDate: date㊐, options: []).minute }
   func secondsTo＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Second, fromDate: self, toDate: date㊐, options: []).second }
}

/* VARIABLE-TYPE SUFFIX CRITERION

I've built a custom keyboard layout to include these suffix I find very useful in my code.
You can of course remove them :)

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
*/
