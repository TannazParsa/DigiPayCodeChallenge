//
//  CryptoListFilterVC.swift
//  DigiPayCodeChallenge
//
//  Created by tanaz on 24/04/1400 AP.
//

import Foundation
import UIKit
import RxSwift
protocol FilterCryptoListDelegate: AnyObject {
    func didSelectFilter(tag: String, type: String)
}
class CryptoListFilterVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnApplyFilter: UIButton!
    @IBOutlet weak var btnCancle: UIButton!

    var filterItems = [["all","coins","tokens"], ["all", "defi", "filesharing"]]

    weak var delegate: FilterCryptoListDelegate?
    var selectedType: IndexPath?
    var selectedTag: IndexPath?
    var selectedTypeName: String?
    var selectedTagName: String?
    override func viewDidLoad() {
        tableView.register(UINib(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: "FilterTableViewCell")
        bindAction()
        if let cryptoCurrencyIndexOffset = filterItems[0].firstIndex(where: {$0 == selectedTypeName}) {
            selectedType = IndexPath(row: cryptoCurrencyIndexOffset, section: 0)
        }
        if let tagIndexOffset = filterItems[1].firstIndex(where: {$0 == selectedTagName}) {
            selectedTag = IndexPath(row: tagIndexOffset, section: 1)
        }
    }

    override func bindAction() {
        btnApplyFilter.rx.tap.throttle(.milliseconds(100), scheduler: MainScheduler.instance)
            .subscribe({ [weak self] _ in
                guard let strongSelf = self else {return}
                strongSelf.delegate?.didSelectFilter(tag: strongSelf.selectedTagName ?? "", type: strongSelf.selectedTypeName ?? "")
                strongSelf.dismiss(animated: true, completion: nil)
            }).disposed(by: bag)
        btnCancle.rx.tap.throttle(.milliseconds(100), scheduler: MainScheduler.instance)
            .subscribe({ [weak self] _ in
                guard let strongSelf = self else {return}
                strongSelf.dismiss(animated: true, completion: nil)
            }).disposed(by: bag)
    }
}
extension CryptoListFilterVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return filterItems.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterItems[section].count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Cryptocurrency type"
        case 1:
            return "Tags"
        default:
            return ""
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for: indexPath) as! FilterTableViewCell
        cell.lblItemName.text = filterItems[indexPath.section][indexPath.row]
        switch indexPath.section {
        case 0:
            cell.accessoryType = indexPath == selectedType ? .checkmark : .none
        case 1:
            cell.accessoryType = indexPath == selectedTag  ? .checkmark : .none
        default:
            break
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath == selectedType {
                selectedType = nil
                selectedTypeName = nil
            } else {
                selectedType = indexPath
                selectedTypeName = filterItems[0][indexPath.row]
            }
        case 1:
            if indexPath == selectedTag {
                selectedTag = nil
                selectedTagName = nil
            } else {
                selectedTag = indexPath
                selectedTagName = filterItems[1][indexPath.row]
            }
        default:
            break
        }
        tableView.reloadData()
    }
}
