//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Shrijan Aryal on 9/23/18.
//  Copyright © 2018 Shrijan Aryal. All rights reserved.
//

import Parse
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func signUpBtn(_ sender: Any) {
        
        let user = PFUser()
        let username = self.usernameField.text
        let password = self.passwordField.text
        user.username = self.usernameField.text
        user.password = self.passwordField.text
        if (username?.isEmpty)!{
            let title =  "UsedId Missing"
            let message = "Please enter email address"
            provideAlert(title: title, message: message)
        }else{
            user.username = username
        }
        
        if (password?.isEmpty)!{
            let title = "Password Missing"
            let message =  "Please enter password"
            provideAlert(title: title, message: message)
        }else{
            user.password = password
        }
        user.signUpInBackground { (success:Bool, error:Error?) -> Void in
            if success{
                print("User has been created")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else{
                print (error?.localizedDescription)
            }
        }
    }
    
    @IBAction func logInBtn(_ sender: Any) {
        let username = self.usernameField.text ?? ""
        let password = self.passwordField.text ?? ""
        if (username == ""){
            let title =  "UsedId Missing"
            let message = "Please enter UsedId"
            provideAlert(title: title, message: message)
        }
        if (password == ""){
            let title =  "Password Missing"
            let message = "Please enter password"
            provideAlert(title: title, message: message)
        }
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user:PFUser?, error:Error?) in
            if user != nil{
                print ("user logged in")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                
            }
            if let error = error{
                print ("User login failed with error as: \(error.localizedDescription)")
            }
        }
    }
    func provideAlert(title:String, message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        alertController.addAction(OKAction)
        
        present(alertController, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

