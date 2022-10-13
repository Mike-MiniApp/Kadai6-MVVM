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

    private lazy var viewModel = ViewModel(sliderObservable: slider.rx.value.map{$0 ?? 0}.asObservable(), judgeButtonTapObservable: judgeButton.rx.tap.asObservable())

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
