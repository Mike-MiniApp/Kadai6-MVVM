//
//  ViewController.swift
//  Kadai6-MVVM
//
//  Created by 近藤米功 on 2022/10/14.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class ViewController: UIViewController {
    // MARK: - UI Parts
    @IBOutlet private weak var answerLabel: UILabel!
    @IBOutlet private weak var slider: UISlider!
    @IBOutlet private weak var judgeButton: UIButton!

    private var correctAnswer: Int = 0

    private let disposeBag = DisposeBag()

    private lazy var viewModel = ViewModel(sliderValueObservable: slider.rx.value.asObservable(), judgeButtonTapObservable: judgeButton.rx.tap.asObservable(),correctAnswer: correctAnswer)

    override func viewDidLoad() {
        super.viewDidLoad()
        setInit()
        setupBindings()
    }

    private func setupBindings() {
        let totalOutput = Observable.combineLatest(viewModel.outputs.sliderValuePublishSubject, viewModel.outputs.judgePublishSubject)

        totalOutput.subscribe (onNext: { value,judge in
            self.judgeAlert(judge: judge, numberSlider: Int(value))
        }).disposed(by: disposeBag)

    }

    private func setInit() {
        correctAnswer = Int.random(in: 1...100)
        viewModel.correctAnswer = correctAnswer
        answerLabel.text = String(correctAnswer)
        slider.value = 50
    }

    private func judgeAlert(judge: String, numberSlider: Int) {
        let title = "結果"
        let message = "\(judge)!\nあなたの値: \(numberSlider)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let restart = UIAlertAction(title: "再挑戦", style: .default) { _ in
            self.setInit()
        }
        alert.addAction(restart)
        present(alert, animated: true, completion: nil)
    }
}
