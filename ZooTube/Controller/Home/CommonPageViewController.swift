//
//  CommonPageViewController.swift
//  ZooTube
//
//  Created by user on 2020/09/02.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import SDWebImage
import XLPagerTabStrip
import Alamofire
import SwiftyJSON

class CommonPageViewController: UITableViewController, IndicatorInfoProvider {

    var youtubeData = YoutubeData()
    var videoIdArray = [String]()
    var publishedAtArray = [String]()
    var titleArray = [String]()
    var imageURLStringArray = [String]()
    var youtubeURLArray = [String]()
    var channelTitleArray = [String]()

    let refresh = UIRefreshControl()

    //キーワードのインスタンス化 selfのプロパティを当てる　それがないと
    var keyword: String?

    init(keyword: String) {
        self.keyword = keyword
        // クラスの持つ指定イニシャライザを呼び出す
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        // UIViewControllerを継承したクラスでイニシャライザをカスタムする際に必要となるコード。（自動生成）
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }


    @objc func update(){

        getData()
        tableView.reloadData()
        refresh.endRefreshing()

    }

    //APIクラスはAPIを呼んで結果を返すためだけに使いたい
    // SearchKeyWordに入れた配列からPageに応じた用語を取得する
    func getData() {
        //APIKeyを隠す処理 使用するキー
        let apiKey = KeyManager().getValue(key: "apiKey2") as? String

        var searchKeyWord = self.keyword!

        var searchApiText = "https://www.googleapis.com/youtube/v3/search?key="+apiKey!+"&q="+searchKeyWord+"&part=snippet&maxResults=40&order=date"

        let url = searchApiText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        //リクエストを送る
        AF.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (responce) in
            //JSON解析

            //19個値が帰ってくるので、for文で全て配列に入れる

            print(responce)

            switch responce.result{

            case .success:

                for i in 0...19{
                    let json:JSON = JSON(responce.data as Any)
                    let videoId = json["items"][i]["id"]["videoId"].string
                    let publishedAt = json["items"][i]["snippet"]["publishedAt"].string
                    let title = json["items"][i]["snippet"]["title"].string
                    let imageURLString = json["items"][i]["snippet"]["thumbnails"]["default"]["url"].string
                    let youtubeURL = "https://www.youtube.com/watch?v=\(videoId!)"
                    let channelTitle = json["items"][i]["snippet"]["channelTitle"].string

                    self.videoIdArray.append(videoId!)
                    //self.publishedAtArray.append(publishedAt!)
                    self.titleArray.append(title!)
                    self.imageURLStringArray.append(imageURLString!)
                    self.channelTitleArray.append(channelTitle!)
                    self.youtubeURLArray.append(youtubeURL)

                }
                break

            case .failure(let error):
                print(error)
                break
            }
        }
    }

    //PageXViewControllerのtableViewの共通処理
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.selectionStyle = .none
        let profieleImageURL = URL(string: imageURLStringArray[indexPath.row] as String)!


        cell.imageView?.sd_setImage(with: profieleImageURL, completed: { (image, error, _, _) in
            if error == nil{

                cell.setNeedsLayout()
            }
        })

        cell.textLabel?.text = titleArray[indexPath.row]
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.numberOfLines = 5
        cell.detailTextLabel?.numberOfLines = 5

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection numberOfRowsInSectionsection: Int) -> Int {

        return titleArray.count
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return view.frame.size.height/5

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexNumber = indexPath.row
        let webviewController = WebViewController()
        let url = youtubeURLArray[indexNumber]
        UserDefaults.standard.set(url, forKey: "url")
        present(webviewController, animated: true, completion: nil)

    }

    //(XLPagerTabStrip)タブタイトルを返却するコードは共通化
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: self.keyword!)
    }
}

