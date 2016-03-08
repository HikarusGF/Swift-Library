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


class HKMaps＋ { // this class encapsulates miscelaneous location functionalities
   /* some tips to remember:
      In order for the LocationManger to be able to request user's permission for tracking, the following keys must be added to the info.plist at Project's properties -> Custom iOS Target Properties -> info:
      NSLocationWhenInUseUsageDescription: String  |&  NSLocationAlwaysUsageDescription: String
      
      the viewController that will be the CLLocationManagerDelegate must implement the function locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]),
      that will be called by the locationManager when it updates info
      in order to draw a polyline the two last locations must be read
   */
   
// these enums are my own interpretations of the authorization statuses to make things more clear in my funtions
   enum trackingAccuracies🅔 {
      case Navigation
      case Best
      case m10
      case m100
      case Km1
      case Km3
   }
   enum authorizationTypes🅔 {
      case Active // When app is in use
      case Permanent // when app is in use or in the background
   }
   enum authorizationStatusTypes🅔 {
      case Always
      case Foreground
      case UnDetermined
      case Restricted
      case Denied
   }
   
// LocationManager🅞 is a singleton because we can't have two at the same time in an app. Try and see what happens ;)
   static let LocationManager🅞 = CLLocationManager()
// the current location is also a sigleton since a device can only be in one place at a time
   static var CurrentLocation🅞 = CLLocation()
   
   static var LocationTrackingEnabledⓑ: Bool { get { return CLLocationManager.locationServicesEnabled() } }
   
   class func AuthorizationStatus🅔() -> authorizationStatusTypes🅔 {
      switch CLLocationManager.authorizationStatus() {
      case .NotDetermined: return .UnDetermined
      case .Restricted: return .Restricted
      case .Denied: return .Denied
      case .AuthorizedAlways: return .Always
      case .AuthorizedWhenInUse: return .Foreground
      }
   }
   
   class func ActivateLocationTracking(delegate🅞 delegate🅞: CLLocationManagerDelegate, accuracy🅔: trackingAccuracies🅔 = .Best, authorizationType🅔: authorizationTypes🅔 = .Active) {
      LocationManager🅞.delegate = delegate🅞
      switch accuracy🅔 {
      case .Navigation: LocationManager🅞.desiredAccuracy = kCLLocationAccuracyBestForNavigation
      case .Best: LocationManager🅞.desiredAccuracy = kCLLocationAccuracyBest
      case .m10: LocationManager🅞.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      case .m100: LocationManager🅞.desiredAccuracy = kCLLocationAccuracyHundredMeters
      case .Km1: LocationManager🅞.desiredAccuracy = kCLLocationAccuracyKilometer
      case .Km3: LocationManager🅞.desiredAccuracy = kCLLocationAccuracyThreeKilometers
      }
      if authorizationType🅔 == .Permanent { LocationManager🅞.requestAlwaysAuthorization() } else { LocationManager🅞.requestWhenInUseAuthorization() }
      LocationManager🅞.startUpdatingLocation()
      /*
         authorization requests only prompts user when authorization status is kCLAuthorizationStatusNotDetermined
         to react to authorzation changes the CLLocation manager delegate must implement: locationManagerdidChangeAuthorizationStatus()
      */
   }
   
   class func DeactivateLocationTracking() { LocationManager🅞.stopUpdatingLocation() }
   
// this is the function that performs the reverseGeocodeLocation, called from the class location further down
   class func FetchLocationAddress(location🅞 location🅞: Location🅞, completionƒ: (() -> ())? = nil) {
      CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: location🅞.coordinate＃².latitude, longitude: location🅞.coordinate＃².longitude), completionHandler: { (placemarks🅞, error) in
         if error.isNilⓑ() {
            location🅞.country$ = placemarks🅞![0].country
            location🅞.state$ = placemarks🅞![0].administrativeArea
            location🅞.zipCode$ = placemarks🅞![0].postalCode
            location🅞.city$ = placemarks🅞![0].locality
            let streetName$ = placemarks🅞![0].thoroughfare
            let streetNumber$ = placemarks🅞![0].subThoroughfare.isNilⓑ() ? "" : placemarks🅞![0].subThoroughfare! + " "
            location🅞.streetAndNumber$ = streetNumber$ + (streetName$ ?? "")
            completionƒ?()
         } else { print("Error fetching location info\(error!.code): \(error!.description)") }
      })
   }
   
