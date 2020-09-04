////
////  API.swift
////  ZooTube
////
////  Created by user on 2020/09/01.
////  Copyright © 2020 user. All rights reserved.
////
//
//import Foundation
//import SegementSlide
//import Alamofire
//import SwiftyJSON
//import SDWebImage
//
//public class API {
//
//    var youtubeData = YoutubeData()
//
//    var videoIdArray = [String]()
//    var publishedAtArray = [String]()
//    var titleArray = [String]()
//    var imageURLStringArray = [String]()
//    var youtubeURLArray = [String]()
//    var channelTitleArray = [String]()
//
//    var tabNo = 0
//    //仮置き
//    var serchKeyWord = SearchKeyWord()
//
//
//
//    //APIクラスはAPIを呼んで結果を返すためだけに使いたい
//    // SearchKeyWordに入れた配列からPageに応じた用語を取得する
//    func getData() {
//        //APIKeyを隠す処理 使用するキー
//        let apiKey = KeyManager().getValue(key: "apiKey1") as? String
//
//
//        //タブから渡される番号で検索するKeyWordを取得する
//        var searchKeyWord = SearchKeyWord.getKeyword(tabNo: Int)
//
//        var searchApiText = "https://www.googleapis.com/youtube/v3/search?key="+apiKey+"&q="+searchKeyWord+"&part=snippet&maxResults=40&order=date"
//
//        let url = searchApiText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        //リクエストを送る
//        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (responce) in
//            //JSON解析
//
//            //19個値が帰ってくるので、for文で全て配列に入れる
//
//            print(responce)
//
//            switch responce.result{
//
//            case .success:
//
//                for i in 0...19{
//                    let json:JSON = JSON(responce.data as Any)
//                    let videoId = json["items"][i]["id"]["videoId"].string
//                    let publishedAt = json["items"][i]["snippet"]["publishedAt"].string
//                    let title = json["items"][i]["snippet"]["title"].string
//                    let imageURLString = json["items"][i]["snippet"]["thumbnails"]["default"]["url"].string
//                    let youtubeURL = "https://www.youtube.com/watch?v=\(videoId!)"
//                    let channelTitle = json["items"][i]["snippet"]["channelTitle"].string
//
//                    self.videoIdArray.append(videoId!)
//                    //self.publishedAtArray.append(publishedAt!)
//                    self.titleArray.append(title!)
//                    self.imageURLStringArray.append(imageURLString!)
//                    self.channelTitleArray.append(channelTitle!)
//                    self.youtubeURLArray.append(youtubeURL)
//
//                }
//                break
//
//            case .failure(let error):
//                print(error)
//                break
//            }
//        }
//    }
//}
