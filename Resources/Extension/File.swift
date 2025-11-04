//
//  SignInVC.swift
//  BMV
//
//  Created by Silstone on 05/09/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import Foundation
import UIKit
import SwiftRangeSlider

// MARK:PROTOCOL CLASS
public protocol ContentDynamicLayoutDelegate: class {
    func cellSize(indexPath: IndexPath) -> CGSize
}

extension UIViewController {
   
    //MARK: ALERT POP UP
//    func PresentAlert(message: String, title: String) {
//        if let items =  self.tabBarController?.tabBar.items {
//            for i in 0 ..< items.count {
//                let itemToDisable = items[i]
//                itemToDisable.isEnabled = false
//            }
//        }
//        let alertVC = PMAlertController(title: title, description: message, image: UIImage(named: ""), style: .alert)
//        alertVC.alertView.backgroundColor = hexStringToUIColor(hex: "#BBDEFB")
//        alertVC.alertTitle.textColor = hexStringToUIColor(hex: "#374785")
//        alertVC.alertTitle.textAlignment = NSTextAlignment.left
//        alertVC.alertTitle.font = UIFont(name:"Krub-Bold", size: 20)
//        alertVC.alertDescription.textColor = UIColor.gray
//        alertVC.alertDescription.textAlignment = NSTextAlignment.left
//        alertVC.alertDescription.font = UIFont(name:"SegoeUI-Regular", size: 16)
//        alertVC.addAction(PMAlertAction(title: "OK", style: .cancel, action: { () in
//            if let items =  self.tabBarController?.tabBar.items {
//                for i in 0 ..< items.count {
//                    let itemToDisable = items[i]
//                    itemToDisable.isEnabled = true
//                }
//            }
//        }))
//        self.present(alertVC, animated: true, completion: nil)
//    }
    
    func disableTabbar () {
        if let items =  self.tabBarController?.tabBar.items {
            for i in 0 ..< items.count {
                let itemToDisable = items[i]
                itemToDisable.isEnabled = false
            }
        }
    }
    
    func enableTabbar () {
        if let items =  self.tabBarController?.tabBar.items {
            for i in 0 ..< items.count {
                let itemToDisable = items[i]
                itemToDisable.isEnabled = true
            }
        }
    }
    
    func PresentAlert(message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.setValue(NSAttributedString(string:title, attributes: [NSAttributedString.Key.font : UIFont(name:"Krub-Bold", size: 20) as Any, NSAttributedString.Key.foregroundColor :hexStringToUIColor(hex: "#374785")]), forKey: "attributedTitle")
//         alertController.setValue(NSAttributedString(string:message, attributes: [NSAttributedString.Key.font : UIFont(name:"SegoeUI-Regular", size: 16) as Any, NSAttributedString.Key.foregroundColor :hexStringToUIColor(hex: "#003644")]), forKey: "attributedMessage")
//        let myString  = "Alert Title"
//        var myMutableString = NSMutableAttributedString()
//        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 18.0)!])
//        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSRange(location:0,length:myString.characters.count))
//        alertController.setValue(myMutableString, forKey: "attributedTitle")
//        alertController.setValue(myMutableString, forKey: "attributedMessage")

        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
       // OKAction.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    //MARK:SETUP PROGRESS HUD
//    func setupProgressHud(view:UIView) {
//        let iprogress: iProgressHUD = iProgressHUD()
//        iprogress.isShowModal = true
//        iprogress.isShowCaption = true
//        iprogress.isTouchDismiss = false
//        iprogress.indicatorStyle = .circleStrokeSpin
//        iprogress.boxColor = .clear
//        iprogress.indicatorColor = hexStringToUIColor(hex: "#374785")
//        iprogress.indicatorSize = 30
//        iprogress.alphaModal = 0.3  // Background
//        // Attach iProgressHUD to views
//        iprogress.attachProgress(toViews: view)
//        
//        // Show iProgressHUD directly from view
//        
//        
//    }
  
}
func printAnyObject(object: Any)  {
    #if DEBUG
    print(object)
    #endif
}
//MARK: ROTATE AN IMAGE
extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        
        return self
    }
}
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    func forTrailingZero() -> String {
        let tempVar = String(format: "%g", Double() as CVarArg)
        return tempVar
    }
}
extension Double {
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1)  == 0 ? String(format: "%.0f", self) : String(self)
    }
}

