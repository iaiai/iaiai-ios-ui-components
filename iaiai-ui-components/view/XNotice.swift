//
//  XNotice.swift
//  iaiai-ui-components
//
//  Created by iaiai on 2019/4/27.
//  Copyright © 2019 iaiai. All rights reserved.
//
// 消息组件(带图标)
//

import UIKit

//位置
enum XNoticePosition : Int {
    case top    //顶部
    case bottom //底部
}

//图标
private enum XNoticeIcon : String {
    case tip = "tip"    //提示
    case question = "question" //疑问
    case success = "success"    //成功
    case fail = "fail"   //失败
}

class XNotice: UIView {
    
    //位置，默认顶部
    var position:XNoticePosition = .top
    
    //显示图标
    private var icon:XNoticeIcon?
    
    //标题
    var titleLabel:UILabel?
    
    //内容
    var contentLabel:UILabel?
    
    //标题
    var title:String? = nil
    
    //内容
    var content:String? = nil
    
    //标题颜色(默认白色)
    var titleColor:UIColor = UIColor.white
    
    //内容颜色
    var contentColor:UIColor = UIColor.white
    
    //标题字体
    var titleFont:UIFont = UIFont.boldSystemFont(ofSize: 16)
    
    //内容字体
    var contentFont:UIFont = UIFont.boldSystemFont(ofSize: 12)
    
    //动画时间(秒)
    var animTime:Double = 1
    
    //显示时间
    var showTime:Double = 5
    
    //是否显示动画(默认显示)
    var showAnim:Bool = true
    
    //背景颜色(默认橘红)
    var bgColor:UIColor = UIColor(red: 241/255, green: 93/255, blue: 107/255, alpha: 1)
//    var bgColor:UIColor = UIColor(red: 245/255, green: 115/255, blue: 151/255, alpha: 1)
    
    //完成回调方法
    typealias _FINISH = () -> ()
    var finish:_FINISH? = nil
    
    //是否显示倒计时，默认不显示
    var showCountdown:Bool = false
    
    //静态方法，创建对象
    static func createNotice() -> XNotice {
        let notice = XNotice()
        return notice
    }
    
    //提示
    func showTip(controller:UIViewController,finish:_FINISH?) {
        self.icon = .tip
        
        showNotice(controller: controller, finish: finish)
    }
    
    //提示
    static func showTip(controller:UIViewController,title:String,finish:_FINISH?) {
        let notice = XNotice.createNotice()
        notice.icon = .tip
        notice.title = title
        
        notice.showNotice(controller: controller, finish: finish)
    }
    
    //提示
    static func showTip(controller:UIViewController,title:String,content:String,finish:_FINISH?) {
        let notice = XNotice.createNotice()
        notice.icon = .tip
        notice.title = title
        notice.content = content
        
        notice.showNotice(controller: controller, finish: finish)
    }
    
    //疑问
    func showQuestion(controller:UIViewController,finish:_FINISH?) {
        self.icon = .question
        
        showNotice(controller: controller, finish: finish)
    }
    
    //疑问
    static func showQuestion(controller:UIViewController,title:String,finish:_FINISH?) {
        let notice = XNotice.createNotice()
        notice.icon = .question
        notice.title = title
        
        notice.showNotice(controller: controller, finish: finish)
    }
    
    //疑问
    static func showQuestion(controller:UIViewController,title:String,content:String,finish:_FINISH?) {
        let notice = XNotice.createNotice()
        notice.icon = .question
        notice.title = title
        notice.content = content
        
        notice.showNotice(controller: controller, finish: finish)
    }
    
    //异常
    func showFail(controller:UIViewController,finish:_FINISH?) {
        self.icon = .fail
        
        showNotice(controller: controller, finish: finish)
    }
    
    //异常
    static func showFail(controller:UIViewController,title:String,finish:_FINISH?) {
        let notice = XNotice.createNotice()
        notice.icon = .fail
        notice.title = title
        
        notice.showNotice(controller: controller, finish: finish)
    }
    
