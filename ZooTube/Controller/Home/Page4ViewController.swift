//
//  Page1ViewController.swift
//  ZooTube
//
//  Created by user on 2020/03/14.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import SegementSlide
import Alamofire
import SwiftyJSON
import SDWebImage


class Page4ViewController: CommonPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.refreshControl = refresh
        refresh.addTarget(self, action: #selector(update), for: .valueChanged)
        getData()
        tableView.reloadData()
    }
    //コールバックの記述ができれば、この記述は不要
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

}