// generates a print-firendly string with the address fields in it
   class func generatePrintAddress$(streetAndNumber$ streetAndNumber$: String? = nil, city$: String? = nil, state$: String? = nil, zipCode$: String? = nil) -> String {
      var output$ = streetAndNumber$ ?? ""
      output$ += output$.isEmpty ? "" : ", " + (city$ ?? "")
      output$ += output$.isEmpty ? "" : ", " + (state$ ?? "") + (zipCode$ ?? "")
      return output$
   }
   
}


/*
   This class encapsulates everything a location needs.
   the method fetchAddress() uses reverseGeocodeLocation indirectly via HKMaps＋.FetchLocationAddress() to fetch the location's address info and store it in its internal properties
*/

class Location🅞: CustomDebugStringConvertible {
   var name$: String?
   var coordinate＃²: CLLocationCoordinate2D
   var streetAndNumber$: String?
   var city$: String?
   var zipCode$: String?
   var state$: String?
   var country$: String?
   
   init(coordinate＃²: CLLocationCoordinate2D = CLLocationCoordinate2D(), name$: String? = nil, address$: String? = nil, city$: String? = nil, zipCode$: String? = nil, state$: String? = nil, country$: String? = nil) {
      self.name$ = name$
      self.coordinate＃² = coordinate＃²
      self.streetAndNumber$ = address$
      self.city$ = city$
      self.zipCode$ = zipCode$
      self.state$ = state$
      self.country$ = country$
   }
   
// fetches the address correntponding to the coordinate and loads it into the internal properties
   func fetchAddress(completionƒ completionƒ: (()->())? ) { HKMaps＋.FetchLocationAddress(location🅞: self, completionƒ: completionƒ) }
   
// generates a 2-line address format to be displayed in a bubble or frame above or next to the map when a pin is selected to show its address info
   var addressForPrint$🅣: (line1$: String, line2$: String) {
      var output$: (line1$: String, line2$: String)
         output$.line1$ = self.streetAndNumber$.isNilⓑ() ? "" : self.streetAndNumber$!
         output$.line2$ = self.city$.isNilⓑ() ? "" : self.city$!
         if self.state$.isNotNilⓑ() && self.zipCode$.isNotNilⓑ() { output$.line2$ += ", " }
         output$.line2$ += self.state$.isNilⓑ() ? "" : self.state$!
         output$.line2$ += self.zipCode$.isNilⓑ() ? "" : " \(self.zipCode$!)"
      return output$
   }
   var hasAddressⓑ: Bool { return (addressForPrint$🅣.line1$ == "" && addressForPrint$🅣.line2$ == "") }
   
   var debugDescription: String { return "Country = \(self.country$)\nState = \(self.state$)\nCity = \(self.city$)\nZipCode = \(self.zipCode$)\nAddress = \(self.streetAndNumber$)" }
}




// practical way to tell the locationManager delegate (usually the viewController), to turn on or off location tracking
extension CLLocationManagerDelegate {
   func startTrackingLocation(accuracy🅔 accuracy🅔: HKMaps＋.trackingAccuracies🅔 = .Best, authorizationType🅔: HKMaps＋.authorizationTypes🅔 = .Active) { HKMaps＋.ActivateLocationTracking(delegate🅞: self, accuracy🅔: accuracy🅔, authorizationType🅔: authorizationType🅔) }
   func stopTrackingLocation() { HKMaps＋.DeactivateLocationTracking() }
}



