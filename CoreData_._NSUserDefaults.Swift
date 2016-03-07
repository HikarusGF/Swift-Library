/*
                        .-----------------------------------------------------------------------------.
                       /  .-.                                                                      .-.  \
                      |  /   \    Hikarus Guijarro-Fayard - iOS developer specialized in Swift    /   \  |
                      | |\_.  |                     http://ikiteruningen.net                     |    /| |
                      |\|  | /|                    https://github.com/HikarusG                   |\  | |/|
                      | `---' |                                                                  | `---' |
                      |       |------------------------------------------------------------------|       |
                      \       |                                                                  |       /
                       \     /                                                                    \     /
                        `---'                                                                      `---'
*/

class HKData＋ { // Functions to read and write with NSUserDefaults with implicit data-types to avoid having to cast --------------------------------------------------
   
   static let persistentStorage🅞 = NSUserDefaults.standardUserDefaults()
   
   class func writePersistent﹖(key$ key$: String, object﹖: AnyObject) { persistentStorage🅞.setObject(object﹖, forKey: key$) }
   class func writePersistentⓑ(key$ key$: String, booleanⓑ: Bool) { persistentStorage🅞.setBool(booleanⓑ, forKey: key$) }
   class func writePersistent＃i(key$ key$: String, number＃: Int) { persistentStorage🅞.setInteger(number＃, forKey: key$) }
   class func writePersistent＃f(key$ key$: String, number＃: Float) { persistentStorage🅞.setFloat(number＃, forKey: key$) }
   class func writePersistent＃d(key$ key$: String, number＃: Double) { persistentStorage🅞.setDouble(number＃, forKey: key$) }
   class func writePersistent🅤(key$ key$: String, URL🅤: NSURL) { persistentStorage🅞.setURL(URL🅤, forKey: key$) }

   class func readPersistent﹖(key$ key$: String) -> AnyObject? { return persistentStorage🅞.objectForKey(key$) } // will need casting
   class func readPersistentⓑ(key$ key$: String) -> Bool? { return persistentStorage🅞.boolForKey(key$) }
   class func readPersistent﹖🅐(key$ key$: String) -> [AnyObject]? { return persistentStorage🅞.arrayForKey(key$) as [AnyObject]?}
   class func readPersistent🅐(key$ key$: String) -> Dictionary<String,AnyObject>? { return persistentStorage🅞.dictionaryForKey(key$) as Dictionary<String,AnyObject>? }
   class func readPersistent$(key$ key$: String) -> String? { return persistentStorage🅞.stringForKey(key$) }
   class func readPersistent$🅐(key$ key$: String) -> [String]? { return persistentStorage🅞.stringArrayForKey(key$) }
   class func readPersistent＃i(key$ key$: String) -> Int? { return persistentStorage🅞.integerForKey(key$) }
   class func readPersistent＃f(key$ key$: String) -> Float? { return persistentStorage🅞.floatForKey(key$) }
   class func readPersistent＃d(key$ key$: String) -> Double? { return persistentStorage🅞.doubleForKey(key$) }
   class func readPersistentß(key$ key$: String) -> NSData? { return persistentStorage🅞.dataForKey(key$) }
   class func readPersistent🅤(key$ key$: String) -> NSURL? { return persistentStorage🅞.URLForKey(key$) }
   
   class func deletePersistent(key$ Key$: String) { persistentStorage🅞.removeObjectForKey(Key$) }
}


// CORE DATA related extensions ----------------------------------------------------------------------------------------------------------------------------------------

// singleton that returns the application delegate
let appDelegate🅞: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate // Default appDelegate. We use it to connect to the data engine

// singleton that returns the AppDelegate's managedObjectContext
let coreDataMOC🅞: NSManagedObjectContext = appDelegate🅞.managedObjectContext // handle to the DB

extension NSManagedObjectContext { // methods to fetch, create and delete objects from an entity -----------------------------------------------------------------------
   
   // used internally by the other funcions
   private func commitChangesⓑ() -> Bool {
      var outputⓑ = true
      do { try  self.save() } catch { outputⓑ = false; print("\n* * * Error saving object! * * *\n") }
      return outputⓑ
   }
   
