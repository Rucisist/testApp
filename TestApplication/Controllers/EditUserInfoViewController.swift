//
//  EditUserInfoViewController.swift
//  TestApplication
//
//  Created by Андрей Илалов on 14.11.2017.
//  Copyright © 2017 Андрей Илалов. All rights reserved.
//

import UIKit

class EditUserInfoViewController: UIViewController {
    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var lastNameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var avatarURLLabel: UITextField!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    enum buttonType {
        case add, edit
    }

    var user = User()
    var buttonState = buttonType.add
    
    let request = RequestRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameLabel.text = user.firstName ?? ""
        emailLabel.text = user.email ?? ""
        avatarURLLabel.text = user.avatarUrl ?? ""
        lastNameLabel.text = user.lastName ?? ""

        hideKeyboard()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на два уведомления, одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name:
            NSNotification.Name.UIKeyboardWillShow, object: nil)
        // Второе когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)),name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide,
            object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editoOrAddButtonClick (_ sender: Any?) {
        let firstName = firstNameLabel.text ?? ""
        let lastName = lastNameLabel.text ?? ""
        let avatarURL = avatarURLLabel.text ?? ""
        let email = emailLabel.text ?? ""
        
        if checkData(emailAdress: email, firstName: firstName, lastName: lastName) {
            if buttonState == .edit {
                print("edit")
                request.editUserInfo(firstName: firstName, lastName: lastName, email: email, avatarUrl: avatarURL, id: user.id)
            }
            else if buttonState == .add {
                request.addUser(firstName: firstName, lastName: lastName, email: email, avatarUrl: avatarURL)
            }
            performSegue(withIdentifier: "unwindSegueToUserListTableViewController", sender: nil)
        }
        else {
            let alert = UIAlertController(title: "Alert", message: "Проверьте правильность ввода данных", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .cancel, handler: { (action) -> Void in })
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    @objc func keyboardWasShown (notification : Notification ) {
            // получаем размер клавиатуры
            let info = notification.userInfo! as NSDictionary
            let kbSize = (info.value(forKey: UIKeyboardFrameEndUserInfoKey ) as!NSValue ).cgRectValue.size
            let contentInsets = UIEdgeInsetsMake (0.0, 0.0, kbSize.height, 0.0)
            // добавляем отступ внизу UIScrollView равный размеру клавиатуры
            self.scrollView?.contentInset = contentInsets
            scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //когда клавиатура исчезает
    @objc func keyboardWillBeHidden (notification: Notification ) {
        // устанавливаем отступ внизу UIScrollView равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    func checkData(emailAdress: String, firstName: String, lastName: String) -> Bool {
        var separatedEmail = emailAdress.components(separatedBy: "@")
        
        if separatedEmail.count > 2 || separatedEmail.count == 1 {
            return false
        }
        
        let separatedDomain = separatedEmail[1].components(separatedBy: ".")
        
        if separatedDomain.count < 2 || separatedDomain[0].count == 0 {
            return false
        }
        
        if firstName == "" || lastName == "" {
            return false
        }
        
        print(separatedDomain[0].count)
        return true
    }
    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
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
