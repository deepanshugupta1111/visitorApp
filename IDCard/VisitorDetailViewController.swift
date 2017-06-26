//
//  VisitorDetailViewController.swift
//  IDCard
//
//  Created by thinksysuser on 15/06/17.
//  Copyright © 2017 thinksysuser. All rights reserved.
//

import UIKit
import CoreData
//#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
//#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
class VisitorDetailViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate,UICollectionViewDelegate,UITextFieldDelegate {
    
    @IBOutlet var finalImage : UIImageView?
    @IBOutlet var viewForPrint : UIView?
    @IBOutlet var viewForBottam : UIView?
    @IBOutlet var printCandidateImage : UIImageView?
    @IBOutlet var visitorName : UILabel?
    @IBOutlet var visitorContactTo : UILabel?
    @IBOutlet var visitorAddress : UITextView?
    @IBOutlet var visitorID : UILabel?
    @IBOutlet var visitorIDText : UILabel?
    @IBOutlet var homeImg : UIImageView? = UIImageView()
    
    var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var candidateImageData : NSData?
    var collectionView : UICollectionView?
    var mySearchBar: UISearchBar?
    var VisitorList = [Visitors]()
    var arrayFilteredVisitors = [Visitors]()
    var arrayFilteredNames = [Visitors]()
    var cellButtonView : UIView = UIView()
    var printButton : UIButton = UIButton()
    var preview : UIButton = UIButton()
    var imageView : UIImageView = UIImageView()
    var nameVisitor : UILabel = UILabel()
    var ContectToVisitor : UILabel = UILabel()
    var addressVisitor : UILabel = UILabel()
    var IDVisitor : UILabel = UILabel()
    var selectedCell : UICollectionViewCell?
      var issearch:Bool?
     var islist:Bool  = true
    var textFieldSearch = UITextField()
     var searchView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStores()
        
//Search bar
        
        searchView.frame =  CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.size.width, height: 70)
        
        issearch = false
        
        searchView.backgroundColor = UIColor (colorLiteralRed: 18.0/255.0, green: 132.0/255.0, blue: 255.0/255.0, alpha: 0.5)
        searchView.alpha = 0.9
        searchView.layer.shadowOpacity = 0.7
        
        let imageSearch = UIImageView.init(frame: CGRect(x: 10, y: 20, width: 40, height: 40))
        imageSearch.image = #imageLiteral(resourceName: "SearchIcon")
        
        textFieldSearch.frame = CGRect(x: imageSearch.frame.maxX+3, y: 10, width: searchView.bounds.size.width-55, height: 60)
        textFieldSearch.font = UIFont.systemFont(ofSize: 40, weight: UIFontWeightThin)
        
        textFieldSearch.textColor = UIColor.white
        //        textFieldSearch.layer.borderColor = UIColor.white.cgColor
        //        textFieldSearch.layer.borderWidth = 1.1
        //        textFieldSearch.layer.shadowOpacity = 0.5
        
        textFieldSearch.delegate = self
        
        searchView.addSubview(imageSearch)
        searchView.addSubview(textFieldSearch)
        
        self.view.addSubview(searchView)
        searchView.isHidden = true
        
        // navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Search", style: .plain, target: self, action: #selector(showsearch))
        let searchRightBarButton = UIBarButtonItem.init(image: #imageLiteral(resourceName: "SearchIcon"), style: .plain, target: self, action: #selector(showsearch))
        searchRightBarButton.tintColor = UIColor.white
        
       
        
        self.navigationItem.setRightBarButtonItems([searchRightBarButton], animated: true)
        
        
        //self.methodNavigationBarBackGroundAndTitleColor(kSearchEmployee)
       // self.customizeNavigationBar()

//        mySearchBar = UISearchBar(frame: CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.size.width, height: 50))
//        mySearchBar?.delegate = self
//        
//        mySearchBar?.layer.position = CGPoint(x: self.view.bounds.width/2, y: 24)
//        
//        // add shadow
//        mySearchBar?.layer.shadowColor = UIColor.black.cgColor
//        mySearchBar?.layer.shadowOpacity = 0.5
//        mySearchBar?.layer.masksToBounds = false
//        
//        // hide cancel button
//        mySearchBar?.showsCancelButton = true
//        
//        // hide bookmark button
//        mySearchBar?.showsBookmarkButton = false
//        
//        // set Default bar status.
//        mySearchBar?.searchBarStyle = UISearchBarStyle.default
//        
//        // set title
//       // mySearchBar?.prompt = "Title"
//        
//        // set placeholder
//        mySearchBar?.placeholder = "Input text"
//        
//        // change the color of cursol and cancel button.
//        mySearchBar?.tintColor = UIColor.red
//        
//        // hide the search result.
//        mySearchBar?.showsSearchResultsButton = false
//        
//        // add searchBar to the view.
//        self.view.addSubview(mySearchBar!)
        
// Collection View
       
//   layout.sectionInset = UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20)
//   layout.itemSize = CGSize(width: (self.view.frame.size.width/2)-30, height: 185)
//       if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
//            layout.itemSize = CGSize(width: (self.view.frame.size.width/3)-30, height: 185)
//        } else {
//            layout.itemSize = CGSize(width: (self.view.frame.size.width/2)-30, height: 185)
//        }

//        self.title = "Visitor list"
//        collectionView = UICollectionView(frame: CGRect(x: self.view.frame.origin.x, y: (searchView.frame.origin.y) + (searchView.frame.size.height) + 24, width: self.view.frame.size.width, height: self.view.frame.size.height-(64 + 24 + (searchView.frame.size.height))), collectionViewLayout: layout)
//        collectionView?.dataSource = self
//        collectionView?.delegate = self
//        collectionView?.backgroundColor = UIColor.clear
//        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
//        
//        self.view.addSubview(collectionView!)
        makeCollectionView()
               // Do any additional setup after loading the view.
    }
    func makeCollectionView() {
        let ten0fseconds = (Float(UIScreen.main.bounds.size.width).truncatingRemainder(dividingBy: 350))/3
        
 
        layout.sectionInset = UIEdgeInsets(top: 30, left:CGFloat(ten0fseconds), bottom: 30, right: CGFloat(ten0fseconds))
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width-60)/(UIScreen.main.bounds.size.width/350), height: 185)

