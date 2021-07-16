//
//  CryptoCurrencyListVM.swift
//  DigiPayCodeChallenge
//
//  Created by tanaz on 24/04/1400 AP.
//

import Foundation
import RxCocoa
import RxSwift
class CryptoCurrencyListVM: BaseVM {

    enum State {
        case getListSuccess(value: [CryptoCurrencyListResponse])
        case getListFailed(message: String)
    }

    weak var view: CryptoCurrencyListVC!
    var onChange = PublishSubject<State>()
    var cryptoDataList = BehaviorRelay<[CryptoCurrencyListResponse]?>(value: nil)
    var sortItems = ["market_cap", "name", "price"]
    var sortTypes = ["asc", "desc"]
    var sort: String? = nil
    var sortDir: String? = nil
    var cryptocurrencyType: String? = nil
    var tag: String? = nil
    init(view: CryptoCurrencyListVC) {
        self.view = view
    }

    func getCryptoList(start: Int, limit: Int) {
        CryptoServices.shared.getLatestCryptoList(start: start, limit: limit, sort: sort, sortDir: sortDir,tag: tag, cryptoType: cryptocurrencyType).subscribe(onNext: { [weak self] (result) in
            guard let strongSelf = self else {return}
            switch result {
            case .success (let value):
                if let res = value as? BaseResponse<[CryptoCurrencyListResponse]> {
                    strongSelf.cryptoDataList.accept(res.data ?? [])
                    strongSelf.onChange.onNext(.getListSuccess(value: res.data ?? []))
                }
            case .failure(let error):
                strongSelf.onChange.onNext(.getListFailed(message: error))
            }
        }).disposed(by: self.view.bag)
    }
}
