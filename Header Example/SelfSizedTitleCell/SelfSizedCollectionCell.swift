//
//  SelfSizedCollectionCell.swift
//  Olimp
//
//  Created by Egor Sakhabaev on 27.08.2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import UIKit
class SelfSizedCollectionCell: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topSeparatorView: UIView!
    @IBOutlet weak var bottomSeparatorView: UIView!
    // MARK: - Initialization and deinitialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
        fromNib()
    }
    
    init() {
        super.init(frame: .zero)
        configureUI()
        fromNib()
    }
    
    
    func configureUI() {
        backgroundColor = .gray
        
    }
    
    func configure(with data: (title: String?, font: UIFont, textColor: UIColor, topSeparator: Bool, bottomSeparator: Bool, isLoading: Bool)) {
        titleLabel.numberOfLines = 0
        titleLabel.text = data.title
        titleLabel.font = data.font
        titleLabel.textColor = data.textColor
        topSeparatorView.isHidden = !data.topSeparator
        bottomSeparatorView.isHidden = !data.bottomSeparator
    }
}

extension UIView {
    
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            return nil
        }
        addSubview(contentView)
        contentView.fillSuperview()
        return contentView
    }
}
