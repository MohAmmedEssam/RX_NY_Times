//
//  ListVCTableCell.swift
//  RX_NY_Times
//
//  Created by Mohammed Essam on 03/08/2022.
//

import Foundation
import UIKit
import RxSwift

class ListVCTableCell: UITableViewCell {
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
    lazy private var userLabel: UILabel = {
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
    private var disposeBag = DisposeBag()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    // MARK: - setupUI

    private func setupUI(){
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear

        let stack = [imgView, titleLabel, userLabel, dateLabel].vStacked
        self.addSubview(stack)
        stack.fillParentConstraints(heightPercentage: 0.95)

        imgView.withConstraints(withHeight: (UIScreen.main.bounds.height * 0.25))
    }
    
    //MARK: handleCell
    public func handleCell(model: Result){
        self.imgView.fromURL(model.media?.first?.mediaMetadata?.first?.url ?? "")
        titleLabel.text = model.title
        userLabel.text = model.byline
        dateLabel.text = "🗓 " + (model.publishedDate ?? "")

    }
}
