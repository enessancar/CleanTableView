//
//  RickMortyVC.swift
//  RickAndMorty
//
//  Created by Enes Sancar on 25.05.2023.
//

import UIKit
import SnapKit

protocol RickMortyOutput {
    func changeLoading(isLoad: Bool)
    func saveDatas(values: [Result])
}

final class RickMortyVC: UIViewController {
    
    //MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.text = "Rick&Morty"
        return label
    }()
    
    private let tableView = UITableView()
    private let indicator = UIActivityIndicatorView()
    
    private lazy  var results: [Result] = []
    lazy var viewModel: IRickMortyViewModel = RickMortyViewModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
    }
    
    private func configureView() {
        view.addSubview(tableView)
        view.addSubview(titleLabel)
        view.addSubview(indicator)
        
        drawDesign()
        makeTableView()
        makeTitleLabel()
        makeIndicator()
        
    }
    
    private func drawDesign() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RMTableViewCell.self, forCellReuseIdentifier: RMTableViewCell.identifier)
        
        indicator.color = .red
        indicator.startAnimating()
    }
}

extension RickMortyVC: RickMortyOutput {
    
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    func saveDatas(values: [Result]) {
        results = values
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: - TableView DataSource/Delegate
extension RickMortyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RMTableViewCell.identifier, for: indexPath) as? RMTableViewCell else {
            fatalError()
        }
        cell.saveModel(model: results[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}

extension RickMortyVC {
    
    private func makeTableView() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.right.left.bottom.equalToSuperview()
        }
    }
    
    private func makeTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalTo(view)
        }
    }
    
    private func makeIndicator() {
        indicator.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-10)
            make.top.equalTo(tableView.snp.top)
        }
    }
}
