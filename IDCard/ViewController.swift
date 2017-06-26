//
//  ViewController.swift
//  IDCard
//
//  Created by thinksysuser on 09/06/17.
//  Copyright © 2017 thinksysuser. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField
import CoreData


class ViewController: UIViewController,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet var textFieldFirstName:JVFloatLabeledTextField?
    @IBOutlet var textFieldLastName:JVFloatLabeledTextField?
    @IBOutlet var textFieldFatherName:JVFloatLabeledTextField?
    @IBOutlet var textFieldContactedPerson:JVFloatLabeledTextField?
    @IBOutlet var textFieldMobileNumber:JVFloatLabeledTextField?
    @IBOutlet var textFieldEmailID:JVFloatLabeledTextField?
    @IBOutlet var textFieldBuildingNumber:JVFloatLabeledTextField?
    @IBOutlet var textFieldStreat:JVFloatLabeledTextField?
    @IBOutlet var textFieldCountry:JVFloatLabeledTextField?
    @IBOutlet var textFieldState:JVFloatLabeledTextField?
    @IBOutlet var textFieldCity:JVFloatLabeledTextField?
    @IBOutlet var textFieldPinCode:JVFloatLabeledTextField?
    @IBOutlet var textFieldIDProof:JVFloatLabeledTextField?
    
    @IBOutlet var labelMonth : UILabel?
    @IBOutlet var date : UILabel?
    @IBOutlet var year : UILabel?
    @IBOutlet var viewForDetail : UIView?
    @IBOutlet var printButton : UIButton?
    @IBOutlet var candidatePicture : UIImageView?
    @IBOutlet var scrollView : UIScrollView?
    
    @IBOutlet var printCandidateImage : UIImageView?
    @IBOutlet var visitorName : UILabel?
    @IBOutlet var visitorContactTo : UILabel?
    @IBOutlet var visitorAddress : UITextView?
    @IBOutlet var visitorID : UILabel?
    @IBOutlet var visitorIDText : UILabel?
    @IBOutlet var viewForPrint : UIView?
    @IBOutlet var containerView : UIView?
    @IBOutlet var finalImage : UIImageView?
    
     var imageData : NSData?
     var candidateImageData : NSData?
    
    var arrIDProof : NSMutableArray?
    var arrContactedPerson : NSArray?
    var textFieldArray : NSMutableArray!
    var mendantoryTextFieldArray : NSMutableArray!
    var tblView : UITableView?
    var  activeTextField : UITextField?
    var labelForErrorMessageEmail : UILabel?
    var labelForErrorMessageContact : UILabel?
    var  labelForErrorMessagePinCode : UILabel?
    var arrayCity : NSArray?
    var arrayState : NSMutableArray?
    var goNextView : Bool?
    var isFilterCity : Bool?
    var isFilterCountry : Bool?
    var AllCountryAndCity : NSMutableDictionary?
    var allCity: NSMutableArray?
    var textFieldIntervieweeID : UITextField?
    var allCountry: NSMutableArray?
    var arrayCountry : NSArray?
    var  searchResultsCity: NSArray?
    var  searchResultsContact: NSArray?
    var searchResultsState : [AnyObject] = []
    var  strBase64 : String?
    var VisitorList = [Visitors]()
    override func viewDidLoad() {
        

    arrIDProof = ["Driving Licence", "Pan Card", "Aadhar Card", "Voter ID", "Passport", "Other"]
        arrContactedPerson = [ "Rajiv Jain","Deepika Kamal","Rajiv R Jha","Pooja Pandey","Ruchik Tyagi","Ashish Sharma","Rajni Kant Jha","Siddharth Sharma","Arun Singh","Mahendra Pratap Singh","Ashok (office boy)"]
        searchResultsContact = arrContactedPerson
    self.title = "Visitor Detail"
    navigationController?.navigationBar.titleTextAttributes=[NSForegroundColorAttributeName:UIColor .white]
    navigationController?.navigationBar.tintColor = UIColor .white
    navigationController?.navigationBar.isTranslucent = false
     
//    textFieldCountry?.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
//    textFieldCity?.addTarget(self, action: #selector(self.textFieldDidChangeCity), for: .editingChanged)

        
//Code for show current date
      isFilterCountry = false

    var dateDic: [AnyHashable: Any] = SplitDate() as! [AnyHashable : Any]
    date?.text = dateDic["day"] as! String?
    year?.text = dateDic["year"] as! String?
   labelMonth?.text = dateDic["month"] as! String?
     

        callCountry()
//        [self callStateData];
   textFieldArray = [textFieldFirstName! as JVFloatLabeledTextField, textFieldLastName! as JVFloatLabeledTextField, textFieldFatherName! as JVFloatLabeledTextField, textFieldContactedPerson! as JVFloatLabeledTextField, textFieldMobileNumber! as JVFloatLabeledTextField, textFieldEmailID! as JVFloatLabeledTextField, textFieldBuildingNumber! as JVFloatLabeledTextField, textFieldStreat! as JVFloatLabeledTextField, textFieldState! as JVFloatLabeledTextField,textFieldCountry! as JVFloatLabeledTextField,textFieldCity! as JVFloatLabeledTextField, textFieldPinCode! as JVFloatLabeledTextField,textFieldIDProof! as JVFloatLabeledTextField]
   mendantoryTextFieldArray = [textFieldFirstName! as JVFloatLabeledTextField, textFieldLastName! as JVFloatLabeledTextField, textFieldFatherName! as JVFloatLabeledTextField, textFieldContactedPerson! as JVFloatLabeledTextField, textFieldMobileNumber! as JVFloatLabeledTextField,  textFieldBuildingNumber! as JVFloatLabeledTextField, textFieldStreat! as JVFloatLabeledTextField, textFieldCountry! as JVFloatLabeledTextField,textFieldCity! as JVFloatLabeledTextField, textFieldPinCode! as JVFloatLabeledTextField]
   for tf  in textFieldArray! {
    let borderColor = UIColor (colorLiteralRed: 210.0/255.0, green: 209.0/255.0, blue: 214.0/255.0, alpha: 1.0).cgColor
    
    setTextFieldBorder(tf as! JVFloatLabeledTextField, color: borderColor )
    let paddingView = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(5), height: CGFloat(5)))
            //[paddingView addSubview:imgView];
    (tf as! UITextField).leftViewMode = .always
    (tf as! UITextField).leftView = paddingView
        }
   
   //Action for UIImage view
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapDetected))
        singleTap.numberOfTapsRequired = 1 // you can change this value
        candidatePicture?.isUserInteractionEnabled = true
        candidatePicture?.addGestureRecognizer(singleTap)
        
    let singleFingerTap = UITapGestureRecognizer(target: self, action: #selector(self.handleSingleTap))
        
    scrollView?.contentSize = CGSize(width: (scrollView?.frame.size.width)!, height: (scrollView?.frame.size.height)!)
    singleFingerTap.delegate=self;
    view.addGestureRecognizer(singleFingerTap)
//        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
       override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
 // MARK: - imageView Action for click image
    func tapDetected() {
        clickImageView()
        print("Imageview Clicked")
    }
// pick image from camera
    func clickImageView()   {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.cameraDevice = .front
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: { _ in })
        }
        else {
            let alert = UIAlertView(title: "Camera Unavailable", message: "Unable to find a camera on your device.", delegate: nil, cancelButtonTitle: "OK", otherButtonTitles: "")
            alert.show()
            
        }

    }
   // MARK: - Gesture delegate
    func handleSingleTap(_ recognizer: UITapGestureRecognizer) {
        activeTextField?.resignFirstResponder()
        tblView?.removeFromSuperview()
        tblView = nil
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if tblView == nil {
         return true
        }
        if (touch.view?.isDescendant(of: tblView!))! {
            return false
        }
        return true
    }
    // MARK: - Local method
    
    func resetTableToInitial(){
        arrayCountry = allCountry
        tblView?.reloadData()
    }
    func resetTableCityToInitial(){
        searchResultsCity = arrayCity
        tblView?.reloadData()
    }
    func resetTableContactedPersonToInitial(){
        searchResultsContact = arrContactedPerson
        tblView?.reloadData()
    }
    
 // For mobile number format
    func formatNumber(_ mobileNumber: String) -> String {
        let length = Int(methodForStringReplacing(stringInput: mobileNumber).characters.count)
        var newMobileNumber = mobileNumber
        
        if length > 10 {
            newMobileNumber = ((mobileNumber as? NSString)?.substring(from: length - 10))!
        }
        return newMobileNumber
    }
    