    //异常
    static func showFail(controller:UIViewController,title:String,content:String,finish:_FINISH?) {
        let notice = XNotice.createNotice()
        notice.icon = .fail
        notice.title = title
        notice.content = content
        
        notice.showNotice(controller: controller, finish: finish)
    }
    
    //成功
    func showSuccess(controller:UIViewController,finish:_FINISH?) {
        self.icon = .success
        
        showNotice(controller: controller, finish: finish)
    }
    
    //成功
    static func showSuccess(controller:UIViewController,title:String,finish:_FINISH?) {
        let notice = XNotice.createNotice()
        notice.icon = .success
        notice.title = title
        
        notice.showNotice(controller: controller, finish: finish)
    }
    
    //成功
    static func showSuccess(controller:UIViewController,title:String,content:String,finish:_FINISH?) {
        let notice = XNotice.createNotice()
        notice.icon = .success
        notice.title = title
        notice.content = content
        
        notice.showNotice(controller: controller, finish: finish)
    }
    
    //显示判断位置
    private func showNotice(controller:UIViewController,finish:_FINISH?){
        switch position {
        case .top:
            showTop(controller: controller, finish: finish)
        case .bottom:
            showBottom(controller: controller, finish: finish)
        }
    }

    //显示
    private func showTop(controller:UIViewController,finish:_FINISH?) {
        self.finish = finish    //回调方法
        
        controller.view.addSubview(self)
        self.backgroundColor = bgColor  //设置颜色
        
        //记录最下面一个view
        var lastView:UIView = self
        
        //添加顶部显示的状态条
        let statusView = UIView()
        addSubview(statusView)
        statusView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(UIApplication.shared.statusBarFrame.height)
        }
        lastView = statusView
        
        //内容
        let contentView = UIView()
        contentView.backgroundColor = self.backgroundColor
        addSubview(contentView)
        
