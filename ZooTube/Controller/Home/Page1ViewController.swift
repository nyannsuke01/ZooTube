//
//  Page1ViewController.swift
//  ZooTube
//
//  Created by user on 2020/03/14.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import XLPagerTabStrip

class Page1ViewController: CommonPageViewController, IndicatorInfoProvider {

    let searchKeyWord = SearchKeyWord()

    //ここがボタンのタイトルに利用されます
     var itemInfo: IndicatorInfo = "ねこ"

    override func viewDidLoad() {
        super.viewDidLoad()


        let keyWord = searchKeyWord.keyWordArray[0]

        tableView.refreshControl = refresh
        refresh.addTarget(self, action: #selector(update), for: .valueChanged)
        getData()
        tableView.reloadData()
    }
    //コールバックの記述ができれば、この記述は不要
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    //必須(XLPagerTabStrip)
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }

}
