//
//  ViewController.swift
//  SelectionView
//
//  Created by wu1221 on 2019/8/19.
//  Copyright © 2019 wu1221. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SelectionViewDataSource, SelectionViewDelegate {
    
    //datasource
    func selectionIndicatorColor() -> UIColor {
        return .green
    }
    
    func selectionTextFont() -> UIFont {
        return UIFont.init(name: "NotoSansChakma-Regular", size: 10)!
    }
    
    func selectionText(selectionView: SelectionView, indexPath: IndexPath) -> String {
        let info = titleArr[indexPath.row]
        return info
    }
    
    func numberOfSelection(_ selectionView: SelectionView) -> Int {
        return titleArr.count
    }
    
    //delegate
    
    
    
    
    var selectionView = SelectionView()
    
    var titleArr: [String] = ["Red", "Yellow"]
    
    let width = UIScreen.main.bounds.width
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectionView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width, height: 100))
        selectionView.backgroundColor = .red
        selectionView.dataSource = self
        selectionView.delegate = self
        self.view.addSubview(selectionView)
        // Do any additional setup after loading the view.
    }


}