extension MKMapView {
   
// remove all pins in the map
   func removePins() { for annotation🅞 in self.annotations { self.removeAnnotation(annotation🅞) } }
   
// scales and centers around all pins already existing in the map withough changing map rotation set by user
   func centerAroundPins() {
      if self.annotations.isEmpty { return }
      var maxcoordinate＃² = CLLocationCoordinate2DMake(-999, -999) // by comparing they will increase
      var mincoordinate＃² = CLLocationCoordinate2DMake(999, 999) // by comparing they will reduce
      var centercoordinate＃² = CLLocationCoordinate2D()
      if self.annotations.count == 1 {
         centercoordinate＃².latitude = self.annotations[0].coordinate.latitude
         centercoordinate＃².longitude = self.annotations[0].coordinate.longitude
      } else {
         for annotation🅞 in self.annotations {
            if annotation🅞.coordinate.latitude > maxcoordinate＃².latitude { maxcoordinate＃².latitude = annotation🅞.coordinate.latitude }
            if annotation🅞.coordinate.longitude > maxcoordinate＃².longitude { maxcoordinate＃².longitude = annotation🅞.coordinate.longitude }
            if annotation🅞.coordinate.latitude < mincoordinate＃².latitude { mincoordinate＃².latitude = annotation🅞.coordinate.latitude }
            if annotation🅞.coordinate.longitude < mincoordinate＃².longitude { mincoordinate＃².longitude = annotation🅞.coordinate.longitude  }
         }
         centercoordinate＃².latitude = (mincoordinate＃².latitude + maxcoordinate＃².latitude)/2
         centercoordinate＃².longitude = (mincoordinate＃².longitude + maxcoordinate＃².longitude)/2
      }
      let currentHeading＃ = self.camera.heading
      let maxLocation🅞 = CLLocation(latitude: maxcoordinate＃².latitude, longitude: maxcoordinate＃².longitude)
      let minLocation🅞 = CLLocation(latitude: mincoordinate＃².latitude, longitude: mincoordinate＃².longitude)
      let cameraAltitude＃ = self.annotations.count == 1 ? 6000 : minLocation🅞.distanceFromLocation(maxLocation🅞) * 2.5
      self.setCamera(MKMapCamera(lookingAtCenterCoordinate: centercoordinate＃², fromDistance: cameraAltitude＃, pitch: 0, heading: currentHeading＃), animated: true)
   }

// zooms and centers on the pin is selected by the user
   func centerSelectedPin() {
      self.setCamera(MKMapCamera(lookingAtCenterCoordinate: self.selectedAnnotations.last!.coordinate, fromDistance: self.camera.altitude, pitch: 0, heading: self.camera.heading), animated: true)
   }
   
// launches a search with the specified address, keywords, or natural language, and adds the results as pins in the map replacing previous pins
   func findPOI(query$ query$: String) {
      self.removePins()
      let searchRequest🅞 = MKLocalSearchRequest()
      searchRequest🅞.naturalLanguageQuery = query$
      let search🅞 = MKLocalSearch(request: searchRequest🅞)
      search🅞.startWithCompletionHandler { (searchResponse🅞, error🅞) -> Void in
         if searchResponse🅞.isNilⓑ() { return }
         for mapItem🅞 in searchResponse🅞!.mapItems { // mapItems is an array of results: [MKMapItem]
            let annotation🅞 = MKPointAnnotation()
               annotation🅞.title = mapItem🅞.name
               annotation🅞.coordinate = mapItem🅞.placemark.coordinate
            self.addAnnotation(annotation🅞)
         }
         self.centerAroundPins()
      }
   }
   
// used to add a pin when user LONG-PRESSES on a pint of the map. ( *1 see example further down )
   func addPin(coordinate＃² coordinate＃²: CLLocationCoordinate2D, title$: String = "Unnamed Location", selectedⓑ: Bool = false, uniqueⓑ: Bool = false, completionƒ: (() -> ())? = nil ) {
      if uniqueⓑ { self.removePins() }
      let annotation🅞 = MKPointAnnotation()
         annotation🅞.title = title$
         annotation🅞.coordinate = coordinate＃²
      self.addAnnotation(annotation🅞)
      if selectedⓑ { self.selectAnnotation(annotation🅞, animated: true) }
      self.centerAroundPins()
      if let hikarianMKMapView🅞 = self as? HikarianMKMapView { hikarianMKMapView🅞.loadSelectedPinInfo(annotation🅞: annotation🅞, completionƒ: completionƒ) }
   }
   
/*
    this is called by the mapView delegate function viewForAnnotation() to set the pin's title and custom image ( *2 see example further down )
    I didn't need to add a picture inside the callout but it can also be configured
    You can see this in action in my app demo at http://ikiteruningen.net/demo/ in the Maps video
*/
   func customizePin(annotation🅞 annotation🅞: MKAnnotation, image$: String) -> MKAnnotationView? {
      var annotationView🅞 = self.dequeueReusableAnnotationViewWithIdentifier("customPin")
      if annotationView🅞.isNotNilⓑ() { annotationView🅞!.annotation = annotation🅞 }
      else {
         annotationView🅞 = MKAnnotationView(annotation: annotation🅞, reuseIdentifier: "customPin")
         annotationView🅞!.image = UIImage(named: image$)
      }
      annotationView🅞!.canShowCallout = true
      return annotationView🅞
   }

// show and hide user's location on the map
   func showLocation() { self.showsUserLocation = true }
   func hideLocation() { self.showsUserLocation = false }

// the map's region follows the user location
   func startTrackingLocation(headingⓑ headingⓑ: Bool = false) { if headingⓑ { self.userTrackingMode =  .FollowWithHeading } else { self.userTrackingMode =  .Follow } }
   func stopTrackingLocation() { self.userTrackingMode = .None }
   
// in case tracking is activated we can draw the user's route on the map with polylines
   func drawPolyline(points🅞🅐 points🅞🅐: CLLocationCoordinate2D...) {
      var pointsThatMKPolylineWillSwallow🅐 = [CLLocationCoordinate2D]() // Swift bug: only variables explicitly constructed with all elements in an array are accepted for MKPolyline constructor
      for point🅞 in points🅞🅐 { pointsThatMKPolylineWillSwallow🅐.append(point🅞) }
      let polyline = MKPolyline(coordinates: &pointsThatMKPolylineWillSwallow🅐, count: points🅞🅐.count)
      self.addOverlay(polyline)
   }
   
