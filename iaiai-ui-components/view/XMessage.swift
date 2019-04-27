//
//  XMessage.swift
//  iaiai-ui-components
//
//  Created by iaiai on 2019/4/25.
//  Copyright © 2019 iaiai. All rights reserved.
//
//  消息组件(不带图标)
//

import UIKit
import SnapKit

//位置
private enum XMessagePosition : Int {
    case top    //顶部
    case bottom //底部
}

class XMessage: UIView {
    
    //位置，默认顶部
    private var position:XMessagePosition = .top
    
    //动画时间(秒)
    var animTime:Double = 1
    
    //显示时间
    var showTime:Double = 5
    
    //是否显示动画(默认显示)
    var showAnim:Bool = true
    
    //背景颜色(默认橘红)
    var bgColor:UIColor = UIColor(red: 241/255, green: 93/255, blue: 107/255, alpha: 1)
//    var bgColor:UIColor = UIColor(red: 245/255, green: 115/255, blue: 151/255, alpha: 1)
    
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
    
    //文字位置(默认居中)
    var alignment:NSTextAlignment = .center
    
    //完成回调方法
    typealias _FINISH = () -> ()
    var finish:_FINISH?
    
    //是否显示倒计时，默认不显示
    var showCountdown:Bool = false
    
    //获取当前最所在的uiviewcontroller，一层一层向上找(这个必须界面addSubview之后才可以用)
    private func currentViewController()->UIViewController?{
        for view in sequence(first: self.superview, next: {$0?.superview}){
            if let responder = view?.next{
                if responder.isKind(of: UIViewController.self){
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    
    //静态方法，创建对象
    static func createMessage() -> XMessage {
        let msg = XMessage()
        return msg
    }
    
    //静态方法，创建对象
    static func showTop(controller:UIViewController,title:String,finish:_FINISH?){
        let msg = XMessage()
        msg.title = title
        msg.showTop(controller: controller, finish: finish)
    }
    
    //静态方法，创建对象
    static func showTop(controller:UIViewController,title:String,content:String,finish:_FINISH?){
        let msg = XMessage()
        msg.title = title
        msg.content = content
        msg.showTop(controller: controller, finish: finish)
    }
    
    //静态方法，创建对象
    static func showBottom(controller:UIViewController,title:String,finish:_FINISH?){
        let msg = XMessage()
        msg.title = title
        msg.showBottom(controller: controller, finish: finish)
    }
    
    //静态方法，创建对象
    static func showBottom(controller:UIViewController,title:String,content:String,finish:_FINISH?){
        let msg = XMessage()
        msg.title = title
        msg.content = content
        msg.showBottom(controller: controller, finish: finish)
    }
    
    //顶部显示
    func showTop(controller:UIViewController,finish:_FINISH?) {
        self.finish = finish    //回调方法
        self.position = .top    //顶部
        
        //记录最下面一个view
        var lastView:UIView = self
        
        controller.view.addSubview(self)
        self.backgroundColor = bgColor  //设置颜色
        
        //添加顶部显示的状态条
        let statusView = UIView()
        addSubview(statusView)
        statusView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(UIApplication.shared.statusBarFrame.height)
        }
        lastView = statusView
        
        let contentView = UIView()
        contentView.backgroundColor = self.backgroundColor
        addSubview(contentView)
        
        //标题
        if title != nil && (title?.count)! > 0{
            titleLabel = UILabel()
            titleLabel?.text = title
            titleLabel?.textColor = titleColor
            titleLabel?.font = titleFont
            titleLabel?.numberOfLines = 0
            titleLabel?.textAlignment = alignment
            contentView.addSubview(titleLabel!)
            titleLabel?.snp.makeConstraints { (make) in
                make.top.equalTo(contentView).offset(10)
                make.left.equalTo(contentView).offset(16)
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
            contentLabel?.textAlignment = alignment
            contentView.addSubview(contentLabel!)
            contentLabel?.snp.makeConstraints { (make) in
                make.left.equalTo(contentView).offset(16)
                make.right.equalTo(contentView).offset(-16)
                make.top.equalTo(lastView.snp.bottom).offset(5)
            }
            
            lastView = contentLabel!
        }
        
        contentView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(statusView.snp.bottom)
            make.height.greaterThanOrEqualTo(44)    //高度最小44
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
    
    //显示底部
    func showBottom(controller:UIViewController,finish:_FINISH?) {
        self.finish = finish    //回调方法
        self.position = .bottom //底部
        
        //记录最下面一个view
        var lastView:UIView = self
        
        controller.view.addSubview(self)
        self.backgroundColor = bgColor  //设置颜色
        
        //添加底部显示的状态条
        let homeView = UIView()
        addSubview(homeView)
        homeView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(PhoneUtil.bottomOffset())
        }
        lastView = homeView
        
        let contentView = UIView()
        contentView.backgroundColor = self.backgroundColor
        addSubview(contentView)
        
        //内容
        if content != nil && (content?.count)! > 0{
            contentLabel = UILabel()
            contentLabel?.text = content
            contentLabel?.textColor = contentColor
            contentLabel?.font = contentFont
            contentLabel?.numberOfLines = 0
            contentLabel?.textAlignment = alignment
            contentView.addSubview(contentLabel!)
            contentLabel?.snp.makeConstraints { (make) in
                make.left.equalTo(contentView).offset(16)
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
            titleLabel?.textAlignment = alignment
            contentView.addSubview(titleLabel!)
            titleLabel?.snp.makeConstraints { (make) in
                make.left.equalTo(contentView).offset(16)
                make.right.equalTo(contentView).offset(-16)
                make.bottom.equalTo(lastView.snp.top).offset(-5)
            }
            
            lastView = titleLabel!
        }
        
        contentView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.bottom.equalTo(homeView.snp.top)
            make.height.greaterThanOrEqualTo(44)    //最小高度44
            make.top.equalTo(lastView)
        }
        self.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(controller.view)
            make.top.equalTo(lastView).offset(-10)
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
                                                                     y: self.position == XMessagePosition.top ? -50 : 50)
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
                                                                                                 y: self.position == XMessagePosition.top ? -50 : 50)
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
