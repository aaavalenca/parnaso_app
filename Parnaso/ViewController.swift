//
//  ViewController.swift
//  Parnaso
//
//  Created by aaav on 12/11/23.
//

import UIKit

class ViewController: UIViewController {

    let tableView = UITableView()
    let textField : UITextField = UITextField();
//    var safeArea: UILayoutGuide!
    let label = UILabel()
    let button = UIButton()
    var words : [Palavra] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0, green: 128/255, blue: 128/255, alpha: 1)
        setupTableView()
        setupTextField()
        setupLabel()
        setupButton()
        setConstraints()
    }

    @objc func pressed () {
        self.label.text = self.textField.text
        fetchWordsFromAPI()
    }
    
    func setupLabel(){
        label.text = "Displayed text will appear here"
        label.textColor = .red
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
    
        view.addSubview(label)
    }
    
    func setupButton(){
        button.setTitle("Display Text", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(button)
    }
    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        
    }
    
    func setupTextField() {
        textField.placeholder = "O que quer rimar?"
        textField.backgroundColor = UIColor(red: 232/255, green: 1, blue: 252/255, alpha: 1)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        
        view.addSubview(textField)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([

//            textField
            
            textField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            textField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            textField.bottomAnchor.constraint(equalTo: self.textField.topAnchor, constant: 40),
            textField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            
//            tableview
            
            tableView.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 20),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            
            
//            label
            
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),

//            button
            
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 20)
            
            
        ])
    }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return words.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = words[indexPath.row].palavra
    return cell
  }
}

extension ViewController : UITextFieldDelegate {
    
    
    
}
