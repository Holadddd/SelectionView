//
//  ViewController.swift
//  SelectionView
//
//  Created by wu1221 on 2019/8/19.
//  Copyright © 2019 wu1221. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var selectionViewOne: SelectionView!
    @IBOutlet weak var selectionOneColorView: UIView!
    
    @IBOutlet weak var selectionViewTwo: SelectionView!
    @IBOutlet weak var selectionTwoColorView: UIView!
    
    
    var selectionOne = ["Red", "Yellow"]
    var selectionTwo = ["Red", "Yellow", "Blue"]
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectionViewOne.delegate = self
        selectionViewOne.dataSource = self
        selectionViewTwo.delegate = self
        selectionViewTwo.dataSource = self
        selectionOneColorView.backgroundColor = .red
        selectionTwoColorView.backgroundColor = .red
    }


}


extension ViewController: SelectionViewDataSource {
    func numberOfSelection(_ selectionView: SelectionView) -> Int {
        switch selectionView {
        case selectionViewOne:
            return selectionOne.count
        case selectionViewTwo:
            return selectionTwo.count
        default:
            return 0
        }
        
    }
    
    func selectionText(selectionView: SelectionView, index: Int) -> String {
        switch selectionView {
        case selectionViewOne:
            let info = selectionOne[index]
            return info
        case selectionViewTwo:
            let info = selectionTwo[index]
            return info
        default:
            return ""
        }
    }
    
    func selectionIndicatorColor() -> UIColor {
        return .red
    }
    
    func selectionBtnTitleTextColor() -> UIColor {
        return .green
    }
    
    func selectionTextFont() -> UIFont? {
        
        return UIFont(name: "NotoSansChakma-Regular", size: 24)
    }
    
    func selectionViewBackgroundColor() -> UIColor {
        return UIColor.lightGray
    }
}

extension ViewController: SelectionViewDelegate {
    func didSelectAt(_ selectionView: SelectionView, index: Int) {
        switch selectionView {
        case selectionViewOne:
            switch index{
            case 0 :
                selectionOneColorView.backgroundColor = .red
            case 1 :
                selectionOneColorView.backgroundColor = .yellow
            default:
                return
            }
            
        case selectionViewTwo:
            switch index{
            case 0 :
                selectionTwoColorView.backgroundColor = .red
            case 1 :
                selectionTwoColorView.backgroundColor = .yellow
            case 2 :
                selectionTwoColorView.backgroundColor = .blue
            default:
                return
            }
            
        default:
            return
        }
    }
    
    func selectionEnable(_ selectionView: SelectionView, index: Int) -> Bool {
        let lastBtn = selectionOne.count - 1
        switch selectionView {
        case selectionViewOne:
            
            return true
        case selectionViewTwo:
        
            return !selectionViewOne.btns[lastBtn].isSelected
        default:
            return true
        }
    }
    
}
