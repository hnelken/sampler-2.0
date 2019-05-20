//
//  RxExtensions.swift
//  Sampler 2.0
//
//  Created by harry.nelken on 5/17/19.
//  Copyright © 2019 harry.nelken. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UIButton {
    func buttonOnTouchDown() -> Observable<UIButton> {
        return controlEvent(.touchDown).map { self.base }
    }

    func buttonOnTouchUpInside() -> Observable<UIButton> {
        return tap.map { self.base }
    }
}
