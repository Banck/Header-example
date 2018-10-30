//
//  ChampsProvider.swift
//  Olimp
//
//  Created by Egor Sakhabaev on 30/10/2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import Foundation
import CollectionKit
class ChampsProvider: ComposedHeaderProvider<SportView> {
    private var champsDataSources: [ArrayDataSource<String>] = []
    
    init(sports: [String], tapAction: ((ChampsProvider.TapContext) -> Void)? = nil) {
        let dummyCell = SportView()
        let cellUpdate = { (cell: SportView, data: ComposedHeaderProvider<SportView>.HeaderData, at: Int) in
            cell.configure(with: sports[at])
        }
        let sizeSource = { (index: Int, data: ComposedHeaderProvider<SportView>.HeaderData, collectionSize: CGSize) -> CGSize in
            dummyCell.configure(with: sports[index])
            let cellSize = dummyCell.systemLayoutSizeFitting(collectionSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
            return cellSize
        }
        var champsSections: [SelfSizedTitlesProvider] = []
        for _ in 0..<sports.count {
            let dataSource = ArrayDataSource<String>(data: [])
            champsDataSources.append(dataSource)
            let provider = SelfSizedTitlesProvider(dataSource, font: .systemFont(ofSize: 16, weight: .regular), textColor: .black, tapHandler: nil)
            champsSections.append(provider)
        }
        
        super.init(
            layout: FlowLayout(),
            animator: AnimatedReloadAnimator(),
            headerViewSource: ClosureViewSource(viewUpdater: cellUpdate),
            headerSizeSource: sizeSource,
            sections: champsSections,
            tapHandler: tapAction)
    }
    
    func append(champs: [String], for index: Int) {
        champsDataSources[index].data = champs
    }
    
    func didSelectSport(at index: Int) {
        let isExpanded = self.isExpanded(at: index)
        if isExpanded == false {
            let sportView = view(at: index) as? SportView
        } else {
            champsDataSources[index].data = []
        }
    }
    
    func isExpanded(at index: Int) -> Bool {
        return champsDataSources[index].data.count != 0
    }
}

