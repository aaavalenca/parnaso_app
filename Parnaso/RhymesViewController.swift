//
//  RhymesViewController.swift
//  Parnaso
//
//  Created by aaav on 20/11/23.
//

import UIKit

class RhymesViewController: UIViewController {
    
    var words : [String]?
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .red
        setupTableView()
    }
    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "rhymeCell")
        tableView.backgroundView = UIView()
        tableView.backgroundView!.backgroundColor = UIColor(red: 1, green: 165/255, blue: 0, alpha: 1)
        tableView.allowsSelection = true
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        ])
    }
}


extension RhymesViewController: UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if let textToCopy = cell.textLabel?.text {
                UIPasteboard.general.string = textToCopy
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rhymeCell", for: indexPath)
        cell.textLabel?.text = words?[indexPath.row]
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = UIColor(red: 25/255, green: 13/255, blue: 134/255, alpha: 1)
        cell.textLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.3)
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
}
