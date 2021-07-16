//
//  CryptoDetailsVC.swift
//  DigiPayCodeChallenge
//
//  Created by tanaz on 25/04/1400 AP.
//

import Foundation
import UIKit

class CryptoDetailsVC: BaseVC {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSymbol: UILabel!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!

    private var viewModel: CryptoDetailsVM!
    var cryptoID: String?
    override func viewDidLoad() {
        viewModel = CryptoDetailsVM(view: self)
        subscribe()
        if let id = cryptoID {
            viewModel.getCryptoDetails(id: id)
        }
    }

    func fillData(value: DataInfo) {
        if let id = cryptoID {
            lblName.text = value.details?[id]?.name
            lblSymbol.text = value.details?[id]?.symbol
            lblCategoryName.text = value.details?[id]?.category
            lblDesc.text = value.details?[id]?.description
        }
    }

    //Bindable

    override func subscribe() {
        self.viewModel.onChange.subscribe(onNext: { [weak self] state in
            guard let strongSelf = self else {return}
            switch state {
            case .getCryptoSuccess(let value):
                strongSelf.fillData(value: value)
            case .getCryptoFailed(let message):
                strongSelf.showAlert(title: "Error", msg: message)
            }
        }).disposed(by: bag)
    }
}
