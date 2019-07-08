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

    private lazy var soundIDs: [Int] = {
        return [Int](repeating: Sounds.defaultSoundID, count: pads.count)
    }()

    private let bag = DisposeBag()
    private let viewModel = DrumMachineViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    private func setupBindings() {
        setupButtonBindings()
    }

    private func setupButtonBindings() {
        Observable.from(pads.map { $0.rx.buttonOnTouchUpInside() })
            .merge()
            .subscribe(onNext: { [weak self] button in
                guard let self = self else { return }
                button.backgroundColor = self.viewModel.normalButtonColor
                self.playSound(atIndex: button.tag)
            }).disposed(by: bag)

        Observable.from(pads.map { $0.rx.buttonOnTouchDown() })
            .merge()
            .subscribe(onNext: { [weak self] button in
                guard let self = self else { return }
                button.backgroundColor = self.viewModel.pressedButtonColor
            }).disposed(by: bag)
    }

    private func playSound(atIndex index: Int) {
        let soundID = soundIDs[index]
        Sounds.playSound(withID: soundID)
    }
}

