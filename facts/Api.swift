//
//  Api.swift
//  facts
//
//  Created by Do Xuan Thanh on 4/3/19.
//  Copyright © 2019 monstar-lab. All rights reserved.
//

import Foundation
import SwiftSoup

class Api {
    func call(_ url: URL?) -> (image: String, fact: String, detailLink: String?, nextLink: String)? {
        var uri = url
        if uri == nil {
            uri = getFirstUrl()
        }
        guard uri != nil else { return nil }
        do {
            let contents = try String(contentsOf: uri!)
            let doc: Document = try SwiftSoup.parse(contents)
            let text = try doc.select("p").first()!.text()
            let imgUrl = try doc.select(".main_img").first()!.attr("src")
            let detailLink = try doc.select(".more a").first()?.attr("href")
            let nextLink = try doc.select("#btn_next").first()!.attr("href")
            return (imgUrl, text, detailLink, nextLink)
        } catch {
            print("error parsing1")
        }
        return nil
    }
    
    private func getFirstUrl() -> URL? {
        let baseUrl = URL(string: Config.RootUrl)
        do {
            let page = try String(contentsOf: baseUrl!)
            let content: Document = try SwiftSoup.parse(page)
            let link = try content.select(".btn_start").first()?.attr("href")
            if let url = link {
                return URL(string: "\(Config.RootUrl)\(url)")
            }
        } catch {
            print("error parsing2")
        }
        return nil
    }
}
