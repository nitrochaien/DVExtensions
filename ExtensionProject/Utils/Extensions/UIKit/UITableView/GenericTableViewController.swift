//
//  GenericTableViewController.swift
//  GeneticsTableView
//
//  Created by Nam Vu on 10/19/18.
//  Copyright © 2018 Nam Vu. All rights reserved.
//

import UIKit

class GenericTableViewController<T: GenericCell<U>, U>: UITableViewController {
    let cellId = "genericCellId"
    var items = [U]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(T.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 40
        
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = rc
    }
    
    @objc func handleRefresh() {
        tableView.refreshControl?.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! GenericCell<U>
        cell.item = items[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

class GenericCell<U>: UITableViewCell {
    var item: U!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

//Example:
//class ViewController: GenericTableViewController<PersonCell, Person> {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        items = [Person(firstName: "Bill", lastName: "Clinton"),
//                 Person(firstName: "Barrack", lastName: "Obama")]
//    }
//
//    override func handleRefresh() {
//        print("handle in child")
//
//        super.handleRefresh()
//    }
//}
