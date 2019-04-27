//
//  ViewController.swift
//  组件
//
//  Created by iaiai on 2019/3/10.
//  Copyright © 2019 iaiai. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "组件列表"
        
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(self.view)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellid = "testCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellid)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellid)
        }
        
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = "Message - 顶部显示"
        case 1:
            cell?.textLabel?.text = "Message - 底部显示"
        case 2:
            cell?.textLabel?.text = "Message - 显示倒计时/修改背景色"
        case 3:
            cell?.textLabel?.text = "Notice - 顶部显示"
        case 4:
            cell?.textLabel?.text = "Notice - 底部显示"
        default:
            break
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            XMessage.showTop(controller: self.navigationController!, title: "出错啦~",finish:nil)
        case 1:
            XMessage.showBottom(controller: self.navigationController!, title: "出错啦~",finish:nil)
        case 2:
            let msg = XMessage.createMessage()
            msg.showCountdown = true
            msg.title = "有问题啦!"
            msg.content = "异常内容显示异常内容显示异常内容显示异常内容显示异常内容显示异常内容显示异常内容显示异常内容显示异常内容显示异常内容显示异常内容显示"
            msg.bgColor = UIColor.red
            msg.showTop(controller: self.navigationController!,finish:nil)
        case 3:
//            XNotice.showTip(controller: self.navigationController!,title:"姓名不允许为空",finish: nil)
            XNotice.showSuccess(controller: self.navigationController!,
                                title:"姓名不允许为空",
                                content:"异常内容显示异常内容显示异常内容显示异常内容显示异常内容显示异常内容显示异常内容显示异常内容显示异常内容显示异常内容显示异常内容显示",
                                finish: nil)
        case 4:
            let notice = XNotice()
            notice.position = .bottom
            notice.title = "姓名不允许为空"
            notice.content = "异常内容显示异常内容显示异常内容显示异常内容显示异常内容显示异常内容显示异常内容显示异常内容显示异常内容显示异常内容显示异常内容显示"
            notice.showQuestion(controller: self.navigationController!,finish:nil)
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

