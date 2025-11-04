//
//  SignupVC.swift
//  BMV
//
//  Created by Silstone on 05/09/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import iProgressHUD

class SignupVC: UIViewController {

    var callApi = HttpClientApi()
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var paswrdTxtFld: UITextField!
    @IBOutlet weak var retypepaswrdTxtFld: UITextField!
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        paswrdTxtFld.text = "123456"
//        retypepaswrdTxtFld.text = "123456"
//        emailTxtFld.text = "amit@silstonegroup.com"
        iProgressHUD.sharedInstance().attachProgress(toView: self.view)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func signinBtnAction(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: false)
    }
    @IBAction func signUpGoBtnAction(_ sender: Any) {
        
        guard let password = paswrdTxtFld.text  else {
            return
        }
        guard let ConfirmPassword = retypepaswrdTxtFld.text  else {
            return
        }
        guard let emailTxt = emailTxtFld.text?.lowercased()  else {
            return
        }
         if  (password == "") || (ConfirmPassword == "") || (emailTxt == ""){
            //self.PresentAlert(message: "Please fill all fields.", title: "BMV")
             self.showAlrt(messageStr: "Please fill all fields.")
        }else{
            
            if isValidEmail(testStr: emailTxt) == true{
                if password == ConfirmPassword{
                    let deviceToken = UserDefaults.standard.value(forKey: kDeviceToken) as? String ?? ""
                    let param = "email=\(emailTxt)&password=\(password)&facebookid=\("")&device_token=\(deviceToken)"
                   
                    self.user_registration(param:param)                
            }else{
                //self.PresentAlert(message: "Please fill Valid Email Address.", title: "BMV")
                self.showAlrt(messageStr: "Password and confirm password did not mached.")
            }
            }else{
                
                self.showAlrt(messageStr: "Email is not valid.")
            }
        }
        
    }
    
    func user_registration(param:String)  {
        view.showProgress()
        callApi.callGetApi(apiFor: "user_registration", parameters: param) { (response) in
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
                                        UserDefaults.standard.set(data["Id"], forKey:kUserId)
                                        UserDefaults.standard.synchronize()
                                        //let Detail = value["data"] as! String
                                      //  self.PresentAlert(message:"Password Sent on Email.",title:"BMV")
                                        let VC = self.storyboard?.instantiateViewController(withIdentifier: "TutorialVC") as! TutorialVC
                                                               self.navigationController?.pushViewController(VC, animated: true)
                                        //self.showAlrt(messageStr: "Registered Successfully")
                                         self.showAlrt(messageStr: "Registered Successfully")
                                        
                                    }else{
                                      // self.view.dismissProgress()
                                        self.paswrdTxtFld.text = ""
                                        self.retypepaswrdTxtFld.text = ""
                                        self.emailTxtFld.text = ""
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
    
    func facebook_registration(param:String)  {
        //view.showProgress()
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
                                        //let Detail = value["data"] as! String
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
    @IBAction func fbLoginBtnAction(_ sender: Any) {
     
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
//                                           self.navigationController?.pushViewController(VC, animated: true)
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
//                        }
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
}
