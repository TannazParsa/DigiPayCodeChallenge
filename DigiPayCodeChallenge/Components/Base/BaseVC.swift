//
//  BaseVC.swift
//  DigiPayCodeChallenge
//
//  Created by tanaz on 24/04/1400 AP.
//

import UIKit
import RxCocoa
import RxSwift

class BaseVC: UIViewController {

    var bag = DisposeBag()


    open override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    open override func viewWillAppear(_ animated: Bool) {
     //   navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func showAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 17)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        let titleString = NSAttributedString(string: title, attributes: titleAttributes)
        let messageAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 14)!, NSAttributedString.Key.foregroundColor: UIColor.gray]
        let messageString = NSAttributedString(string: msg, attributes: messageAttributes)
        alert.setValue(titleString, forKey: "attributedTitle")
       // okAction.setValue(titleString, forKey: "attributedTitle")

        alert.setValue(messageString, forKey: "attributedMessage")
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
extension BaseVC: Bindable {

    func bindUI() {

    }

    func bindAction() {

    }

    func subscribe() {

    }
}