//MARK: CHECK DIRECTION
func Get_Direction(Direction_in_Degree:Double) -> String {
    if Direction_in_Degree == 0{
        return "N"
    }else if Direction_in_Degree == 45{
        return "NE"
    }else if Direction_in_Degree == 90{
        return "E"
    }else if Direction_in_Degree == 135{
        return "SE"
    }else if Direction_in_Degree == 180{
        return "S"
    }else if Direction_in_Degree == 225{
        return "SW"
    }else if Direction_in_Degree == 270{
        return "W"
    }else if Direction_in_Degree == 315{
        return "NW"
    }else if  Direction_in_Degree > 0 &&  Direction_in_Degree < 45{
        return "NNE"
    }else if  Direction_in_Degree > 45 &&  Direction_in_Degree < 90{
        return "ENE"
    }else if  Direction_in_Degree > 90 &&  Direction_in_Degree < 135{
        return "ESE"
    }else if  Direction_in_Degree > 135 &&  Direction_in_Degree < 180{
        return "SSE"
    }else if  Direction_in_Degree > 180 &&  Direction_in_Degree < 225{
        return "SSW"
    }else if  Direction_in_Degree > 225 &&  Direction_in_Degree < 270{
        return "WSW"
    }else if  Direction_in_Degree > 270 && Direction_in_Degree < 315{
        return "WNW"
    }else{
        return "NNW"
    }
    
}

func transformToValue(Direction_in_Degree:Double) -> String {
    if Direction_in_Degree == 0{
        return "0"
    }else if Direction_in_Degree == 45{
        return "45"
    }else if Direction_in_Degree == 90{
        return "90"
    }else if Direction_in_Degree == 135{
        return "135"
    }else if Direction_in_Degree == 180{
        return "180"
    }else if Direction_in_Degree == 225{
        return "225"
    }else if Direction_in_Degree == 270{
        return "270"
    }else if Direction_in_Degree == 315{
        return "NW"
    }else if  Direction_in_Degree > 0 &&  Direction_in_Degree < 45{
        return "NNE"
    }else if  Direction_in_Degree > 45 &&  Direction_in_Degree < 90{
        return "ENE"
    }else if  Direction_in_Degree > 90 &&  Direction_in_Degree < 135{
        return "ESE"
    }else if  Direction_in_Degree > 135 &&  Direction_in_Degree < 180{
        return "SSE"
    }else if  Direction_in_Degree > 180 &&  Direction_in_Degree < 225{
        return "SSW"
    }else if  Direction_in_Degree > 225 &&  Direction_in_Degree < 270{
        return "WSW"
    }else if  Direction_in_Degree > 270 && Direction_in_Degree < 315{
        return "WNW"
    }else{
        return "NNW"
    }
    
}


//MARK: DATE ADDITION SUBTRACTION
extension Date {
    
    /// Returns a Date with the specified amount of components added to the one it is called with
    func add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date? {
        let components = DateComponents(year: years, month: months, day: days, hour: hours, minute: minutes, second: seconds)
        return Calendar.current.date(byAdding: components, to: self)
    }
    
