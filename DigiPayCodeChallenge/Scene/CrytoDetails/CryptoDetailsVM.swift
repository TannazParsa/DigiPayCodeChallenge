//
//  CryptoDetailsVM.swift
//  DigiPayCodeChallenge
//
//  Created by tanaz on 25/04/1400 AP.
//

import Foundation
import UIKit
import RxSwift
class CryptoDetailsVM: BaseVM {

    enum State {
        case getCryptoSuccess(value: DataInfo)
        case getCryptoFailed(message: String)
    }

    weak var view: CryptoDetailsVC!
    var onChange = PublishSubject<State>()

    init(view: CryptoDetailsVC) {
        self.view = view
    }

    func getCryptoDetails(id: String) {
        CryptoServices.shared.getCryptoCurrencyDetails(id: id).subscribe(onNext: { [weak self] (result) in
            guard let strongSelf = self else {return}
            switch result {
            case .success (let value):
                if let res = value as? BaseResponse<DataInfo> {
                    strongSelf.onChange.onNext(.getCryptoSuccess(value: res.data!))
                }
            case .failure(let error):
                strongSelf.onChange.onNext(.getCryptoFailed(message: error))
            }
        }).disposed(by: self.view.bag)
    }

}
