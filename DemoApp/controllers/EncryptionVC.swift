//
//  EncryptionVC.swift
//  DemoApp
//
//  Created by Monika on 22/09/20.
//

import UIKit

class EncryptionVC: UIViewController {

    @IBOutlet weak var txtSecretKey: UITextField!
    @IBOutlet weak var strTextView: UITextView!
    @IBOutlet weak var lblResult: UILabel!
    
    var encryptedData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func encrypt(_ sender: Any) {
        if let str = strTextView.text, let key = txtSecretKey.text {
            do {
                let aes = try AES(keyString: key)

                let encrypted: Data = try aes.encrypt(str)
                encryptedData = encrypted
                lblResult.text = encrypted.base64EncodedString()
            } catch {
                print("Something went wrong: \(error)")
            }
        }
    }
    
    @IBAction func decrypt(_ sender: Any) {
        if let key = txtSecretKey.text, let encryptedData = encryptedData {
            do {
                let aes = try AES(keyString: key)

                let decryptedData: String = try aes.decrypt(encryptedData)
                lblResult.text = decryptedData
            } catch {
                print("Something went wrong: \(error)")
            }
        }
    }
}
