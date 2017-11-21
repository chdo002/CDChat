//
//  DemoViewController.swift
//  CDChatList_Example
//
//  Created by chdo on 2017/11/18.
//  Copyright © 2017年 chdo002. All rights reserved.
//

import UIKit
import CDChatList

class DemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        let listView = CDChatList(frame: view.bounds)
        listView.viewController = self
        self.view.addSubview(listView)
        
        let path = Bundle.main.path(forResource: "msgList2", ofType: "json")
        let data = try! Data.init(contentsOf: URL(fileURLWithPath: path!))
        let arr = try! JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        var msgArr: Array<CDMessageModal> = Array()
        for item in arr as! Array<Dictionary<String, Any>> {
            msgArr.append(CDMessageModal.initWithDic(item))
        }
        listView.msgArr = msgArr
    }
}
