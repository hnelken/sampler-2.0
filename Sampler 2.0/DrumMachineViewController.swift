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
        setupBindings()
    }

    private func setupBindings() {
        setupButtonBindings()
    }

    private func setupButtonBindings() {
        Observable
            .from(pads.map { $0.rx.buttonOnTouchUpInside() })
            .merge()
            .subscribe(onNext: { button in
                button.backgroundColor = .lightGray
            }).disposed(by: bag)

        Observable.from(pads.map { $0.rx.buttonOnTouchDown() })
            .merge()
            .subscribe(onNext: { button in
                button.backgroundColor = .red
            }).disposed(by: bag)

    }
}

extension Reactive where Base: UIButton {
    func buttonOnTouchDown() -> Observable<UIButton> {
        return controlEvent(.touchDown).map { self.base }
    }

    func buttonOnTouchUpInside() -> Observable<UIButton> {
        return tap.map { self.base }
    }
}