   func createObjectInEntity🅞(entity$: String, assignmentsƒ: (managedObject🅞: NSManagedObject) -> (), completionƒ: (() -> ())? = nil) -> NSManagedObject {
      let MO🅞 = NSEntityDescription.insertNewObjectForEntityForName(entity$, inManagedObjectContext: self)
      assignmentsƒ(managedObject🅞: MO🅞)
      self.commitChangesⓑ()
      completionƒ?()
      return MO🅞
   }           /* the assignmentsƒ() closure is where the new object's attributes are assigned from the calling code, then commitChangesⓑ is automatically infoked
               EXAMPLE:
                  let newContactMO🅞 = coreDataMOC🅞.createObjectInEntity🅞("Users", assignmentsƒ: { userMO🅞 in
                     userMO🅞.setValue(user🅞.phoneNumber$, forKey: "phoneNumber")
                     userMO🅞.setValue(user🅞.genderⓑ, forKey: "gender")
                     userMO🅞.setValue(user🅞.firstName$!, forKey: "firstName")
                     userMO🅞.setValue(user🅞.lastName$!, forKey: "lastName")
                     userMO🅞.setValue(user🅞.pictures🅞🅐[0]?.toJPGData(), forKey: "picture0")
                  })
            */
   
   
   func deleteObjectⓑ(objectMO🅞: NSManagedObject) -> Bool {
      var outputⓑ = true
      self.deleteObject(objectMO🅞)
      do { try self.save() } catch { outputⓑ = false; print("Error deleting object!") }
      return outputⓑ
   }
   
   func fetchEntityObjects(entityName$: String, predicate🅞: NSPredicate? = nil) -> [NSManagedObject]? {
      var fetchResultAO🅐: [AnyObject]?
      var entityMO🅐 = [NSManagedObject]()
      let fetchRequest🅞 = NSFetchRequest(entityName: entityName$); fetchRequest🅞.returnsObjectsAsFaults = false
      if predicate🅞.isNotNilⓑ() { fetchRequest🅞.predicate = predicate🅞 }
      do { fetchResultAO🅐 = try self.executeFetchRequest(fetchRequest🅞)
         if fetchResultAO🅐?.count > 0 { for recordMO🅐 in fetchResultAO🅐! as! [NSManagedObject] { entityMO🅐.append(recordMO🅐) } } // for edit: recordMO🅐.setValue(<WhatEver>, forKey: fieldName$)
      } catch { print("Fetch Error: データベスと接続が失敗しまった！") }
      return entityMO🅐.count > 0 ? entityMO🅐 : nil
      // if fields are altered once there are records already, we get a nasty error: "The model used to open the stroe is incompatible with the one used to create the store"
      // we must delete the app from the terminal to delete data model, then perform a project clean (⬆︎⌘K), then restart
      // PREDICATE EXAMPLE: let predicate🅞 = NSPredicate(format: "eventType = %@ AND eventID = %@", eventListItem🅞.eventType＃!, eventListItem🅞.eventID$!) // string has ''
   }
   
}

extension NSManagedObject { // attribute-access functions with implicit data-type to avoid having to cast ------------------------------------------------------------------------------------
   
   func valueForAttributeⓑ(attributeName$: String) -> Bool?  { return self.valueForKey(attributeName$) as? Bool } // valueForKey returns an NSManagedObject so it must be cast into the desired type
   func valueForAttribute$(attributeName$: String) -> String?  { return self.valueForKey(attributeName$) as? String }
   func valueForAttribute＃i(attributeName$: String) -> Int?  { return self.valueForKey(attributeName$) as? Int }
   func valueForAttribute＃f(attributeName$: String) -> Float?  { return self.valueForKey(attributeName$) as? Float }
   func valueForAttribute＃d(attributeName$: String) -> Double?  { return self.valueForKey(attributeName$) as? Double }
   func valueForAttributeß(attributeName$: String) -> UIImage?  { if let imageß = self.valueForKey(attributeName$) as? NSData { return UIImage(data: imageß) } else { return nil } }
   func valueForAttribute㊐(attributeName$: String) -> NSDate?  { return self.valueForKey(attributeName$) as? NSDate }
   
}

/* VARIABLE-TYPE SUFFIX CRITERION ----------------------------------------------------------------------------------------------------------------------------------------------------------

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
