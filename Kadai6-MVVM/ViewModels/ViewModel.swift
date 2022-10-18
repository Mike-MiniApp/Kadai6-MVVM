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
    var sliderValueObservable: Observable<Float> { get }
    var judgeButtonTapObservable: Observable<Void> { get }
}

// MARK: - Outputs
protocol ViewModelOutputs {
    var judgePublishSubject: PublishSubject<String> { get }
    var sliderValuePublishSubject: PublishSubject<Int> { get }
}

// MARK: - Type
protocol ViewModelType {
    var inputs: ViewModelInputs { get }
    var outputs: ViewModelOutputs { get }
}

class ViewModel: ViewModelInputs, ViewModelOutputs {

    // MARK: - Inputs
    var sliderValueObservable: RxSwift.Observable<Float>
    var judgeButtonTapObservable: RxSwift.Observable<Void>

    // MARK: - Outputs
    var judgePublishSubject = RxSwift.PublishSubject<String>()
    var sliderValuePublishSubject = RxSwift.PublishSubject<Int>()

    var correctAnswer = Int()
    private var sliderValue = Int()
    private var judgeResult = String()
    private let disposeBag = DisposeBag()

    init(sliderValueObservable: Observable<Float>,judgeButtonTapObservable: Observable<Void>,correctAnswer: Int) {
        self.sliderValueObservable = sliderValueObservable
        self.judgeButtonTapObservable = judgeButtonTapObservable
        self.correctAnswer = correctAnswer
        setupBindings()
    }

    private func setupBindings() {
        sliderValueObservable.subscribe (onNext: { value in
            print("sliderValue:",Int(value))
            self.sliderValue = Int(value)
        }).disposed(by: disposeBag)

        judgeButtonTapObservable.subscribe (onNext: {
            if(self.sliderValue == self.correctAnswer){
                self.judgePublishSubject.onNext("当たり")
                self.sliderValuePublishSubject.onNext(self.sliderValue)
            }else{
                self.judgePublishSubject.onNext("ハズレ")
                self.sliderValuePublishSubject.onNext(self.sliderValue)
            }
        }).disposed(by: disposeBag)
    }
}

// MARK: - ViewModelType
extension ViewModel: ViewModelType {
    var inputs: ViewModelInputs { return  self }
    var outputs: ViewModelOutputs { return self }
}
