//
//  SignInVC.swift
//  BMV
//
//  Created by Silstone on 05/09/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import iProgressHUD

class SignInVC: UIViewController {

    var callApi = HttpClientApi()
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       iProgressHUD.sharedInstance().attachProgress(toView: self.view)
        // Do any additional setup after loading the view.
    }
    // MARK: - Navigation
    
    @IBAction func FbLoginBtn(_ sender: Any) {
     
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logOut()
        fbLoginManager.loginBehavior = LoginBehavior.browser
        
        fbLoginManager.logIn(permissions: ["email","public_profile"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : LoginManagerLoginResult = result!
                // if user cancel the login
                
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("public_profile"))
                {
                    self.getFBUserData()
                    print("facebook integration is fine")

//                    let VC = self.storyboard?.instantiateViewController(withIdentifier: "TutorialVC") as! TutorialVC
//                    self.navigationController?.pushViewController(VC, animated: true)
                }
            }
        }
    }
    
    func getFBUserData(){
        view.showProgress()
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id,name, first_name, last_name, picture.type(large),email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    if let result = result{
                       
                        let userdetail = result as! [String:Any]
                         print(userdetail)
                        let name = userdetail["name"] as! String
                        if userdetail["email"] != nil{
                            self.email = userdetail["email"] as! String
                        }else{
                            self.email = ""
                        }
                        let ID = userdetail["id"] as! String
                        let pic = userdetail["picture"] as! [String:Any]
                        let data = pic["data"] as! [String:Any]
                        let url = data["url"] as! String
                        UserDefaults.standard.set(url, forKey: "ImgUrl")
                        UserDefaults.standard.synchronize()
                        
                        let deviceToken = UserDefaults.standard.value(forKey: kDeviceToken) as? String ?? ""
                         let param = "email=\(self.email)&password=\(ID)&facebookid=\(ID)&device_token=\(deviceToken)"
                        
                         self.facebook_registration(param:param)
//                        let parameterDictionary = ["email":self.email,"name":name,"Facebookid":ID,"loginType":1,"password":"","InstagramId":""] as [String : Any]
                        
                        
//                        self.callApi.callPostApi(apiFor: "Register", parameters: parameterDictionary) { (response) in
//                            if  response.result.value != nil{
//                                let value = response.result.value as! [String:Any]
//                                print(value)
//                                let mess = value["Message"] as! String
//                                let status = value["status"] as! String
//                                if status == "fail"{
//                                   // self.view.dismissProgress()
//                                    self.PresentAlert(message: mess, title: "Surfer")
//
//                                }else{
//                                    //self.view.dismissProgress()
//                                    let value = response.result.value as! [String:Any]
//                                    let Detail = value["RegistrationDetail"] as! [String:Any]
//                                    let userID = Detail["UserId"]
//                                    let email = Detail["Email"] as! String
//                                    let name = Detail["Name"] as! String
//                                    UserDefaults.standard.setValue(name, forKey: "name")
//                                    UserDefaults.standard.setValue(email, forKey: "email")
//                                    UserDefaults.standard.setValue(userID,forKey: "userID")
//                                    UserDefaults.standard.synchronize()
//                                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//                                    let loginView = storyboard.instantiateViewController(withIdentifier: "TabBarController")
//                                    UIApplication.shared.keyWindow?.rootViewController = loginView
//                                }
//                            }else{
//                                 //self.view.dismissProgress()
//                                self.PresentAlert(message: "Could't connect to server", title: "Surfer")
//                            }
 //                       }
//                    }
//                }else{
//                    if let error = error{
//                        self.PresentAlert(message: error.localizedDescription, title: "Surfer")
//                      //  self.view.dismissProgress()
                    }
                }
            })
        }
    }
    
    @IBAction func signupAction(_ sender: UIButton)
    {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(VC, animated: false)
    }
    
    @IBAction func SignInGoBtn(_ sender: Any) {
            
            guard let password = passwordTxtField.text  else {
                return
            }
            
            guard let emailTxt = emailTxtField.text?.lowercased()  else {
                return
            }
             if  (password == "") || (emailTxt == ""){
              //  self.PresentAlert(message: "Please fill all fields.", title: "BMV")
                self.showAlrt(messageStr: "Please fill all fields.")
            }else{
                
                if isValidEmail(testStr: emailTxt) == true{
                                   // view.showProgress()
                    view.showProgress()
                    let deviceToken = UserDefaults.standard.value(forKey: kDeviceToken) as? String ?? ""
                                    let param = "email=\(emailTxt)&password=\(password)&device_token=\(deviceToken)&facebookid=\("")"
                                   
                                    callApi.callPostApi(apiFor: "user_login", parameters: param) { (response) in
                                        print(response.result.value ?? "")
                                        if  response.result.isSuccess{
                                            let value = response.result.value as! [String:Any]
                                            print(value)
                                            let mess =  "\(String(describing: value["message"] ?? value["Message"]!))"
                                           // let status = value["status"] as! String
                                            self.view.dismissProgress()
                                           // self.PresentAlert(message:mess,title:"BMV")
                                            if mess == "success"{
                                               
                                                let value = response.result.value as! [String:Any]
                                               let data = value["data"] as! [String:Any]
                                                UserDefaults.standard.set(data["userid"], forKey:kUserId)
                                                UserDefaults.standard.synchronize()
                                                
                                              //  self.PresentAlert(message:"Password Sent on Email.",title:"BMV")
                                                //self.showAlrt(messageStr: "Login Successfully")
//                                                let VC = self.storyboard?.instantiateViewController(withIdentifier: "PreferencesVC") as! PreferencesVC
//                                                self.navigationController?.pushViewController(VC, animated: true)
                                                //vinay here-
                                                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "StoreNav") as! UINavigationController
                                                UIApplication.shared.keyWindow?.rootViewController = viewController
                                                
                                            }else if mess == "An error has occurred."{
                                              // self.view.dismissProgress()
                                                self.passwordTxtField.text = ""
                                                self.emailTxtField.text = ""
                                                self.showAlrt(messageStr: "User does not Exists.")
                
                                            }else
                                            {
                                                self.passwordTxtField.text = ""
                                                                                               self.emailTxtField.text = ""
                                                                                               self.showAlrt(messageStr: mess)
                                                               
                                            }
                                        }else{
                //                           // self.PresentAlert(message: "Could't connect to server", title: "BMV")
                                            self.showAlrt(messageStr: "Could't connect to server.")
                                            self.view.dismissProgress()
                                       }
                                    }
                                }else{
                   // self.PresentAlert(message: "Please fill Valid Email Address.", title: "BMV")
                    self.showAlrt(messageStr: "Email is not valid.")
                }
            }
        }
    
    @IBAction func forgotPasswordBtn(_ sender: Any) {
        let alertController = UIAlertController(title: "Forgot Password?", message: "Please Enter Your Email.", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField) -> Void in
                    textField.placeholder = "Enter Your Email"
                    textField.keyboardType = UIKeyboardType.emailAddress
                }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (result : UIAlertAction) -> Void in
                    print("Cancel")
                }
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            print(alertController.textFields?.first?.text! ?? "")
            self.forgot_passwordApi(emailTxt: alertController.textFields?.first?.text! as! NSString)
                }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func forgot_passwordApi(emailTxt:NSString) {
        
        if isValidEmail(testStr: emailTxt as String) == true{
                            view.showProgress()
                            let param = "email=\(emailTxt)"
                           
                            callApi.callGetApi(apiFor: "forgot_password", parameters: param) { (response) in
                                print(response.result.value ?? "")
                                if  response.data != nil{
                                    let value = response.result.value as! [String:Any]
                                    print(value)
                                    let mess = value["message"] as! String
                                   // let status = value["status"] as! String
                                    
                                   // self.PresentAlert(message:mess,title:"BMV")
                                    self.view.dismissProgress()
                                    if mess == "success"{
                                        let Detail = value["data"] as! String
                                       
                                        //let value = response.result.value as! [String:Any]
                                      //  let Detail = value["data"] as! String
                                      //  self.PresentAlert(message:"Password Sent on Email.",title:"BMV")
                                        self.showAlrt(messageStr: Detail)
                                        
                                    }else{
                                      // self.view.dismissProgress()
                                         self.showAlrt(messageStr: mess)
        
                                    }
                                }else{
        //                           // self.PresentAlert(message: "Could't connect to server", title: "BMV")
        //                            //self.view.dismissProgress()
                               }
                            }
                        }else{
                       // self.PresentAlert(message: "Please fill Valid Email Address.", title: "BMV")
                       self.showAlrt(messageStr:"Please Enter Valid Email Address.")
                    }

    }
    
    func facebook_registration(param:String)  {
       // view.showProgress()
        callApi.callGetApi(apiFor: "user_registration", parameters: param) { (response) in
                                print(response.result.value ?? "")
                                if  response.result.isSuccess{
                                    let value = response.result.value as! [String:Any]
                                    print(value)
                                    let mess =  "\(value["message"] ?? "")"
                                   // let status = value["status"] as! String
                                     self.view.dismissProgress()
                                   // self.PresentAlert(message:mess,title:"BMV")
                                    if mess == "success"{
                                       
                                        let value = response.result.value as! [String:Any]
                                        let data = value["data"] as! [String:Any]
                                        UserDefaults.standard.set(data["Id"], forKey:kUserId)
                                        UserDefaults.standard.synchronize()
                                      //  self.PresentAlert(message:"Password Sent on Email.",title:"BMV")
                                        let VC = self.storyboard?.instantiateViewController(withIdentifier: "TutorialVC") as! TutorialVC
                                                               self.navigationController?.pushViewController(VC, animated: true)
                                        //self.showAlrt(messageStr: "Registered Successfully")
                                        
                                    }else if mess == "This Email is already Exist"{
                                       
                                        let value = response.result.value as! [String:Any]
                                        //let Detail = value["data"] as! String
                                      //  self.PresentAlert(message:"Password Sent on Email.",title:"BMV")
                                        let VC = self.storyboard?.instantiateViewController(withIdentifier: "PreferencesVC") as! PreferencesVC
                                               self.navigationController?.pushViewController(VC, animated: true)
                                        //self.showAlrt(messageStr: "Registered Successfully")
                                        
                                    }else{
                                      // self.view.dismissProgress()
                                         self.showAlrt(messageStr: mess)

                                    }
                                }else{
        //                           // self.PresentAlert(message: "Could't connect to server", title: "BMV")
                                    self.showAlrt(messageStr: "Could't connect to server")
                                    self.view.dismissProgress()
        //                        }
                                }
                                
                            }
    }
    
    func showAlrt(messageStr:String)
    {
        let alertController = UIAlertController(title: "BMV", message: messageStr, preferredStyle: UIAlertController.Style.alert)

        let OkAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
                           print("OK")
                       }

               alertController.addAction(OkAction)
               self.present(alertController, animated: true, completion: nil)
    }
        
    }
    