//        if UIDevice.current.orientation.isLandscape {
//        layout.itemSize = CGSize(width: (self.view.frame.size.width/3)-30, height: 185)
//        } else {
//        layout.itemSize = CGSize(width: (self.view.frame.size.width/2)-30, height: 185)
//                }
        self.title = "Visitor list"
        if searchView.isHidden == true{
        collectionView = UICollectionView(frame: CGRect(x: self.view.frame.origin.x, y: (searchView.frame.origin.y), width: self.view.frame.size.width, height: UIScreen.main.bounds.size.height-64), collectionViewLayout: layout)
        }else{
        collectionView = UICollectionView(frame: CGRect(x: self.view.frame.origin.x, y: (searchView.frame.origin.y)  + searchView.frame.size.height, width: self.view.frame.size.width, height: UIScreen.main.bounds.size.height-(64  + searchView.frame.size.height)), collectionViewLayout: layout)
        }
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        self.view.addSubview(collectionView!)
    }
    // MARK: - for show or hide searchBar
    func showsearch(){
        
        if issearch == true{
            
            
            textFieldSearch.resignFirstResponder()
            
            issearch = false
            searchView.isHidden = true
            
            if (textFieldSearch.text?.characters.count)! > 0{
                
//                if islist == true{
//                    self.searchEmployeeClVw?.reloadData()
//                }else{
//                    
//                    // objemployeeListView.tableEmployeeListView?.reloadData()
//                }
            }else{
                textFieldSearch.text = ""
                arrayFilteredVisitors = VisitorList
                collectionView?.reloadData()
            }
            
        }else{
            issearch = true
            searchView.isHidden = false
           
            // navigationItem.rightBarButtonItem?.title = "Done"
            
        }
        collectionView?.removeFromSuperview()
        makeCollectionView()
    }

    func getStores() {
        
        let fetchRequest: NSFetchRequest<Visitors> = Visitors.fetchRequest()
        
        do {
            
            self.VisitorList = try contextmanaged.fetch(fetchRequest)
            print("visitor list \(VisitorList[0].name)")
            arrayFilteredVisitors = VisitorList
        } catch {
            
            // handle the error
        }
        
    }
