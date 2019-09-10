//
//  ViewController.swift
//  Ios_Labra3_teht2
//
//  Created by Saku Huuha on 10/09/2019.
//  Copyright © 2019 Saku Huuha. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        return
    }
    

    @IBOutlet var URLTextField: UITextField!
    @IBOutlet var PhoneNumberField: UITextField!
    @IBOutlet var EmailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SendEmailButtonClick(_ sender: Any) {
 
    }
    @IBAction func OpenBrowserClick(_ sender: Any) {
        guard let url = URL(string: URLTextField.text!) else { return  }
        
        UIApplication.shared.open(url)
    }
    @IBAction func CameraButtonClick(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = (self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate)
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
    }
    }
    
    @IBAction func CreateCallButtonClick(_ sender: Any) {
        makePhoneCall(phoneNumber: PhoneNumberField.text!)
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = (self as! MFMailComposeViewControllerDelegate)
            mail.setToRecipients([EmailTextField.text!])
            mail.setMessageBody("<p>You've been e-mailed!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func makePhoneCall(phoneNumber: String) {
        
        if let phoneURL = NSURL(string: ("tel://" + phoneNumber)) {
            
            let alert = UIAlertController(title: ("Call " + phoneNumber + "?"), message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Call", style: .default, handler: { (action) in
                UIApplication.shared.open(phoneURL as URL, options: [:], completionHandler: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

}

