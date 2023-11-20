//
//  ViewController.swift
//  Parnaso
//
//  Created by aaav on 12/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    let textField = UITextField()
    let label = UILabel()
    let button = UIButton()
    var words : [Palavra] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0, green: 128/255, blue: 128/255, alpha: 1)
        self.navigationItem.title = "Parnaso"
        
        setupTableView()
        setupTextField()
        setupLabel()
        setupButton()
        setConstraints()
    }
    
    func setupLabel(){
        label.text = "PALAVRA"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 10
        
        view.addSubview(label)
    }
    
    func setupButton(){
        button.setTitle("RIMAR", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0,right: 8.0)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(self.pressed), for: .touchUpInside)
        button.layer.cornerRadius = 10
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
        textField.isSecureTextEntry = false
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
            textField.rightAnchor.constraint(equalTo: button.leftAnchor, constant: -10),
            
            //            button
            
            button.topAnchor.constraint(equalTo: textField.topAnchor),
            button.leftAnchor.constraint(equalTo: textField.rightAnchor),
            button.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
            button.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            
            //            label
            
            label.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 20),
            label.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: self.label.bottomAnchor, constant: -20),
            label.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            
            //            tableview
            
            tableView.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 20),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            
            
            
        ])
    }
    
    @objc func pressed(sender: UIButton) {
        guard let name = self.textField.text else {
            self.label.text = ""
            return
        }
        self.label.text = name
        Task{
            self.words = await fetchWordsFromAPI(word: name)
            self.tableView.reloadData()
        }
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if string == " " {
            return false
        }
        return newText.count <= 12
    }
}