// this method is use to get the length of mobile number
    func getLength(_ mobileNumber: String) -> Int {
        let length = Int(methodForStringReplacing(stringInput: mobileNumber).characters.count)
        return length
    }
    

    func methodForStringReplacing(stringInput : String) -> String {
        var mobileNumber = stringInput
        do {
            mobileNumber = stringInput.replacingOccurrences(of: "(", with: "")
            mobileNumber = stringInput.replacingOccurrences(of: ")", with: "")
            mobileNumber = stringInput.replacingOccurrences(of: " ", with: "")
            mobileNumber = stringInput.replacingOccurrences(of: "-", with: "")
            mobileNumber = stringInput.replacingOccurrences(of: "+", with: "")
            return mobileNumber
        }
    }
    
//For split date
    func SplitDate() -> NSDictionary {
        let date = Date()
        
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let df = DateFormatter()
        let monthName: String? = (df.monthSymbols[(month - 1)] as? String)
        let day = calendar.component(.day, from: date)
        let dic: [AnyHashable: Any] = [
            "year" : "\(Int(year))",
            "month" : monthName as Any,
            "day" : "\(Int(day))"
            
        ]
        
        return dic as NSDictionary
    }
    
    
//For Border Colour
    func setTextFieldBorder(_ textField: JVFloatLabeledTextField, color: CGColor) {
        textField.layer.borderWidth = 0.0
        let border = CALayer()
        let borderWidth: CGFloat = 1
        border.borderColor = color
        border.frame = CGRect(x: CGFloat(0), y: CGFloat(textField.frame.size.height - borderWidth), width: CGFloat(textField.frame.size.width), height: CGFloat(textField.frame.size.height))
        border.borderWidth = borderWidth
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
 //For get all country
    func callCountry()  {
        let url = URL(string: "https://raw.githubusercontent.com/David-Haim/CountriesToCitiesJSON/master/countriesToCities.json")
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
        let json = try! JSONSerialization.jsonObject(with: data, options: [])

        if let dicJson:NSDictionary = json as? NSDictionary
            {
                
                
                self.AllCountryAndCity = NSMutableDictionary(dictionary: dicJson)
                
                
            }
            
            // self.allCountry = NSArray(array: (self.AllCountryAndCity?.allKeys)!)
            self.allCountry = NSMutableArray(array: (self.AllCountryAndCity?.allKeys)!)
            self.allCountry?.remove("")
            
            self.arrayCountry = self.allCountry
            
            print(self.allCountry?.count as Any)
            
        }
        
        task.resume()
    }
