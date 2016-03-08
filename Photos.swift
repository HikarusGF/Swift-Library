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

class HKPhotos＋ { // * a fetch result is an array of AnyObject *

// not sure about the future of these two properties. There is API to get localized titles. I'll eventually get to it
   static let CameraRollLocalizedTitles$🅐 = ["Camera Roll", "カメラロール"]
   static let VideoAlbumLocalizedTitles$🅐 = ["Videos", "ビデオ"]

// ARRAY versions: This structure stores a photo album with with low-resolution thumbnail and without fetched assets to take up less RAM and processor
   typealias PhotoAlbumList🅐Item🅞🅐$🅣 = (title$: String, albumⓐ🅒: PHAssetCollection, thumbNailⓐ: PHAsset)
   typealias PhotoAlbumList🅞🅐$🅣🅐 = [PhotoAlbumList🅐Item🅞🅐$🅣]
   class func Album🅐SortCriterionⓑ(album1🅐$🅣: PhotoAlbumList🅐Item🅞🅐$🅣, album2🅞🅐$🅣: PhotoAlbumList🅐Item🅞🅐$🅣) -> Bool {
      if HKPhotos＋.CameraRollLocalizedTitles$🅐.contains(album1🅐$🅣.title$) { return true } else if HKPhotos＋.CameraRollLocalizedTitles$🅐.contains(album2🅞🅐$🅣.title$) { return false } else { return album1🅐$🅣.title$ < album2🅞🅐$🅣.title$ }
   }
// DICTIONARY versions
   typealias PhotoAlbumList🅓Item🅞🅐$🅣 = (albumⓐ🅒: PHAssetCollection, thumbNailⓐ: PHAsset)
   typealias PhotoAlbumList🅞🅐🅣$🅓 = [String : PhotoAlbumList🅓Item🅞🅐$🅣]
   
// stores unfetched and fetched assets. Method fetchPicturesⓐ🅐() fetches assets and loads them onto iamgesⓐ🅐
   class PhotoAlbum🅞 {
      var albumⓐ🅒 = PHAssetCollection() // pointers: unfetched assets
      var imagesⓐ🅐 = [PHAsset]()  // fetches images
      init(albumⓐ🅒: PHAssetCollection = PHAssetCollection(), imagesⓐ🅐:[PHAsset] = [PHAsset]()) { self.albumⓐ🅒 = albumⓐ🅒; self.imagesⓐ🅐 = imagesⓐ🅐 }
      func fetchPicturesⓐ🅐() {
         imagesⓐ🅐.removeAll()
         let fetchOptions🅞 = PHFetchOptions()
         fetchOptions🅞.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: NO)]
         let pictures﹖🅐  = PHAsset.fetchAssetsInAssetCollection(albumⓐ🅒, options: fetchOptions🅞)
         if pictures﹖🅐.isNotEmptyⓑ { pictures﹖🅐.enumerateObjectsUsingBlock({ (image﹖, index, pointer) -> Void in self.imagesⓐ🅐.append(image﹖ as! PHAsset) }) }
      }
   }
   