// MARK: - collection View Delegate
    
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayFilteredVisitors.count
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
//        var size : CGSize = CGSize()
//        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
//        size = CGSize(width: (self.view.frame.size.width/3)-60, height: 185)
//       } else {
//        size = CGSize(width: (self.view.frame.size.width/2)-60, height: 185)
//                }
//        return size
//    }
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath)
    cell.subviews.forEach { $0.removeFromSuperview() }
    let item = arrayFilteredVisitors[indexPath.row]
     imageView  =  UIImageView(frame: CGRect(x: CGFloat(10), y: CGFloat(32), width: CGFloat(100), height: CGFloat(100)))
    imageView.layer.cornerRadius = 50
    imageView.clipsToBounds = true
    let candidateImageData = Data(base64Encoded: item.imageData!, options: .ignoreUnknownCharacters) as NSData?
    imageView.image = UIImage(data: candidateImageData as! Data)
    imageView.layer.borderWidth = 1.0
    cell.addSubview(imageView)
   
     nameVisitor = UILabel(frame: CGRect(x: CGFloat(imageView.frame.size.width+15), y: CGFloat(8), width: cell.frame.size.width-130, height: CGFloat(30)))
    nameVisitor.textColor = UIColor.darkGray
    nameVisitor.font = nameVisitor.font.withSize(14.0)
    nameVisitor.layer.borderWidth = 0.3
    nameVisitor.textAlignment = .center
    nameVisitor.layer.cornerRadius = 5.0
    nameVisitor.text = item.name
    nameVisitor.textColor = UIColor.black
    cell.addSubview(nameVisitor)
    
     ContectToVisitor = UILabel(frame: CGRect(x: CGFloat(imageView.frame.size.width+15), y: CGFloat((nameVisitor.frame.maxY)+8), width: cell.frame.size.width-130, height: CGFloat(30)))
    ContectToVisitor.text = item.contactedTo
    ContectToVisitor.layer.borderWidth = 0.3
    ContectToVisitor.textColor = UIColor.darkGray
    ContectToVisitor.font = nameVisitor.font.withSize(15.0)
    ContectToVisitor.layer.cornerRadius = 5.0
    ContectToVisitor.textAlignment = .center
    ContectToVisitor.textColor = UIColor.black
    cell.addSubview(ContectToVisitor)
    
     addressVisitor = UILabel(frame: CGRect(x: CGFloat(imageView.frame.size.width+15), y: CGFloat((ContectToVisitor.frame.maxY)+8), width: cell.frame.size.width-130, height: CGFloat(60)))
    addressVisitor.numberOfLines = 3
    addressVisitor.textColor = UIColor.darkGray
    addressVisitor.font = nameVisitor.font.withSize(16.0)
    addressVisitor.text = item.address
    addressVisitor.textAlignment = .center
    addressVisitor.layer.borderWidth = 0.3
    addressVisitor.layer.cornerRadius = 5.0
    addressVisitor.textColor = UIColor.black
    cell.addSubview(addressVisitor)
    
     IDVisitor = UILabel(frame: CGRect(x: CGFloat(imageView.frame.size.width+15), y: CGFloat((addressVisitor.frame.maxY)+8), width: cell.frame.size.width-130, height: CGFloat(30)))
    if item.idProof == "Label" {
        IDVisitor.isHidden = true
    }else{
        IDVisitor.isHidden = false
    }
    IDVisitor.text = item.idProof
    IDVisitor.layer.borderWidth = 0.3
    IDVisitor.textColor = UIColor.darkGray
    IDVisitor.font = nameVisitor.font.withSize(17.0)
    IDVisitor.textAlignment = .center
    IDVisitor.textColor = UIColor.black
    IDVisitor.layer.cornerRadius = 5.0
    cell.addSubview(IDVisitor)
    cell.layer.borderWidth = 1.0
    cell.layer.cornerRadius = 10.0
    cell.backgroundColor = UIColor.white
    cell.backgroundView?.alpha = 0.3
    
        return cell
    }
   func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool{
        
        selectedCell  = collectionView.cellForItem(at: indexPath)!
    
        cellButtonView = UIView(frame: CGRect(x:0, y: (selectedCell?.frame.size.height)!, width: (selectedCell?.frame.size.width)!, height: 40))
    cellButtonView.backgroundColor = UIColor (colorLiteralRed: 58.0/255.0, green: 157.0/255.0, blue: 215.0/255.0, alpha: 1.0)
    cellButtonView.alpha = 0.5
    selectedCell?.addSubview(cellButtonView)
    printButton = UIButton(frame: CGRect(x: 10, y: cellButtonView.frame.origin.y + 10, width: 80, height: 25))
    printButton.titleLabel?.text = "Print"
    printButton.setTitle("Print", for: .normal)
    printButton.titleLabel?.textColor = UIColor.white
    printButton.setTitleColor(UIColor.white, for: .normal)
    printButton.backgroundColor = UIColor (colorLiteralRed: 29.0/255.0, green: 72.0/255.0, blue: 106.0/255.0, alpha: 1.0)
    printButton.addTarget(self, action: #selector(printButtonTapped(button:)), for: .touchUpInside)
    selectedCell?.addSubview(printButton)
    
    preview = UIButton(frame: CGRect(x:cellButtonView.frame.size.width-90, y: cellButtonView.frame.origin.y + 10, width: 80, height: 25))
    preview.titleLabel?.text = "Preview"
    preview.setTitle("Preview", for: .normal)
    preview.setTitleColor(UIColor.white, for: .normal)
    preview.titleLabel?.textColor = UIColor.white
    preview.backgroundColor = UIColor (colorLiteralRed: 29.0/255.0, green: 72.0/255.0, blue: 106.0/255.0, alpha: 1.0)
    arrayFilteredNames = [arrayFilteredVisitors[indexPath.row]]
    preview.addTarget(self, action: #selector(previewButtonTapped(button:)), for: .touchUpInside)
    selectedCell?.addSubview(preview)
   selectedCell?.clipsToBounds = true
 
    let top = CGAffineTransform(translationX: 0, y: -40)
    
    UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: {
        // Add the transformation in this block
        // self.container is your view that you want to animate
        self.cellButtonView.transform = top
        self.printButton.transform = top
        self.preview.transform = top
    }, completion: nil)

// 
//    UIView.transition(with: cellButtonView, duration: 10.0, options: .transitionCurlDown, animations: { _ in
//       self.cellButtonView.frame.size.height = 40
//      
//    }, completion: nil)
    
//    UIView.animate(withDuration: 1.0, animations: {
//        self.cellButtonView.frame.origin.y = selectedCell.frame.size.height-40
//
//    })
    
        return true
    }
    
   // MARK: - Button Action

// Method For Print Button
    func printButtonTapped(button: UIButton){
        self.cellButtonView.isHidden = true
        self.printButton.isHidden = true
        self.preview.isHidden = true
        self.homeImg?.isHidden = true
        selectedCell?.backgroundColor = UIColor.white
        selectedCell?.layer.cornerRadius = 4.0
        UIGraphicsBeginImageContextWithOptions((selectedCell?.bounds.size)!, true, 0)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        selectedCell?.layer.render(in: context!)
        let imageFromCurrentView: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        finalImage?.image = imageFromCurrentView
        //
        collectionView?.isHidden = true
        searchView.isHidden = true
        
        finalImage?.isHidden = false
        printImageForPrinter()
        collectionView?.removeFromSuperview()
        print("Button pressed")
    }
// Method For preview Button
    func previewButtonTapped(button: UIButton){
        
        viewForPrint?.isHidden = false
        searchView.isHidden = true
        collectionView?.removeFromSuperview()
        viewForBottam?.isHidden = false
        
        self.visitorName?.text = arrayFilteredNames[0].name
        self.visitorContactTo?.text = arrayFilteredNames[0].contactedTo
        if arrayFilteredNames[0].idProof == "Label"{
            visitorID?.isHidden = true
            visitorIDText?.isHidden = true
        }else{
            self.visitorIDText?.text = arrayFilteredNames[0].idProof
            visitorID?.isHidden = false
            self.visitorIDText?.isHidden = false
        }
        self.visitorAddress?.text = arrayFilteredNames[0].address
        candidateImageData = Data(base64Encoded: arrayFilteredNames[0].imageData!, options: .ignoreUnknownCharacters) as NSData?
        printCandidateImage?.image = UIImage(data: candidateImageData as! Data)
        collectionView?.removeFromSuperview()
        print(arrayFilteredNames)
        print("Button pressed")
    }
// Method For prinyt card
    @IBAction func printID(_ sender: Any) {
        
        finalImage?.isHidden = false
            UIGraphicsBeginImageContextWithOptions((viewForPrint?.bounds.size)!, true, 0)
            let context: CGContext? = UIGraphicsGetCurrentContext()
            viewForPrint?.layer.render(in: context!)
            let imageFromCurrentView: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            finalImage?.image = imageFromCurrentView
            //
            
            
            
        self.homeImg?.isHidden = true
        viewForPrint?.isHidden = true
        viewForBottam?.isHidden = true
        printImageForPrinter()
        
    }

    func printImageForPrinter() {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        view.layer.render(in: context!)
        let imageFromCurrentView: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let currentPrinterObj = UIPrinter(url: URL(string: "http://10.101.21.22/ipp/print")!)
        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.outputType = UIPrintInfoOutputType.general
        let printController = UIPrintInteractionController.shared
        printController.showsPaperSelectionForLoadedPapers = true
        printController.printInfo = printInfo
        printController.printingItem = imageFromCurrentView
        printController.print(to: currentPrinterObj, completionHandler: {(_ printController: UIPrintInteractionController, _ completed: Bool, _ error: Error?) -> Void in
            if completed {
                print("completed")
                
            }
            
            else {
                print("there is an error in printer")
            }
            self.collectionView?.isHidden = false
            self.mySearchBar?.isHidden = false
            self.finalImage?.isHidden = true
            self.viewForPrint?.isHidden = true
            self.viewForBottam?.isHidden = true
            self.homeImg?.isHidden = false
            self.resetTableToInitial()
        })
    }

    // called whenever text is changed.
//   func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//       
//        var newString:NSString? = (mySearchBar?.text as NSString?)?.replacingCharacters(in:range , with: text) as NSString?
//        newString = newString?.trimmingCharacters(in: .whitespaces) as NSString?
//    
//   
//    let predicate = NSPredicate(format: "name CONTAINS[cd] %@", newString ?? "")
//    
//    arrayFilteredVisitors = VisitorList.filter { predicate.evaluate(with: $0) }
//
//        //arrayFilteredNames = arrayFilteredVisitors.value(forKey: "name") as? NSArray
//        if (newString?.length)! > 0 {
//        collectionView?.reloadData()
//        }
//        else{
//            self.resetTableToInitial()
//        }
//   return true
//    }
    
    // called when cancel button is clicked
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//      
//        mySearchBar?.text = ""
//        arrayFilteredVisitors = VisitorList
//        collectionView?.reloadData()
//    }
    
    // called when search button is clicked
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//       
//        mySearchBar?.text = ""
//        self.resetTableToInitial()
//        
//    }
    
    // MARK: - text Field Delegate
    func textFieldDidBeginEditing(_ textField: UITextField){
        textFieldSearch.text = ""
        self.resetTableToInitial()
    }
    func textFieldDidEndEditing(_ textField: UITextField){
        textFieldSearch.text = ""
        collectionView?.reloadData()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        var newString:NSString? = (textFieldSearch.text as NSString?)?.replacingCharacters(in:range , with: string) as NSString?
        newString = newString?.trimmingCharacters(in: .whitespaces) as NSString?
        
        
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", newString ?? "")
        
        arrayFilteredVisitors = VisitorList.filter { predicate.evaluate(with: $0) }
        
        //arrayFilteredNames = arrayFilteredVisitors.value(forKey: "name") as? NSArray
        if (newString?.length)! > 0 {
            collectionView?.reloadData()
        }
        else{
            self.resetTableToInitial()
        }
        return true

    }
    func resetTableToInitial(){
        arrayFilteredVisitors = VisitorList
        collectionView?.reloadData()
    }
  
//    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
//        collectionView?.removeFromSuperview()
//        makeCollectionView()
//    }
   override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        collectionView?.removeFromSuperview()
        makeCollectionView()

    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        collectionView?.removeFromSuperview()
//        makeCollectionView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
