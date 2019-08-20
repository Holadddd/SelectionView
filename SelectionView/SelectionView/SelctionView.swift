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
    
    func numberOfSelection(_ selectionView: SelectionView) -> Int
    
    func selectionText(selectionView: SelectionView, indexPath: IndexPath) -> String
    
    @objc optional func selectionIndicatorColor() -> UIColor

    @objc optional func selectionBtnTitleTextColor() -> UIColor

    @objc optional func selectionTextFont() -> UIFont
    
    @objc optional func selectionViewBackgroundColor() -> UIColor
}

@objc protocol SelectionViewDelegate: AnyObject {
    
    @objc optional func didSelectAt(_ selectionView: SelectionView, indexPath: IndexPath)
    
    @objc optional func selectionEnable(_ selectionView: SelectionView)
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
        guard let numberOfSelection = dataSource?.numberOfSelection(self) else { fatalError() }
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
            
            let indexPath = IndexPath(row: index, section: 0)
            guard let title = dataSource?.selectionText(selectionView: self, indexPath: indexPath) else { return }
            
            //titleTextColor 預設 白
            let titleTextColor = dataSource?.selectionBtnTitleTextColor?() ?? UIColor.white
            btn.tintColor = titleTextColor
            
            //titleTextFont 預設 UIFont.systemFont(ofSize: 18)
            let titleTextFont = dataSource?.selectionTextFont?() ?? UIFont.systemFont(ofSize: 18)
            btn.titleLabel?.font = titleTextFont
            btn.setTitle(title, for: .normal)
            
            //selectionViewBackgroundColor 預設 灰
            let backgroundColor = dataSource?.selectionViewBackgroundColor?() ?? UIColor.gray
            btn.backgroundColor = backgroundColor
            
            btn.addTarget(self, action: #selector(SelectionView.didTouchBtn), for: .touchUpInside)
            
            self.addSubview(btn)
            
            btns.append(btn)
        }
        
        indicator.frame = CGRect(origin: CGPoint(x: 0, y: height - 1), size: CGSize(width: width, height: 1))
        indicator.backgroundColor = .white
        self.addSubview(indicator)
        underLine.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width/CGFloat(number), height: 1))
        
        //IndicatorColor 預設為藍色
        let indicatorColor = dataSource?.selectionIndicatorColor?() ?? UIColor.red
        underLine.backgroundColor = indicatorColor
        
        
        
        indicator.addSubview(underLine)
    }
    
    
    
    @objc func didTouchBtn(_ sender: UIButton){
        moveIndicator(sender)

        didSelect(sender: sender)
    }
    
    func moveIndicator(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5) {
            let frame = CGPoint(x: sender.frame.minX, y: 0)
            self.underLine.frame.origin = frame
        }
    }
    
    func didSelect(sender: UIButton) {
        print(sender)
       
    }
    
}
