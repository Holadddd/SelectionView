//
//  SelectionSuperView.swift
//  SelectionView
//
//  Created by wu1221 on 2019/8/19.
//  Copyright © 2019 wu1221. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class SelectionSuperView: UIView {
    
    func addXibView() {
        
        if let selctionView = Bundle(for: SelectionView.self).loadNibNamed("\(SelectionView.self)", owner: nil, options: nil)?.first as? UIView {
            addSubview(selctionView)
            selctionView.frame = bounds
        }
        
    }

    override func awakeFromNib() {
        
        super.awakeFromNib()
        addXibView()
        
    }
}

extension UITableView {
    
    func lk_registerCellWithNib(identifier: String, bundle: Bundle?) {
        
        let nib = UINib(nibName: identifier, bundle: bundle)
        
        register(nib, forCellReuseIdentifier: identifier)
    }
    
    func lk_registerHeaderWithNib(identifier: String, bundle: Bundle?) {
        
        let nib = UINib(nibName: identifier, bundle: bundle)
        
        register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
}

extension UITableViewCell {
    
    static var identifier: String {
        
        return String(describing: self)
    }
}

extension UICollectionView {
    
    func lk_registerCellWithNib(identifier: String, bundle: Bundle?) {
        
        let nib = UINib(nibName: identifier, bundle: bundle)
        
        register(nib, forCellWithReuseIdentifier: identifier)
    }
}
