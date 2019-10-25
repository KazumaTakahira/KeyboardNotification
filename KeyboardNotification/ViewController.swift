//
//  ViewController.swift
//  KeyboardNotification
//
//  Created by kazuma on 2019/10/25.
//  Copyright © 2019 kazuma takahira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // ボタン下部の制約をOutlet接続
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func tapButton(_ sender: Any) {
        // キーボードを閉じる
        textView.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // キーボード表示・非表示のObserver登録
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Observerを解除
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let rect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        bottomConstraint.constant = rect.height
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        bottomConstraint.constant = 0.0
    }
}
