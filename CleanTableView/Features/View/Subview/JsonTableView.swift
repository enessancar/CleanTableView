//
//  JsonTableView.swift
//  CleanTableView
//
//  Created by Enes Sancar on 25.05.2023.
//

import UIKit

protocol JsonTableViewProtocol {
    func update(items: [PostModel])
}

protocol JsonTableViewOutput: AnyObject {
    func onSelect(item: PostModel)
}


final class JsonTableView: NSObject {
 
    private lazy var items: [PostModel] = []
    weak var delegate: JsonTableViewOutput?
}

extension JsonTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row].title
        cell.detailTextLabel?.text = items[indexPath.row].body  
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onSelect(item: items[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}

extension JsonTableView: JsonTableViewProtocol {
    
    func update(items: [PostModel]) {
        self.items = items
    }
}
