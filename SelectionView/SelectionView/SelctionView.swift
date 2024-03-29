//
//  SelctionView.swift
//  SelectionView
//
//  Created by wu1221 on 2019/8/19.
//  Copyright © 2019 wu1221. All rights reserved.
//

import Foundation
import UIKit

@objc protocol SelectionViewDataSource: AnyObject {
    
    @objc func numberOfSelection(_ selectionView: SelectionView) -> Int
    
    func selectionText(selectionView: SelectionView, index: Int) -> String
    
    @objc optional func selectionIndicatorColor() -> UIColor

    @objc optional func selectionBtnTitleTextColor() -> UIColor

    @objc optional func selectionTextFont() -> UIFont?
    
    @objc optional func selectionViewBackgroundColor() -> UIColor
}

@objc protocol SelectionViewDelegate: AnyObject {
    
    @objc optional func didSelectAt(_ selectionView: SelectionView, index: Int)
    
    @objc optional func selectionEnable(_ selectionView: SelectionView, index: Int) -> Bool
}

class SelectionView: UIView {
    
    let indicator = UIView()
    
    var underLine = UIView()
    
    var btns: [UIButton] = []
    
    weak var delegate: SelectionViewDelegate? {
        didSet {
//            reloadDelegate()
        }
    }
    
    weak var dataSource: SelectionViewDataSource? {
        didSet {
            reloadDataSource()
            print("touch")
        }
    }
    
    func reloadDataSource() {
        let numberOfSelection = dataSource?.numberOfSelection(self) ?? 2
        setBtn(number: numberOfSelection)
        
    }
    
    func setBtn(number: Int) {
        
        
        let width = self.bounds.width
        let height = self.bounds.height
        
        for index in 0..<number {
            let btn = UIButton()
            let indexFloat = CGFloat(index)
            let numberFloat = CGFloat(number)
            
            btn.frame = CGRect(x: ((width/numberFloat)*indexFloat), y: 0, width: (width/numberFloat), height: height-1)
            
            
            guard let title = dataSource?.selectionText(selectionView: self, index: index) else { return }
            
            //titleTextColor 預設 白
            let titleTextColor = dataSource?.selectionBtnTitleTextColor?() ?? UIColor.white
            btn.tintColor = titleTextColor
            
            //titleTextFont 預設 UIFont.systemFont(ofSize: 18)
            let titleTextFont = dataSource?.selectionTextFont?() ?? UIFont.systemFont(ofSize: 18)
            btn.titleLabel?.font = titleTextFont
            btn.setTitle(title, for: .normal)
            
            //selectionViewBackgroundColor 預設 灰
            let backgroundColor = dataSource?.selectionViewBackgroundColor?() ?? UIColor.black
            btn.backgroundColor = backgroundColor
            
            btn.addTarget(self, action: #selector(SelectionView.didTouchBtn), for: .touchUpInside)
            btn.tag = index
            self.addSubview(btn)
            
            btns.append(btn)
        }
        
        indicator.frame = CGRect(origin: CGPoint(x: 0, y: height - 1), size: CGSize(width: width, height: 1))
        indicator.backgroundColor = .white
        self.addSubview(indicator)
        underLine.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width/CGFloat(number), height: 1))
        
        //IndicatorColor 預設為藍色
        let indicatorColor = dataSource?.selectionIndicatorColor?() ?? UIColor.blue
        underLine.backgroundColor = indicatorColor

        indicator.addSubview(underLine)
    }
    
    
    
    @objc func didTouchBtn(_ sender: UIButton){
        for btn in btns{
            btn.isSelected = false
            btn.isEnabled = true
        }
        print(btns.count)
        sender.isSelected = true
        btnEnable(sender: sender)
    }
    
    func moveIndicator(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3) {
            let frame = CGPoint(x: sender.frame.minX, y: 0)
            self.underLine.frame.origin = frame
        }
    }
    
    func didSelect(sender: UIButton) {
        
        let index = sender.tag
        delegate?.didSelectAt?(self, index: index)
    }
    
    func btnEnable(sender: UIButton) {
        print("enable")
        let tag = sender.tag
        sender.isEnabled = delegate?.selectionEnable?(self, index: tag) ?? true
        print(delegate?.selectionEnable?(self, index: tag) as Any)
        if sender.isEnabled {
            moveIndicator(sender)
            didSelect(sender: sender)
        }
    }
}
