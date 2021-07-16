//
//  CryptoCurrencyTableViewCell.swift
//  DigiPayCodeChallenge
//
//  Created by tanaz on 24/04/1400 AP.
//

import UIKit

class CryptoCurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCurrencyName: UILabel!
    @IBOutlet weak var lblSymbol: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblPercentChange: UILabel!
    @IBOutlet weak var lblMarketCap: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(crypto: CryptoCurrencyListResponse) {
        lblCurrencyName.text = crypto.name
        lblPrice.text = crypto.quote?.uSD?.price?.toString()
        lblSymbol.text = crypto.symbol
        lblPercentChange.text = crypto.quote?.uSD?.percent_change_24h?.toString()
        lblMarketCap.text = crypto.quote?.uSD?.market_cap?.toString()
    }
}
