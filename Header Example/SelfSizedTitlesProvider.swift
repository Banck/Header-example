//
//  SelfSizedTitlesProvider.swift
//  Olimp
//
//  Created by Egor Sakhabaev on 27.08.2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import Foundation
import UIKit
import CollectionKit
class SelfSizedTitlesProvider: BasicProvider<String, SelfSizedCollectionCell> {
    init(_ dataSource: DataSource<String>, font: UIFont, textColor: UIColor, tapHandler: ((BasicProvider<String, SelfSizedCollectionCell>.TapContext)->(Void))? = nil) {
        let dummyCell = SelfSizedCollectionCell()
        let sourceSize = {(index: Int, data: String, collectionSize: CGSize) -> CGSize in
            let isLoading = data.isEmpty
            dummyCell.configure(with: (title: data, font: font, textColor: textColor, topSeparator: false, bottomSeparator: true, isLoading: isLoading))
            let cellSize = dummyCell.systemLayoutSizeFitting(collectionSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
            
            return cellSize
        }
        let viewGenerator = { (data: String, index: Int) -> SelfSizedCollectionCell in
            let cell = SelfSizedCollectionCell()
            print("view generated at index \(index)")
            return cell
        }

        
        let sourceView = ClosureViewSource(viewGenerator: viewGenerator, viewUpdater: {(cell: SelfSizedCollectionCell, data: String, index: Int) in
            let isLoading = data.isEmpty
            cell.configure(with: (title: data, font: font, textColor: textColor, topSeparator: false, bottomSeparator: true, isLoading: isLoading))
        })
        
        super.init(
            dataSource: dataSource,
            viewSource: sourceView,
            sizeSource: sourceSize,
            layout: FlowLayout(spacing: 0),
            animator: AnimatedReloadAnimator(),
            tapHandler: tapHandler
        )
    }
}
