//
//  ViewModel.swift
//  Kadai6-MVVM
//
//  Created by 近藤米功 on 2022/10/14.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa
// MARK: - Inputs
protocol ViewModelInputs {
    var sliderObservable: Observable<Int> { get }
    var judgeButtonTapObservable: Observable<Void> { get }

}

// MARK: - Outputs
protocol ViewModelOutputs {

}

// MARK: - Type
protocol ViewModelType {
    var inputs: ViewModelInputs { get }
    var outputs: ViewModelOutputs { get }
}

class ViewModel: ViewModelInputs, ViewModelOutputs {
    // MARK: - Inputs
    var sliderObservable: RxSwift.Observable<Int>
    var judgeButtonTapObservable: RxSwift.Observable<Void>

    init(sliderObservable: Observable<Int>,judgeButtonTapObservable: Observable<Void>){
        self.sliderObservable = sliderObservable
        self.judgeButtonTapObservable = judgeButtonTapObservable
    }
}

// MARK: - ViewModelType
extension ViewModel: ViewModelType {
    var inputs: ViewModelInputs { return  self }
    var outputs: ViewModelOutputs { return self }
}
