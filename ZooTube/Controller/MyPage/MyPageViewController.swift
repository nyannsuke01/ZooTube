//
//  MyPageViewController.swift
//  ZooTube
//
//  Created by user on 2020/09/01.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {


    @IBOutlet weak var likeAnimalPicker: UIPickerView!
    @IBOutlet weak var likeAnimalLabel: UILabel!

    //
    let dataList = [
        "ねこ","いぬ","うさぎ","ハムスター",
        "しろくま","きつね","ペンギン","イルカ",
        "あざらし","りす","フェネックギツネ",
        "パンダ","ラッコ"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()


        // Delegate設定
        likeAnimalPicker.delegate = self
        likeAnimalPicker.dataSource = self
        // Do any additional setup after loading the view.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectLikeAnimal = dataList[row]
        likeAnimalLabel.text = "好きな動物  " + selectLikeAnimal
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