        //图标
        let img = UIImageView()
        img.image = UIImage(named: "icon_" + (icon?.rawValue)!)
        contentView.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(10)
            make.width.height.equalTo(24)
        }
        
        //标题
        if title != nil && (title?.count)! > 0{
            titleLabel = UILabel()
            titleLabel?.text = title
            titleLabel?.textColor = titleColor
            titleLabel?.font = titleFont
            titleLabel?.numberOfLines = 0
            titleLabel?.textAlignment = .left
            contentView.addSubview(titleLabel!)
            titleLabel?.snp.makeConstraints { (make) in
                make.top.equalTo(contentView).offset(10)
                make.left.equalTo(img.snp.right).offset(16)
                make.right.equalTo(contentView).offset(-16)
            }
            
            lastView = titleLabel!
        }
        
        if content != nil && (content?.count)! > 0{
            contentLabel = UILabel()
            contentLabel?.text = content
            contentLabel?.textColor = contentColor
            contentLabel?.font = contentFont
            contentLabel?.numberOfLines = 0
            contentLabel?.textAlignment = .left
            contentView.addSubview(contentLabel!)
            contentLabel?.snp.makeConstraints { (make) in
                make.left.equalTo(img.snp.right).offset(16)
                make.right.equalTo(contentView).offset(-16)
                make.top.equalTo(lastView.snp.bottom).offset(5)
            }
            
            lastView = contentLabel!
        }
        
        contentView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(statusView.snp.bottom)
            make.height.greaterThanOrEqualTo(44)    //最小高度
            make.bottom.equalTo(lastView).offset(10)
        }
        self.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(controller.view)
            make.bottom.equalTo(contentView)
        }
        
        //显示动画
        showAnimation()
        
        //隐藏删除
        hideAnimation()
    }
    
    //显示
    private func showBottom(controller:UIViewController,finish:_FINISH?) {
        self.finish = finish    //回调方法
        
        controller.view.addSubview(self)
        self.backgroundColor = bgColor  //设置颜色
        
        //记录最下面一个view
        var lastView:UIView = self
        
        //添加底部显示的状态条
        let homeView = UIView()
        addSubview(homeView)
        homeView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(PhoneUtil.bottomOffset())
        }
        lastView = homeView
        
        //内容
        let contentView = UIView()
        contentView.backgroundColor = self.backgroundColor
        addSubview(contentView)
        
        //图标
        let img = UIImageView()
        img.image = UIImage(named: "icon_" + (icon?.rawValue)!)
        contentView.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(10)
            make.width.height.equalTo(24)
        }
        
        //内容
        if content != nil && (content?.count)! > 0{
            contentLabel = UILabel()
            contentLabel?.text = content
            contentLabel?.textColor = contentColor
            contentLabel?.font = contentFont
            contentLabel?.numberOfLines = 0
            contentLabel?.textAlignment = .left
            contentView.addSubview(contentLabel!)
            contentLabel?.snp.makeConstraints { (make) in
                make.left.equalTo(img.snp.right).offset(16)
                make.right.equalTo(contentView).offset(-16)
                make.bottom.equalTo(contentView).offset(-5)
            }
            
            lastView = contentLabel!
        }
        
        //标题
        if title != nil && (title?.count)! > 0{
            titleLabel = UILabel()
            titleLabel?.text = title
            titleLabel?.textColor = titleColor
            titleLabel?.font = titleFont
            titleLabel?.numberOfLines = 0
            titleLabel?.textAlignment = .left
            contentView.addSubview(titleLabel!)
            titleLabel?.snp.makeConstraints { (make) in
                make.bottom.equalTo(lastView.snp.top).offset(-10)
                make.left.equalTo(img.snp.right).offset(16)
                make.right.equalTo(contentView).offset(-16)
            }

            lastView = titleLabel!
        }
        
        contentView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.bottom.equalTo(homeView.snp.top)
            make.height.greaterThanOrEqualTo(44)    //最小高度
            make.top.equalTo(lastView).offset(-10)
        }
        self.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(controller.view)
            make.top.equalTo(contentView)
        }
        
        //显示动画
        showAnimation()
        
        //隐藏删除
        hideAnimation()
    }
    
    //显示动画
    private func showAnimation(){
        if showAnim {
            self.transform = CGAffineTransform.identity.translatedBy(x: 0,
                                                                     y: self.position == XNoticePosition.top ? -50 : 50)
            self.alpha = 0
            UIView.animate(withDuration: animTime ,
                           delay: 0 ,
                           usingSpringWithDamping: 0.3 ,
                           initialSpringVelocity: 8 ,
                           options: [] ,
                           animations: {
                            self.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 0)
                            self.alpha = 1
            }, completion: nil)
        }
    }
    
    //隐藏动画，并且删除此界面
    private func hideAnimation(){
        var timeCount = showTime + animTime
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer.schedule(deadline: .now(), repeating: .seconds(1))
        timer.setEventHandler(handler: {
            timeCount = timeCount - 1
            if timeCount <= 0 {
                timer.cancel()
                
                DispatchQueue.main.async {
                    //判断是否有动画
                    if self.showAnim {
                        UIView.animate(withDuration: 0.5,
                                       delay: 0,
                                       usingSpringWithDamping: 1,   //消息时无回弹效果
                            initialSpringVelocity: 0,
                            options: [],
                            animations: {
                                self.transform = CGAffineTransform.identity.translatedBy(x: 0,
                                                                                         y: self.position == XNoticePosition.top ? -50 : 50)
                                self.alpha = 0
                        }, completion: { [weak self] (status) in
                            self?.removeFromSuperview()
                            
                            if(self?.finish != nil){
                                self?.finish!()
                            }
                        })
                    }else{
                        self.removeFromSuperview()
                        
                        if(self.finish != nil){
                            self.finish!()
                        }
                    }
                }
            }
            
            //刷新倒计时
            self.refCountdown(number: Int(timeCount))
        })
        timer.resume()  // 启动
    }
    
    //刷新倒计时
    private func refCountdown(number:Int){
        if !showCountdown{
            return
        }
        
        DispatchQueue.main.async {
            if(self.titleLabel != nil){
                self.titleLabel?.text = String(format: "%@ (%d)", self.title!, number)
            }else{
                if(self.contentLabel != nil){
                    self.contentLabel?.text = String(format: "%@ (%d)", self.content!, number)
                }
            }
        }
    }

}
