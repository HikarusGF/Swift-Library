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

class HikarianUIWebView: UIWebView {
   
   var requestedURL$ = String() // the user-requested URL
   var lastURL$ = String() // last attempted URL
   
// if user inputs for example apple.com, the webView will fail to load, so the http:// will be tried, and finally, the http://wwww prefix will be successful
// there is a demo of how this works in the app I'm building at http://ikiteruningen.net/demo/ (videos section)
   var URLSyntaxes$ = ["http://", "http://www.", "https://", "https://www.google.com/#q="]
   
   var syntaxAttemptIndex＃: Int = 0
   var activityIndicatorⓒ = UIActivityIndicatorView()
   var showActivityIndicator❶: Bool = true
   
// this internal function is used by the class instance methods but it's not part of the public API. Called in (*1)
   private func fetchURL(URL$: String, activityIndicator❶: Bool = true) { // INTERNAL
      lastURL$ = URL$
      self.loadRequest(NSURLRequest(URL: NSURL(string: URL$)!)) // fails if there are spaces. Must control before, not let throw error
   }
   
// main method that loads a website on the webView
   func loadURL(URL$: String, activityIndicator❶: Bool = true) { // PUBLIC API
      requestedURL$ = URL$.trimmed$.lowercaseString; showActivityIndicator❶ = activityIndicator❶
      if URL$.containsString(" ") {
         requestedURL$ = requestedURL$.stringByReplacingOccurrencesOfString(" ", withString: "+")
         syntaxAttemptIndex＃ = 3
      } else { syntaxAttemptIndex＃ = 0 }
      if showActivityIndicator❶ { setActivityIndicator() }
      if activityIndicator❶ { self.addSubview(activityIndicatorⓒ); activityIndicatorⓒ.startAnimating() }
      fetchURL(requestedURL$, activityIndicator❶: activityIndicator❶) //  (*1) calling internal function fetchURL()
   }

// this funciton is called by the delegate method: webView(webView: UIWebView, didFailLoadWithError error: NSError?) implemented below in the ViewController (*2)
// when the webView fails to load a URL, attempts to complete the URL are made and if no combination is successful it loads a google search with the keybords
   func retry() -> String {
      if syntaxAttemptIndex＃ <= URLSyntaxes$.maxIndex＃ {
         let newURL$ = URLSyntaxes$[syntaxAttemptIndex＃++] + requestedURL$
         fetchURL(newURL$, activityIndicator❶: showActivityIndicator❶)
         return newURL$
      }
      else { return "" }
   }

// this webView subclass comes with a built-in "spinner" or activity indicator
   func setActivityIndicator() {
      activityIndicatorⓒ.activityIndicatorViewStyle = .WhiteLarge
      activityIndicatorⓒ.color = UIColor(CGColor: self.layer.borderColor ?? UIColor.blackColor().CGColor)
      activityIndicatorⓒ.hidesWhenStopped = true
      activityIndicatorⓒ.centerInObjectFrame(object﹖: self) // size needs not to be specified since it's fixed, and setting it in the frame is ignored
   }
   
// this funciton is called by the delegate method below: webViewDidFinishLoad() implemented in the ViewController
   func stopActivityIndicator() { activityIndicatorⓒ.stopAnimating() }

}

// WEBVIEW DELEGATE FUNCTIONS --------------------------------------------------------------------------------------------------

// when the webView successfully loads a website
   func webViewDidFinishLoad(webView: UIWebView) {
      let hikarianWebView = webView as! HikarianUIWebView
      hikarianWebView.stopActivityIndicator()
      if hikarianWebView.lastURL$.containsString("https://www.google.com/#q=") { searchTextField﹫.text = webViewURLNotFound$ } else { searchTextField﹫.text = hikarianWebView.lastURL$ }
      backButton﹫.enabled = hikarianWebView.canGoBack; forwardButton﹫.enabled = hikarianWebView.canGoForward
   }

// (*2) when the webView fails to load it calls retry()
   func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
      let hikarianWebView = webView as! HikarianUIWebView
      if error?.code == 102 || error?.code == -1003 { // 102 == "NOT FOUND"
         let correctedURL$ = hikarianWebView.retry() // attempt to complete the given URL with prefixes in the property URLSyntaxes$
         searchTextField﹫.text = correctedURL$
      } else { // NETWORK ERROR
         hikarianWebView.stopActivityIndicator()
         searchTextField﹫.text = webViewNetworkError$
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
