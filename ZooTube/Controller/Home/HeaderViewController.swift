//
//  ViewController.swift
//  ZooTube
//
//  Created by user on 2020/03/14.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import SegementSlide
//import XLPagerTabStrip

class HeaderViewController: SegementSlideViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        reloadData()
        scrollToSlide(at: 0, animated: true)
//XLPagerTabStripをそ使用する場合
//        // タブの背景色
//         settings.style.buttonBarBackgroundColor = UIColor.lightGray
//         // タブの色
//         settings.style.buttonBarItemBackgroundColor = UIColor.lightGray
//         // タブの文字サイズ
//         settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 15)
//         // カーソルの色
//         buttonBarView.selectedBar.backgroundColor = UIColor.darkGray
    }

    override var headerView: SegementSlideHeaderView{
        let headerView = UIImageView()
        headerView.isUserInteractionEnabled = true
        headerView.contentMode = .scaleToFill
        headerView.image = UIImage(named: "header")
        let headerHeigit:CGFloat
        if #available(iOS 11.0, *){
            headerHeigit = view.frame.height/4 + view.safeAreaInsets.top
        } else {
            headerHeigit = view.frame.height/4 + topLayoutGuide.length
        }
        headerView.heightAnchor.constraint(equalToConstant: headerHeigit).isActive = true
        return headerView
    }

//    //タブを管理するためのViewControllerの設定(XLPagerTabStripを利用)
//    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
//        //管理されるViewControllerを返す処理
//        let page1VC = UIStoryboard(name: "Header", bundle: nil).instantiateViewController(withIdentifier: "1")
//        let page2VC = UIStoryboard(name: "Header", bundle: nil).instantiateViewController(withIdentifier: "2")
//        let page3VC = UIStoryboard(name: "Header", bundle: nil).instantiateViewController(withIdentifier: "3")
//        let page4VC = UIStoryboard(name: "Header", bundle: nil).instantiateViewController(withIdentifier: "4")
//        let page5VC = UIStoryboard(name: "Header", bundle: nil).instantiateViewController(withIdentifier: "5")
//        let page6VC = UIStoryboard(name: "Header", bundle: nil).instantiateViewController(withIdentifier: "6")
//
//        let childViewControllers:[UIViewController] = [page1VC, page2VC, page3VC, page4VC, page5VC, page6VC]
//        return childViewControllers
//    }

    //segementSlide時の記述

    override var titlesInSwitcher: [String] {

        return["ねこ","いぬ","うさぎ","ハリネズミ","動物園","しろくま"]
    }

    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        switch index {
            case 0:
                return Page1ViewController()
            case 1:
                return Page2ViewController()
            case 2:
                return Page3ViewController()
            case 3:
                return Page4ViewController()
            case 4:
                return Page5ViewController()
            case 5:
                return Page6ViewController()


        default:
            return Page1ViewController()
        }
    }

}

