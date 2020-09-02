//
//  CommonPageViewController.swift
//  ZooTube
//
//  Created by user on 2020/09/02.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import SegementSlide
import Alamofire
import SwiftyJSON
import SDWebImage


class CommonPageViewController: UITableViewController, SegementSlideContentScrollViewDelegate {

    var youtubeData = YoutubeData()
    var videoIdArray = [String]()
    var publishedAtArray = [String]()
    var titleArray = [String]()
    var imageURLStringArray = [String]()
    var youtubeURLArray = [String]()
    var channelTitleArray = [String]()

    let refresh = UIRefreshControl()

    //　APIクラスの初期化
    var api = API()

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
    @objc func update(){

        getData()
        tableView.reloadData()
        refresh.endRefreshing()

    }
    @objc var scrollView: UIScrollView {

        return tableView
    }
    //コールバックメソッドでAPIを呼びたい
    func getData() {
        api.getData()
        //帰ってきた後TableVIewを更新
        self.tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.selectionStyle = .none
        let profieleImageURL = URL(string: api.imageURLStringArray[indexPath.row] as String)!


        cell.imageView?.sd_setImage(with: profieleImageURL, completed: { (image, error, _, _) in
            if error == nil{

                cell.setNeedsLayout()
            }
        })

        cell.textLabel?.text = api.titleArray[indexPath.row]
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.numberOfLines = 5
        cell.detailTextLabel?.numberOfLines = 5

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection numberOfRowsInSectionsection: Int) -> Int {

        return api.titleArray.count
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return view.frame.size.height/5

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexNumber = indexPath.row
        let webviewController = WebViewController()
        let url = api.youtubeURLArray[indexNumber]
        UserDefaults.standard.set(url, forKey: "url")
        present(webviewController, animated: true, completion: nil)

    }

}
