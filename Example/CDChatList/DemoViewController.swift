//
//  DemoViewController.swift
//  CDChatList_Example
//
//  Created by chdo on 2017/11/18.
//  Copyright © 2017年 chdo002. All rights reserved.
//

import UIKit
import CDChatList

class DemoViewController: UIViewController, ChatListProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        let listView = CDChatList(frame: view.bounds)
        listView.viewController = self
        listView.msgDelegate = self
        self.view.addSubview(listView)
        
        let path = Bundle.main.path(forResource: "msgList2", ofType: "json")
        let data = try! Data.init(contentsOf: URL(fileURLWithPath: path!))
        var arr = Array<Any>()
        do{
            arr = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! Array<Any>
        }catch let err {
            print(err.localizedDescription)
        }
        
        var msgArr: Array<CDMessageModal> = Array()
        for item in arr as! Array<Dictionary<String, Any>> {
            msgArr.append(CDMessageModal.initWithDic(item))
        }
        listView.msgArr = msgArr
    }
    
    func chatlistClickMsgEvent(_ listInfo: ChatListInfo!) {
        
//            let hud = MBProgressHUD.showAdded(to: view, animated: true)
//            hud.label.text = listInfo.clickedText
//            hud.mode = .text
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5 , execute: {
//                hud.hide(animated: true)
//            })
        
    }
    
    func chatlistLoadMoreMsg(_ topMessage: CDChatMessage!, callback finnished: (([CDChatMessage]?) -> Void)!) {
        
    }
}