    /// Returns a Date with the specified amount of components subtracted from the one it is called with
    func subtract(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date? {
        return add(years: -years, months: -months, days: -days, hours: -hours, minutes: -minutes, seconds: -seconds)
    }
    
}
//MARK: VALIDATE EMAIL
func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}
extension RangeSlider{
    
}
//MARK: TOGGLE IMAGE FOR UIBUTTON
extension UIButton{
    func ToggleImageForUIButton(selected:String,Unselected:String){
        if backgroundImage(for: .normal) == UIImage(named: Unselected){
            setBackgroundImage(UIImage(named:selected), for: .normal)
        }else{
            setBackgroundImage(UIImage(named: Unselected), for: .normal)
        }
    }
    func isAlertActiveFor(value:Bool){
        if value == true{
            setBackgroundImage(UIImage(named:"checkboxchecked"), for: .normal)
        }else{
            setBackgroundImage(UIImage(named:"checkboxempty"), for: .normal)
        }
    }
}
//MARK: TOGGLE IMAGE FOR UIIMAGE
extension UIImageView{
    func ToggleImageForUIImage(selected:String,Unselected:String){
        if image == (UIImage(named: Unselected)){
            image = UIImage(named: selected)
        }else{
            image = UIImage(named: Unselected)
        }
    }
}

extension UIImageView{
    //MARK: TOGGLE IMAGE FOR Bool Value
    func isAlertActiveImg(value:Bool){
        if value == true{
            image = UIImage(named: "alertactive")
        }else{
            image = UIImage(named: "alertnotactive")
        }
    }
    //Rotate image view
    func rotateImageViewAnimation(imageView:UIImageView,degree: CGFloat) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = degree
        rotateAnimation.duration = 0.0
        rotateAnimation.repeatCount = .greatestFiniteMagnitude
        
        imageView.layer.add(rotateAnimation,forKey: nil)
    }
}
func checkCharacterMinimumLength(textField: UITextField) -> Bool {
    if textField.text!.count < 3{
 
        return false
    }else{
       
        return true
    }
    
}

func checkMaxLength(textField: UITextField!, maxLength: Int) {
    if (textField.text!.count > maxLength) {
        textField.deleteBackward()
    }
}
func CheckIfStringContainSpace(string: String) -> Bool {
    return string.rangeOfCharacter(from: CharacterSet.whitespaces) == nil
}

//MARK:STRING TO DATE
   public func StringToDate( dateString: String)-> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        //according to date format your date string
        guard let date = dateFormatter.date(from: dateString) else {
            fatalError()
        }
        
        return date
        
    }

//MARK:CORNER READIUS AND BORDER WIDTH
extension UIView {
    func round(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
extension UIView {
    public func CornerRadius(_ cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
    

     func BorderWith(Width:CGFloat,color:UIColor) {
        layer.borderWidth = Width
        layer.borderColor = color.cgColor
    }
}
//MARK: NAVIGATION OF VIEWCONTROLLER
public func PushTo(FromVC:UIViewController,ToStoryboardID:String){
    let mstoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController: UIViewController = mstoryboard.instantiateViewController(withIdentifier: ToStoryboardID)
    FromVC.navigationController?.pushViewController(viewController, animated: true)
}
public func PresentTo(FromVC:UIViewController,ToStoryboardID:String){
    let mstoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController: UIViewController = mstoryboard.instantiateViewController(withIdentifier: ToStoryboardID)
    FromVC.present(viewController, animated: true, completion: nil)
}

  public  func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
class RoundedButtonWithShadow: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/2
        self.layer.shadowColor = hexStringToUIColor(hex: "#000000").cgColor//UIColor.black.cgColor
      //  self.layer.shadowPath = UIBezierPath(roundedRect:bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        self.layer.shadowOpacity = 0.37
        self.layer.shadowRadius = 4.0
    }
}
extension UIView {
    func roundSpecificCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        
    }
}

func dashedBorderLayerWithColor(color:CGColor,view: UIView) -> CAShapeLayer {
    
    let  borderLayer = CAShapeLayer()
    borderLayer.name  = "borderLayer"
    let frameSize = view.frame.size
    let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
    
    borderLayer.bounds=shapeRect
    borderLayer.position = CGPoint( x: frameSize.width/2,y: frameSize.height/2)
    borderLayer.fillColor = UIColor.clear.cgColor
    borderLayer.strokeColor = color
    borderLayer.lineWidth=1
    borderLayer.lineJoin=CAShapeLayerLineJoin.round
    borderLayer.lineDashPattern = NSArray(array: [NSNumber(value: 8),NSNumber(value:4)]) as? [NSNumber]
    
    let path = UIBezierPath.init(roundedRect: shapeRect, cornerRadius: 0)
    
    borderLayer.path = path.cgPath
    
    return borderLayer
    
}
extension UIView {
    func dropShadowSurfable(){
        layer.shadowColor = hexStringToUIColor(hex: "#000000").cgColor
        layer.shadowOpacity = 0.37
        layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        layer.shadowRadius = 4.0
        layer.masksToBounds = false
        
    }
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = hexStringToUIColor(hex: "#00000029").cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowRadius = 3
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.33, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

//MARK: DATE EXTENSION
extension Date {
    