   /*
      MKMapView delegate must implement the funcion:
   
      func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
         if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 4
            return polylineRenderer
         }
         return MKPolylineRenderer()
      }
   
   */
}

// (*1) This mapView delegate funtion handles the longPress on the mapView
// In this case it tells the mapView to add a pin at the translated coordinates
   @IBAction func mapViewLongPress(sender: UILongPressGestureRecognizer) { // create new pin
      let coordinate＃² = myMapView﹫.convertPoint(sender.locationInView(myMapView﹫), toCoordinateFromView: myMapView﹫)
      myMapView﹫.addPin(coordinate＃²: coordinate＃², title$: "Pin Title", selectedⓑ: true, uniqueⓑ: true) { /* trailing closure completionHandler code */ }
}

// (*2) This mapView delegate funtion request for the appearance of the pins in the map. See reference for MKAnnotationView
   func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
      if annotation is MKUserLocation { return nil } // funny, I don't quite remember why I added this... I'll have to do some tests
      return mapView.customizePin(annotation🅞: annotation, image$: mapPinFlagBlue$)
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
   IBOutlets            ﹫
   
   Example: an array of dictionaries with a string key which value is a tuple of an enum and a number
   myVariable＃🅔🅣$🅓🅐
   
----------------------------------------------------------------------------------------------------------------- */
