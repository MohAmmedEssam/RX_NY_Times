//
//  ListVCViewController.swift
//  RX_NY_Times
//
//  Created by Mohammed Essam on 03/08/2022.
//  
//

import UIKit
import RxSwift
import RxCocoa

class ListVCViewController: ViewController, ListVCViewProtocol {
    // MARK: - UI
    lazy var tableView: UITableView = {
        let object = UITableView()
        object.backgroundColor = .clear
        object.register(cell: ListVCTableCell.self)
        return object
    }()
    
    // MARK: - Properties
    let presenter: ListVCPresenter

    // MARK: - Initialization

    init(presenter: ListVCPresenter) {
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

extension ListVCViewController{
    private func drawSubviews(){
        self.view.addSubview(tableView)
        tableView.fillParentConstraints(widthPercentage: 0.9, heightPercentage: 0.9)
    }
}

    // MARK: - Bind Presenter

extension ListVCViewController{
    private func bindPresenter() {
        presenter.output.isLoading
            .bind(to: isLoading)
            .disposed(by: disposeBag)
        
        self.rx.viewDidLoad
            .bind(to: presenter.input.viewDidLoad)
            .disposed(by: disposeBag)
        
        //MARK: tableView
        presenter.output.list
            .asDriver()
            .drive(tableView.rx.items(cellIdentifier: ListVCTableCell.self.identifier)){ (index,model,cell:ListVCTableCell) in
                cell.handleCell(model: model)
            }.disposed(by: disposeBag)
    }

}