    var timeAgoSinceNow: String {
        return getTimeAgoSinceNow()
    }
    
    private func getTimeAgoSinceNow() -> String {
        
        var interval = Calendar.current.dateComponents([.year], from: self, to: Date()).year!
        if interval > 0 {
            return interval == 1 ? "\(interval)" + " year" : "\(interval)" + " years"
        }
        
        interval = Calendar.current.dateComponents([.month], from: self, to: Date()).month!
        if interval > 0 {
            return interval == 1 ? "\(interval)" + " month" : "\(interval)" + " months"
        }
        
        interval = Calendar.current.dateComponents([.day], from: self, to: Date()).day!
        if interval > 0 {
            return interval == 1 ? "\(interval)" + " day" : "\(interval)" + " days"
        }
        
        interval = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour!
        if interval > 0 {
            return interval == 1 ? "\(interval)" + " hour" : "\(interval)" + " hours"
        }
        
        interval = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute!
        if interval > 0 {
            return interval == 1 ? "\(interval)" + " minute" : "\(interval)" + " minutes"
        }
        
        return "a moment ago"
    }
}


extension UIView {

    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidthV: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColorV: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
extension UIPageControl {
    
    func customPageControl() {
        for (pageIndex, dotView) in self.subviews.enumerated() {
            if self.currentPage == pageIndex {
                dotView.backgroundColor = UIColor(red: 247, green: 108, blue: 108, alpha: 1)
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
                dotView.layer.borderColor = UIColor(red: 55, green: 71, blue: 133, alpha: 1).cgColor
                dotView.layer.borderWidth = 1
            }else{
                dotView.backgroundColor = .clear
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
                dotView.layer.borderColor = UIColor(red: 55, green: 71, blue: 133, alpha: 1).cgColor
                dotView.layer.borderWidth = 1
            }
        }
    }
    
}
extension UIImage {
    
    /// Creates a circular outline image.
    class func outlinedEllipse(size: CGSize, color: UIColor, lineWidth: CGFloat = 1.0) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(lineWidth)
        // Inset the rect to account for the fact that strokes are
        // centred on the bounds of the shape.
        let rect = CGRect(origin: .zero, size: size).insetBy(dx: lineWidth * 0.5, dy: lineWidth * 0.5)
        context.addEllipse(in: rect)
        context.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
func GetDeviceType() -> String {
    var  DeviceType = ""
    if UIDevice().userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            print("iPhone 5/5S/5C/SE")
            DeviceType = "iPhone 5/5S/5C/SE"
        case 1334:
            print("iPhone 6/6S/7/8")
            DeviceType = "iPhone 6/6S/7/8"
        case 1920, 2208:
            print("iPhone 6+/6S+/7+/8+")
            DeviceType = "iPhone 6+/6S+/7+/8+"
        case 2436:
            print("iPhone X, XS")
            DeviceType = "iPhone X, XS"
        case 2688:
            print("iPhone XS Max")
            DeviceType = "iPhone XS Max"
        case 1792:
            print("iPhone XR")
            DeviceType = "iPhone XR"
        default:
            DeviceType = "Unknown"
        }
    }
    return  DeviceType
}
public extension UIDevice {
    
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad7,5", "iPad7,6":                      return "iPad 6"
            case "iPad11,4", "iPad11,5":                    return "iPad Air (3rd generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad Mini 5"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
}
