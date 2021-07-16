//
//  Bindable.swift
//  DigiPayCodeChallenge
//
//  Created by tanaz on 24/04/1400 AP.
//

import Foundation

@objc
protocol Bindable {
    @objc
    optional func bindUI()
    
    @objc
    optional func bindAction()
    
    @objc
    optional func subscribe()
}