//For get all city
    func callCity()  {
        let country : String = (textFieldCountry?.text)!
        
        arrayCity = self.AllCountryAndCity?.object(forKey: country)
            as! NSArray?
        searchResultsCity = arrayCity
        createTableView(3, and: textFieldCity!)
        
    }
//For email validation
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    // MARK: - textField delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        tblView?.removeFromSuperview()
        tblView = nil
         activeTextField=textField;
        setTextFieldBorder(textField as! JVFloatLabeledTextField, color: UIColor (colorLiteralRed: 210.0/255.0, green: 209.0/255.0, blue: 214.0/255.0, alpha: 1.0).cgColor)
        textField.layer.borderColor = UIColor.lightGray.cgColor
        if textField == textFieldIDProof {
            if tblView == nil {
              createTableView(1, and: textFieldIDProof!)
            }
            else {
                tblView?.removeFromSuperview()
                tblView = nil
            }
            return false
        }
        else if textField == textFieldCountry {
            textFieldCity?.text="";
            if tblView == nil {
                createTableView(2, and: textFieldCountry!)
            }
            else {
                tblView?.removeFromSuperview()
                tblView = nil
            }
            return true
        }
            else if (textField == textFieldEmailID ){
            labelForErrorMessageEmail?.isHidden = true
            activeTextField=textField;
            tblView?.removeFromSuperview()
            tblView = nil;
        }else if (textField == textFieldMobileNumber ){
            
            labelForErrorMessageContact?.isHidden = true
            activeTextField=textField;
            tblView?.removeFromSuperview()
            tblView = nil;
        }
        else if (textField == textFieldPinCode  ){
            
            labelForErrorMessagePinCode?.isHidden = true
            activeTextField=textField;
           tblView?.removeFromSuperview()
            tblView = nil;
        }
        else if (textField == textFieldState ){
            
            
            activeTextField=textField;
            if (tblView == nil) {
                //[self createTableView:2 and:textField];
            }
            return true;
        }
         else if textField == textFieldCity {
            if textFieldCountry?.text == "" {
                textFieldCountry?.layer.borderColor = UIColor.red.cgColor
                return false
            }
            else {
                activeTextField = textField
                if tblView == nil {
                    callCity()
                }
                return true
            }
        }else if textField == textFieldContactedPerson{
            if tblView == nil {
                createTableView(4, and: textFieldContactedPerson!)
            }
            else {
                tblView?.removeFromSuperview()
                tblView = nil
            }
            return true
        }
        else {
            activeTextField = textField
            tblView?.removeFromSuperview()
            tblView = nil
        }
        return true
    }
    
       func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == textFieldEmailID {
            if textField.text == "" {
                
            }
       else {
        if !isValidEmail(testStr: textField.text!) {
        labelForErrorMessageEmail = UILabel(frame: CGRect(x: CGFloat(textField.frame.origin.x), y: CGFloat(textField.frame.maxY), width: CGFloat(textField.frame.size.width), height: CGFloat(12)))
        labelForErrorMessageEmail?.textColor = UIColor.red
        labelForErrorMessageEmail?.font = UIFont.systemFont(ofSize: CGFloat(10))
        labelForErrorMessageEmail?.isHidden = false
        labelForErrorMessageEmail?.text = "please enter valid Email Id "
        textField.layer.borderColor = UIColor.red.cgColor
        viewForDetail?.addSubview(labelForErrorMessageEmail!)
                }}}
            
        else if textField == textFieldMobileNumber {
            if textField.text == ""{
                
            }
            else {
        if (textFieldMobileNumber?.text?.characters.count)! < 12 {
        labelForErrorMessageContact = UILabel(frame: CGRect(x: CGFloat(textField.frame.origin.x), y: CGFloat(textField.frame.maxY), width: CGFloat(textField.frame.size.width), height: CGFloat(25)))
        labelForErrorMessageContact?.textColor = UIColor.red
        labelForErrorMessageContact?.font = UIFont.systemFont(ofSize: CGFloat(10))
        labelForErrorMessageContact?.isHidden = false
        textField.layer.borderColor = UIColor.red.cgColor
        labelForErrorMessageContact?.numberOfLines = 2
        labelForErrorMessageContact?.text = "Mobile Number should be correct"
        viewForDetail?.addSubview(labelForErrorMessageContact!)
                }
            }
        }
        else if textField == textFieldPinCode {
            if textField.text?.characters.count == 0 {
                
            }
       else {
        if (textField.text?.characters.count)! < 6 {
                    goNextView = false
        labelForErrorMessagePinCode = UILabel(frame: CGRect(x: CGFloat(textField.frame.origin.x), y: CGFloat(textField.frame.maxY), width: CGFloat(textField.frame.size.width), height: CGFloat(25)))
        labelForErrorMessagePinCode?.textColor = UIColor.red
        labelForErrorMessagePinCode?.font = UIFont.systemFont(ofSize: CGFloat(10))
        textField.layer.borderColor = UIColor.red.cgColor
        labelForErrorMessagePinCode?.text = "PinCode should be correct"
        viewForDetail?.addSubview(labelForErrorMessagePinCode!)
        }
        else {
        goNextView = true
        }
        }
        }
        else  if textField == textFieldFirstName || textField == textFieldFatherName || textField == textFieldLastName {
            if textField.text?.characters.count == 0 {
            }
            else {
            if (textField.text?.characters.count)! <= 1 {
            textField.text = ""
            textField.resignFirstResponder()
            //ALERT_DIALOG(kAppName, "Name should be more than one character")
                }
                else {
            textField.text = textField.text?.uppercased()
                }
            }
        }
        else if textField == textFieldCity {
           
        textField.resignFirstResponder()
       
        }
        else if textField == textFieldContactedPerson{
            tblView?.removeFromSuperview()
            tblView = nil
        }
        else if textField == textFieldCountry {
            
        textField.resignFirstResponder()
      
            }
        
        else {
            textField.text = textField.text?.uppercased()
        }
        
        textField.resignFirstResponder()
       
        return true
    }
   
  
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == textFieldLastName || textField == textFieldFatherName {
            let invalidCharSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.")
            
            let filtered: String = (string.components(separatedBy: invalidCharSet) as NSArray).componentsJoined(by: "")

                if !(string == filtered) || (string == " ") || (string == "") {
                    return true
                }
                else {
                    return false
                }
         
        }
        else if textField == textFieldFirstName {
            let invalidCharSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
            let filtered: String = (string.components(separatedBy: invalidCharSet) as NSArray).componentsJoined(by: "")
            if !(string == filtered) || (string == "") {
                return true
            }
            else {
                return false
            }
        }
        
        else if textField == textFieldContactedPerson {
            let invalidCharSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ")
            let filtered: String = (string.components(separatedBy: invalidCharSet) as NSArray).componentsJoined(by: "")
            if arrContactedPerson?.count != 0 {
                
                //   if (textField.text?.characters.count)! >= 0{
                var newString:NSString? =   (textField.text as NSString?)?.replacingCharacters(in:range , with: string) as NSString?
                newString = newString?.trimmingCharacters(in: .whitespaces) as NSString?
                let predicate:NSPredicate = NSPredicate(format: "self beginswith[cd] %@", newString!)
                searchResultsContact = arrContactedPerson?.filtered(using: predicate)   as NSArray?
                
                if (newString?.length)! > 0 {
                    
                    tblView?.reloadData()
                }
                else{
                    self.resetTableContactedPersonToInitial()
                }
            }
            if !(string == filtered) || (string == "") {
                return true
            }
            else {
                return false
            }
        }
        if textField == textFieldMobileNumber {
            let cs = CharacterSet(charactersIn: "0123456789")
            let filtered: String = (string.components(separatedBy: cs) as NSArray).componentsJoined(by: "")
          
        let length = Int(getLength(textField.text!))
            if length == 12 {
                
                    return false
                
            }
            if length == 3 {
              
          let stringContactNoFormat: String = formatNumber(textField.text!);             textField.text = "\(stringContactNoFormat) "
            if range.length > 0 {
            textField.text = "\(stringContactNoFormat as? String)?.substring(to: 3)"
                }
            }
            else if length == 7 {
                let stringContactNoFormat: String = formatNumber(textField.text!)
                textField.text = "\(stringContactNoFormat) "
                if range.length > 0 {
                    textField.text = "\(stringContactNoFormat as? NSString)?.substring(to: 3) \(stringContactNoFormat as? NSString)?.substring(from: 3)"
                }
            }
            if !(string == filtered) || (string == "") {
                
                return true
            }else{
                return false
            }
         
        }
        if textField == textFieldPinCode {
            let cs = CharacterSet(charactersIn: "0123456789")
            let filtered: String = (string.components(separatedBy: cs) as NSArray).componentsJoined(by: "")
            
            let length = Int(getLength(textField.text!))
            if length == 6 {
                    return false
            }else{
                if !(string == filtered) || (string == "") {
                    //  ALERT_DIALOG(kAppName, kNemberOnlyAlert)
                    return true
                }
                else{
                 return false
                }
            }
            
        }
        if textField == textFieldBuildingNumber || textField == textFieldStreat {
           
            let cs = CharacterSet(charactersIn:  "0123456789/-.,_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ")
            let filtered: String = (string.components(separatedBy: cs) as NSArray).componentsJoined(by: "")
            if !(string == filtered) || (string == "") {
              //  ALERT_DIALOG(kAppName, kWrongHouseNumberAlert)
                return true
            }
            else {
                return false
            }
        }
        else if  textField == textFieldCity{
            let invalidCharSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
            let filtered: String = (string.components(separatedBy: invalidCharSet) as NSArray).componentsJoined(by: "")
                        if allCity?.count != 0 {
                
                //   if (textField.text?.characters.count)! >= 0{
                var newString:NSString? =   (textField.text as NSString?)?.replacingCharacters(in:range , with: string) as NSString?
                newString = newString?.trimmingCharacters(in: .whitespaces) as NSString?
                let predicate:NSPredicate = NSPredicate(format: "self beginswith[cd] %@", newString!)
                searchResultsCity = arrayCity?.filtered(using: predicate)   as NSArray?
                
                if (newString?.length)! > 0 {
                    
                    tblView?.reloadData()
                }
                else{
                    self.resetTableCityToInitial()
                }
                if !(string == filtered) || (string == ""){
                // ALERT_DIALOG(kAppName, "please enter only alphabets")
                return true
                }
            
                return true
                //  }
            }
        }
        else if  textField == textFieldState{
            let invalidCharSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
            let filtered: String = (string.components(separatedBy: invalidCharSet) as NSArray).componentsJoined(by: "")
            if !(string == filtered) || (string == "") {
                    // ALERT_DIALOG(kAppName, "please enter only alphabets")
                    return true
            }else{
                return false
            }
                
           
            }
        

        else if textField == textFieldCountry {
            
            
                if allCountry?.count != 0 {
                    
                        //   if (textField.text?.characters.count)! >= 0{
            var newString:NSString? =   (textField.text as NSString?)?.replacingCharacters(in:range , with: string) as NSString?
            newString = newString?.trimmingCharacters(in: .whitespaces) as NSString?
            let predicate:NSPredicate = NSPredicate(format: "self beginswith[cd] %@", newString!)
            arrayCountry = allCountry?.filtered(using: predicate)   as NSArray?
                   
            if (newString?.length)! > 0 {
                            
            tblView?.reloadData()
            }
            else{
            self.resetTableToInitial()
            }
        return true
                        //  }
                    }
                }
       return true
    }

  // MARK: - tableView delegate
    func createTableView(_ tagValue: Int, and txtField: UITextField) {
        if tagValue == 1 {
            tblView = UITableView(frame: CGRect(x: CGFloat(txtField.frame.minX), y: CGFloat(txtField.frame.maxY), width: CGFloat(txtField.frame.size.width), height: CGFloat(130)), style: .plain)
        }
        else {
            tblView = UITableView(frame: CGRect(x: CGFloat(txtField.frame.minX), y: CGFloat(txtField.frame.maxY), width: CGFloat(txtField.frame.size.width), height: CGFloat(180)), style: .plain)
        }
        tblView?.delegate = self
        tblView?.dataSource = self
        tblView?.backgroundColor = UIColor.white
        tblView?.layer.borderWidth = 0.5
        scrollView?.addSubview(tblView!)
        tblView?.tag = tagValue
        tblView?.layer.borderColor = UIColor.black.cgColor
        tblView?.reloadData()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cellId: String = "currentOpenings"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.textColor = UIColor.black
        cell?.textLabel?.font = UIFont.systemFont(ofSize: CGFloat(15))
        cell?.textLabel?.numberOfLines = 0
        if tblView?.tag == 1 {
            cell?.textLabel?.text = arrIDProof?[indexPath.row] as! String?

        }
        else if tblView?.tag == 2 {
           // var sortedArray = [Any]()
            
               
            cell?.textLabel?.text = arrayCountry?[indexPath.row] as? String
           // cell.textLabel?.text = sortedArray[indexPath.row]
        }
                else if tblView?.tag == 3 {
            
                 cell?.textLabel?.text = searchResultsCity?[indexPath.row] as! String?
        }else if tblView?.tag == 4 {
            // var sortedArray = [Any]()
            
            
            cell?.textLabel?.text = searchResultsContact?[indexPath.row] as? String
            // cell.textLabel?.text = sortedArray[indexPath.row]
        }

        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if tblView?.tag == 2 {
            
                if arrayCountry?.count == nil {
                    return 0
                }
                return ((arrayCountry?.count))!
        }
        else if tblView?.tag == 1 {
            return (arrIDProof?.count)!
         }
        else if tblView?.tag == 3 {
            if searchResultsCity?.count == nil {
                return 0
            }
            return (searchResultsCity?.count)!
         }else if tblView?.tag == 4 {
            if searchResultsContact?.count == nil {
                return 0
            }
            return (searchResultsContact?.count)!
         }
        else {
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
       var selectedCell : UITableViewCell
        if tableView.tag == 2 {
            selectedCell = tableView.cellForRow(at: indexPath)!
            activeTextField?.text = selectedCell.textLabel?.text
           activeTextField?.resignFirstResponder()
            arrayCountry = allCountry
        }else if tableView.tag == 1{
            selectedCell = tableView.cellForRow(at: indexPath)!
            activeTextField?.text = selectedCell.textLabel?.text
            activeTextField?.resignFirstResponder()
        }
        else if tableView.tag == 3{
            selectedCell = tableView.cellForRow(at: indexPath)!
            activeTextField?.text = selectedCell.textLabel?.text
            activeTextField?.resignFirstResponder()
        }else if tableView.tag == 4{
            selectedCell = tableView.cellForRow(at: indexPath)!
            activeTextField?.text = selectedCell.textLabel?.text
            activeTextField?.resignFirstResponder()
        }

        tblView?.removeFromSuperview()
        tblView = nil
    }
    // MARK: - button Action
    @IBAction func printID(_ sender: Any) {
        
        if (printButton?.titleLabel?.text?.isEqual("Print"))! {
            UIGraphicsBeginImageContextWithOptions((viewForPrint?.bounds.size)!, true, 0)
            let context: CGContext? = UIGraphicsGetCurrentContext()
            viewForPrint?.layer.render(in: context!)
            let imageFromCurrentView: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            finalImage?.image = imageFromCurrentView
            //
            viewForDetail?.isHidden = true
            viewForPrint?.isHidden = true                                                                                   
            containerView?.isHidden = true
            
            
            finalImage?.isHidden = false
            printImageForPrinter()
        }
        else {

        activeTextField?.resignFirstResponder()
        goNextView = true
        for  tf in mendantoryTextFieldArray {
            let textField : UITextField = (tf as? UITextField)!
            if (textField.text == "") || textField.layer.borderColor == UIColor.red.cgColor {
                textField.layer.borderColor = UIColor.red.cgColor
                setTextFieldBorder(textField as! JVFloatLabeledTextField, color: UIColor.red.cgColor)
                goNextView = false
            }
        }
        if (textFieldContactedPerson?.text == "") {
            textFieldContactedPerson?.layer.borderColor = UIColor.red.cgColor
            setTextFieldBorder(textFieldContactedPerson!, color: UIColor.red.cgColor)
            goNextView = false
        }
        if candidateImageData?.length == nil {
            self.view.makeToast("please click your image first", duration: 3, position: .center)
            goNextView = false
        }
        if goNextView == false {
        
        }else{
            //  Converted with Swiftify v1.0.6355 - https://objectivec2swift.com/
//            let alert = UIAlertController(title: "Printer Authentication", message: "please enter printer extension", preferredStyle: UIAlertControllerStyle.alert)
//            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil)).
            
//            self.present(alert, animated: true, completion: nil)
//            
//            alert.addTextField { (textFieldIntervieweeID) in
//            
//                self.textFieldIntervieweeID?.placeholder = "Email"
//                self.textFieldIntervieweeID?.keyboardType = .numberPad
//                 self.textFieldIntervieweeID?.textAlignment = .center
//                 self.textFieldIntervieweeID?.delegate = self
//            }
//            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
//                UIAlertAction in
//                NSLog("OK Pressed")
//                self.textFieldIntervieweeID?.resignFirstResponder()
//                if  (self.textFieldIntervieweeID?.text?.characters.count)! < 1{
//                  self.view.makeToast("please enter printer extention", duration: 3, position: .center)
//                }else{
//            if  (self.textFieldIntervieweeID?.text?.isEqual("113"))! {
                self.viewForDetail?.isHidden = true
                self.viewForPrint?.isHidden = false
                self.visitorName?.text = (self.textFieldFirstName?.text)! + " " + (self.textFieldLastName?.text)!
                self.visitorContactTo?.text = self.textFieldContactedPerson?.text
            if self.textFieldIDProof?.text?.characters.count == 0{
                visitorID?.isHidden = true
                visitorIDText?.isHidden = true
            }else{
                self.visitorID?.text = self.textFieldIDProof?.text
                visitorID?.isHidden = false
                self.visitorIDText?.isHidden = false
            }
                if textFieldState?.text?.characters.count == 0 {
                let a = (self.textFieldBuildingNumber?.text)! + ", " + (self.textFieldStreat?.text)!
                let b = ", " + (self.textFieldCity?.text)! +  ", "
                let c = ", " + (self.textFieldCountry?.text)!  + "-" +  (self.textFieldPinCode?.text)!

                self.visitorAddress?.text = a + b + c
            }else{
                
                let a = (self.textFieldBuildingNumber?.text)! + ", " + (self.textFieldStreat?.text)!
                 let b = ", " + (self.textFieldCity?.text)! +  ", " + (self.textFieldState?.text)!
                let c = ", " + (self.textFieldCountry?.text)!  + "-" +  (self.textFieldPinCode?.text)!
                self.visitorAddress?.text = a + b + c
            }
                self.printCandidateImage?.image = UIImage(data: self.candidateImageData as! Data)
                        self.printButton?.setTitle("Print", for: .normal)
//                    }
//                    else {
//                self.view.makeToast("Please enter the correct extension", duration: 3, position: .center)
//                    }

//                }
//            }
//            alert.addAction(okAction)
            /* Display a numerical keypad for this text field */
           
           
           
            // [textFieldIntervieweeID becomeFirstResponder];
            
           //self.present(alert, animated: true, completion: nil)
        }
        
    }
    }
//For pick the image of visitor
  
    @IBAction func clickCandidateImage(_ sender: Any) {
            clickImageView()
    }
    
    @IBAction func allVisitorlist(_ sender: Any) {
        let objVisitorViewController = self.storyboard?.instantiateViewController(withIdentifier: "visitorView") as? VisitorDetailViewController
        //self.present(objVisitorViewController!, animated: true, completion: nil)
        navigationController?.pushViewController(objVisitorViewController!, animated: true)
        //      for temp in visitorArray
        //      {
        //          print(temp.name!)
        //    }
    }

  // MARK: - methods for pick image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        var compression: CGFloat = 0.9
        let maxCompression: CGFloat = 0.1
        let maxFileSize: Int = 140 * 140
        imageData = UIImagePNGRepresentation(info[UIImagePickerControllerEditedImage] as! UIImage) as NSData?
        print("image length.....\(UInt((imageData?.length)!))")
       while (imageData?.length)! > maxFileSize && compression > maxCompression {
        compression -= 0.1
        imageData = UIImageJPEGRepresentation(info[UIImagePickerControllerEditedImage] as! UIImage, compression) as NSData?
        }
        print("\(UInt((imageData?.length)!))")
        candidatePicture?.image = UIImage(data: imageData as! Data)
         strBase64 = imageData?.base64EncodedString(options: .lineLength64Characters)
        print("\(strBase64)")
        candidateImageData = Data(base64Encoded: strBase64!, options: .ignoreUnknownCharacters) as NSData?
        candidatePicture?.image = UIImage(data: candidateImageData as! Data)
        // use the image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
        
/*this is for ios 9
                
                let appDelegate =
                    UIApplication.shared.delegate as! AppDelegate
                
                let managedContext = appDelegate.managedObjectContext
                
                
                let entity =  NSEntityDescription.entity(forEntityName: "Visitors",
                                                         in:managedContext)
                
                let visitor = NSManagedObject(entity: entity!,
                                              insertInto: managedContext)
                
                
                visitor.setValue(1, forKey: "userName")
                visitor.setValue(self.visitorAddress?.text, forKey: "address")
                visitor.setValue(self.visitorContactTo?.text, forKey: "contactedTo")
                visitor.setValue(self.visitorID?.text, forKey: "idProof")
                visitor.setValue(self.strBase64, forKey: "imageData")
                visitor.setValue(self.visitorName?.text, forKey: "name")
                
                
                do {
                    try managedContext.save()
                    print("Could save ")
                    
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
                
  */
                
                let visitor = Visitors(context: contextmanaged)
                visitor.name = self.visitorName?.text
                visitor.address = self.visitorAddress?.text
                visitor.contactedTo = self.visitorContactTo?.text
                visitor.idProof = self.visitorID?.text
                visitor.imageData = self.strBase64
               
                  ad.saveContext()
        
                for tf  in self.textFieldArray! {
                    let textField : UITextField = (tf as? UITextField)!
                    if (textField.text?.characters.count)! > 0{
                       textField.text = ""
                    }
                }
         self.candidatePicture?.image = #imageLiteral(resourceName: "CandidateImage")
//                getStores()
            }
            else {
                print("there is an error in printer")
            }
            self.viewForDetail?.isHidden = false
            self.viewForPrint?.isHidden = false
            self.containerView?.isHidden = false
            self.finalImage?.isHidden = true
            self.printButton?.setTitle("Preview", for: .normal)
    })
    }
  // mark: - method for store data in core data
       func getStores() -> [Visitors]{
        
        let fetchRequest: NSFetchRequest<Visitors> = Visitors.fetchRequest()
        
        do {
            
            self.VisitorList = try contextmanaged.fetch(fetchRequest)
            print("visitor list \(VisitorList[0].name)")
            for temp in VisitorList
            {

             contextmanaged.delete(temp)
            }
            return self.VisitorList
            
        } catch {
            
            // handle the error
        }
       return []
    }

    override func didReceiveMemoryWarning() {
        
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

