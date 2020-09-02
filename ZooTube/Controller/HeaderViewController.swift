//
//  ViewController.swift
//  ZooTube
//
//  Created by user on 2020/03/14.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import SegementSlide

class HeaderViewController: SegementSlideViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        reloadData()
        scrollToSlide(at: 0, animated: true)
    }

    override var headerView: UIView?{
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

