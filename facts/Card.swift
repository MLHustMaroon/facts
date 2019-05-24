//
//  Card.swift
//  facts
//
//  Created by Do Xuan Thanh on 5/16/19.
//  Copyright © 2019 monstar-lab. All rights reserved.
//

import Foundation
class Card {
    var fact:String
    var image:String
    var detailLink:String?
    var nexLink:String
    init?(link: URL?) {
        let api = Api()
        guard let data = api.call(link) else { return nil }
        self.fact = data.fact
        self.image = data.image
        self.detailLink = data.detailLink
        self.nexLink = data.nextLink
    }
}
