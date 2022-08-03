//
//  DetailsViewViewController.swift
//  RX_NY_Times
//
//  Created by Mohammed Essam on 03/08/2022.
//  
//

import UIKit
import RxSwift
import RxCocoa

class DetailsViewViewController: ViewController, DetailsViewViewProtocol {
    // MARK: - UI
    
    lazy private var imgView: UIImageView = {
        let object = UIImageView()
        return object
    }()
    
    lazy private var titleLabel: UILabel = {
        let object = UILabel()
        object.prepare(textColor: .label, font: .h5 , textAlignment: .left)
        return object
    }()
    lazy private var descriptionLabel: UILabel = {
        let object = UILabel()
        object.prepare(textColor: .secondarylabel, font: .h6 , textAlignment: .left)
        return object
    }()
    
    lazy private var dateLabel: UILabel = {
        let object = UILabel()
        object.prepare(textColor: .secondarylabel, font: .h6 , textAlignment: .right,numberOfLines: 1)
        return object
    }()
    
    // MARK: - Properties
    let presenter: DetailsViewPresenter

    // MARK: - Initialization

    init(presenter: DetailsViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        print("\(String(describing: self)) init")
        self.bindPresenter()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.drawMyView()
    }

    //Main Draw Action
    private func drawMyView(){
        //draw SubViews
        self.drawSubviews()
    }
}

    // MARK: - Draw Subviews

extension DetailsViewViewController{
    private func drawSubviews(){
        //add scrollView
        let scrollView = ScrollStack()
        self.view.addSubview(scrollView)
        scrollView.withConstraints(leading:0, trailing: 0,
                                   top: DesignSystem.verticalSpace,
                                   bottom: -DesignSystem.verticalSpace)
        
        //add subviews
        scrollView.addArrangedSubview(imgView, withHeight: (UIScreen.main.bounds.height * 0.35))
        scrollView.addArrangedSubview(titleLabel)
        scrollView.addArrangedSubview(descriptionLabel)
        scrollView.addArrangedSubview(dateLabel)
    }
}

    // MARK: - Bind Presenter

extension DetailsViewViewController{
    private func bindPresenter() {
        presenter.output.model
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [weak self]  in
                guard let model = $0 else{return}
                self?.imgView.fromURL(model.media?.first?.mediaMetadata?.first?.url ?? "")
                self?.titleLabel.text = model.title
                self?.dateLabel.text = "🗓 " + (model.publishedDate ?? "")
                self?.descriptionLabel.text = "\(model.byline ?? "")\n\n\(model.adxKeywords ?? "")\n\n\(model.abstract ?? "")"
            })
            .disposed(by: disposeBag)
    }

}
