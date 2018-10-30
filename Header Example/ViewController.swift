//
//  ViewController.swift
//  Header Example
//
//  Created by Egor Sakhabaev on 31/10/2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import UIKit
import CollectionKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: CollectionView!
    var champsProvider: ChampsProvider?
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectionSportAction = { [weak self] (context: ChampsProvider.TapContext) -> Void in
            let isExpanded = self?.champsProvider?.isExpanded(at: context.index)
            self?.champsProvider?.didSelectSport(at: context.index)
            if isExpanded == false {
                self?.delay(0.5, closure: {
                    self?.champsProvider?.append(champs: ["aa", "bb", "cc", "dd", "ee", "ff", "gg", "hj", "jk", "sg", "tr", "yt"], for: context.index)
                })
            }
        }
        champsProvider = ChampsProvider(sports: ["Football", "tennis", "basketball", "hockey"], tapAction: selectionSportAction)
        collectionView.provider = champsProvider

    }
    
    func delay(_ delay: Double, closure:@escaping () -> Void) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }


}

