//
//  JsonPlaceHolderVC.swift
//  CleanTableView
//
//  Created by Enes Sancar on 25.05.2023.
//

import UIKit

class JsonPlaceHolderVC: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    private let jsonTableView = JsonTableView()
    private let jsonService: JsonPlaceHolderProtocol = JsonPlaceHolderService()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.delegate = jsonTableView
        tableView.dataSource = jsonTableView
        jsonTableView.delegate = self
        fetchService()
    }
    
    func fetchService() {
        jsonService.fetchAllPosts { [weak self] models in
            guard let self = self else { return }
            self.jsonTableView.update(items: models)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension JsonPlaceHolderVC: JsonTableViewOutput {
    
    func onSelect(item: PostModel) {
        print(item.title ?? "")
    }
}
