//
//  DrumMachineViewController.swift
//  Sampler 2.0
//
//  Created by harry.nelken on 11/9/18.
//  Copyright © 2018 harry.nelken. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DrumMachineViewController: UIViewController {

    @IBOutlet var pads: [UIButton]!

    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//
//        let tags = pads
//            .map { ($0.rx.tap, $0.tag) }
//            .map { obs, tag in
//                obs.map { tag }
//            }

        Observable
            .from(pads.map { $0.rx.tappedButton() })
            .merge()
            .subscribe(onNext: { tappedButton in
                print(tappedButton.tag)
            }).disposed(by: bag)

    }

}

extension Reactive where Base: UIButton {

    func tappedButton() -> Observable<UIButton> {
        return tap.map { self.base }
    }

    func tappedTags() -> Observable<Int> {
        return tap.map { self.base.tag }
    }
}