// ARRAY version: fetches the list of photo albums in the device
   class func FetchAlbumList🅞🅐(thumbnailSizeⓖ² thumbnailSizeⓖ²: CGSize? = nil) -> PhotoAlbumList🅞🅐$🅣🅐 { // if thumbnailSizeⓖ² is ommited the thumbnails are not fetched
      var albumList🅐 = PhotoAlbumList🅞🅐$🅣🅐()
      for albumType🅔 in [PHAssetCollectionType.SmartAlbum, .Album/*, .Moment*/] {
         let albums🅐: PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(albumType🅔, subtype: .Any, options: nil) // get list of albums
         albums🅐.enumerateObjectsUsingBlock { (album﹖, index＃, pointerⓟ⃗) -> Void in // iterate in each album
            let albumⓐ🅒 = album﹖ as! PHAssetCollection
            let fetchOptions🅞 = PHFetchOptions()
            fetchOptions🅞.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: NO)]
            fetchOptions🅞.predicate = NSPredicate(format: "mediaType = \(PHAssetMediaType.Image.rawValue)")
            let pictures﹖🅐  = PHAsset.fetchAssetsInAssetCollection(albumⓐ🅒, options: fetchOptions🅞) // get list of pictures in album (not the images inside the 'assets')
            if !VideoAlbumLocalizedTitles$🅐.contains(albumⓐ🅒.localizedTitle!) && pictures﹖🅐.isNotEmptyⓑ { // empty albums are not listed
               var item🅣: (title$: String, albumⓐ🅒: PHAssetCollection, thumbNailⓐ: PHAsset)
               item🅣.title$ = albumⓐ🅒.localizedTitle!
               item🅣.albumⓐ🅒 = albumⓐ🅒
               item🅣.thumbNailⓐ = pictures﹖🅐.firstObject as! PHAsset
               albumList🅐.append(item🅣)
            }
         }
      }
      albumList🅐.sortInPlace(Album🅐SortCriterionⓑ)
      return albumList🅐
   }
   
// DICTIONARY version: fetches the list of photo albums in the device
   class func FetchAlbumList🅞🅓(thumbnailSizeⓖ² thumbnailSizeⓖ²: CGSize? = nil) -> PhotoAlbumList🅞🅐🅣$🅓 { // if converSize is ommited the thumbnails are not fetched
      var albumList🅓 = PhotoAlbumList🅞🅐🅣$🅓()
      for albumType🅔 in [PHAssetCollectionType.SmartAlbum, .Album/*, .Moment*/] {
         let albums🅐: PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(albumType🅔, subtype: .Any, options: nil)
         albums🅐.enumerateObjectsUsingBlock { (album﹖, index＃, pointerⓟ⃗) -> Void in
            let albumⓐ🅒 = album﹖ as! PHAssetCollection
            let fetchOptions🅞 = PHFetchOptions()
            fetchOptions🅞.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: NO)]
            let pictures﹖🅐  = PHAsset.fetchAssetsInAssetCollection(albumⓐ🅒, options: fetchOptions🅞)
            if !VideoAlbumLocalizedTitles$🅐.contains(albumⓐ🅒.localizedTitle!) && pictures﹖🅐.isNotEmptyⓑ { albumList🅓[albumⓐ🅒.localizedTitle!] = (albumⓐ🅒, pictures﹖🅐.firstObject as! PHAsset) }
         }
      }
      return albumList🅓
   }
   
// shortcuts to register an object as photo library observer
   class func RegisterPhotoLibaryObserver(observer🅞 observer🅞: PHPhotoLibraryChangeObserver) { PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(observer🅞) }
   class func UnregisterPhotoLibraryObserver(observer🅞 observer🅞: PHPhotoLibraryChangeObserver) { PHPhotoLibrary.sharedPhotoLibrary().unregisterChangeObserver(observer🅞) }
   
}
/*
  requestImageForAsset() should be called from cellForItemAtIndexPath() because it's an asynchronous process that assigns the results of the fetch to a memory address it will be called in as many passes as necessary for the image to be loaded in full definition for the requested size
  in my tests where I invoked it indirectly from a library funcion I experienced a slight but noticeable delay and some pictures were blur for a fraction of a second until they finished loading
*/
   func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell { 
      let cell🅞 = HKCollectionView.dequeueReusableCellWithReuseIdentifier("photoAlbumThumnailsCell", forIndexPath: indexPath)
            let thumbnailCell🅞 = cell as! AlbumThumnailsCollectionViewCell 
            PHImageManager.defaultManager().requestImageForAsset(currentPhotoAlbum🅞.imagesⓐ🅐[indexPath.item], targetSize:  albumItemThumnailSizeⓖ², contentMode: .AspectFill, options: nil, resultHandler: { (image: UIImage?, info: [NSObject : AnyObject]?) -> Void in thumbnailCell🅞.albumThumbnailIV﹫.image = image })
      return cell
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
