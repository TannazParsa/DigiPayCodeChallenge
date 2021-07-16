//
//  CryptoCurrencyListVC.swift
//  DigiPayCodeChallenge
//
//  Created by tanaz on 24/04/1400 AP.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CryptoCurrencyListVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var btnSort: UIButton!

    var viewModel: CryptoCurrencyListVM!
    override func viewDidLoad() {
        viewModel = CryptoCurrencyListVM(view: self)
        subscribe()
        bindAction()
        tableView.isHidden = true
        viewModel.getCryptoList(start: 1, limit: 20)
        tableView.register(UINib(nibName: "CryptoCurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: "CryptoCurrencyTableViewCell")

    }

    func showSortActionSheet() {
        // Create An UIAlertController with Action Sheet
        let sortMenuController = UIAlertController(title: nil, message: "Sort by:", preferredStyle: .actionSheet)
        // Create UIAlertAction for UIAlertController

        viewModel.sortItems.forEach { item in
            let action = UIAlertAction(title: item, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.viewModel.sort = item
                self.showSortTypeActionSheet()
            })
            sortMenuController.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancel")
        })

        let clearAction = UIAlertAction(title: "Clear all Sort", style: .destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            print("clear")
            self.viewModel.sort = nil
            self.viewModel.sortDir = nil
            self.viewModel.getCryptoList(start: 1, limit: 20)
        })
        sortMenuController.addAction(cancelAction)
        sortMenuController.addAction(clearAction)
        // Present UIAlertController with Action Sheet
        present(sortMenuController, animated: true, completion: nil)
    }

    func showSortTypeActionSheet() {
        // Create An UIAlertController with Action Sheet
        let sortTypeController = UIAlertController(title: nil, message: "Choose sort type", preferredStyle: .actionSheet)
        viewModel.sortTypes.forEach { item in
            let action = UIAlertAction(title: item, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.viewModel.sortDir = item
                self.viewModel.getCryptoList(start: 1, limit: 20)
                //  self.showSortTypeActionSheet()
            })
            sortTypeController.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancel")
        })
        sortTypeController.addAction(cancelAction)
        present(sortTypeController, animated: true, completion: nil)

    }

    //Bindable
    override func subscribe() {
        self.viewModel.onChange.subscribe(onNext: { [weak self] state in
            guard let strongSelf = self else {return}
            switch state {
            case .getListSuccess(let value):
                strongSelf.tableView.isHidden = false
                strongSelf.tableView.reloadData()
            case .getListFailed(let message):
                strongSelf.showAlert(title: "Error", msg: message)
            }
        }).disposed(by: bag)
    }

    override func bindAction() {
        btnSort.rx.tap.throttle(.milliseconds(100), scheduler: MainScheduler.instance)
            .subscribe({ [weak self] _ in
                guard let strongSelf = self else {return}
                strongSelf.showSortActionSheet()
            }).disposed(by: bag)

        btnFilter.rx.tap.throttle(.milliseconds(100), scheduler: MainScheduler.instance)
            .subscribe({ [weak self] _ in
                guard let strongSelf = self else {return}
                let filterVC = Storyboards.main.instantiateViewController(withIdentifier: "CryptoListFilterVC") as! CryptoListFilterVC
                filterVC.delegate = self
                filterVC.selectedTagName = strongSelf.viewModel.tag
                filterVC.selectedTypeName = strongSelf.viewModel.cryptocurrencyType
                strongSelf.present(filterVC, animated: true, completion: nil)
            }).disposed(by: bag)
    }
}
extension CryptoCurrencyListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cryptoDataList.value?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCurrencyTableViewCell", for: indexPath) as! CryptoCurrencyTableViewCell
        if let item = viewModel.cryptoDataList.value?[indexPath.row] {
            cell.config(crypto: item)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cryptoItems = viewModel.cryptoDataList.value {
            if indexPath.row == cryptoItems.count - 5 {
                viewModel.getCryptoList(start: cryptoItems.count, limit: cryptoItems.count + 20)
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let id = viewModel.cryptoDataList.value?[indexPath.row].id {
            let detailsVC = Storyboards.main.instantiateViewController(withIdentifier: "CryptoDetailsVC") as! CryptoDetailsVC
            detailsVC.cryptoID = String(id)
            present(detailsVC, animated: true, completion: nil)
        }
    }
}
extension CryptoCurrencyListVC: FilterCryptoListDelegate {
    func didSelectFilter(tag: String, type: String) {
        if !tag.isEmpty {
            viewModel.tag = tag
        } else {
            viewModel.tag = nil
        }
        if !type.isEmpty {
            viewModel.cryptocurrencyType = type
        } else {
            viewModel.cryptocurrencyType = nil
        }
        tableView.isHidden = true
        viewModel.getCryptoList(start: 1, limit: 20)
    }
}
