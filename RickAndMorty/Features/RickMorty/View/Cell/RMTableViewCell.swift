//
//  RMTableViewCell.swift
//  RickAndMorty
//
//  Created by Enes Sancar on 26.05.2023.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

final class RMTableViewCell: UITableViewCell {
    static let identifier = "RMTableViewCell"
    
    //MARK: - Properties
    
    private lazy var customImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    private let title = UILabel()
    private let status = UILabel()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(customImage)
        addSubview(title)
        addSubview(status)
        
        title.font = .boldSystemFont(ofSize: 18)
        status.font = .preferredFont(forTextStyle: .title2)
        status.textColor = .darkGray
        
        customImage.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.height.equalTo(150)
            make.left.right.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(customImage.snp.bottom).offset(10)
            make.right.left.equalTo(contentView)
        }
        
        status.snp.makeConstraints { make in
            make.top.equalTo(title)
            make.right.equalTo(contentView).offset(-20)
        }
    }
    
    func saveModel(model: Result) {
        title.text = model.name
        status.text = model.status?.rawValue
        customImage.kf.setImage(with: model.image?.asUrl)
    }
}
