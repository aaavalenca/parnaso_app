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
    var categories : [String] = []
    var rhymes : [Palavra] = []
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 1, green: 165/255, blue: 0, alpha: 1)
        self.navigationItem.title = "Parnaso"
        
        self.stackView.axis = .vertical
        
        setupTableView()
        setupTextField()
//        setupLabel()
        setupButton()
        setConstraints()
        
    }
    
    func setupLabel(){
        label.text = ""
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 10
        label.textAlignment = .left
        view.addSubview(label)
    }
    
    func setupButton(){
        button.setTitle("RIMAR", for: .normal)
        button.setTitleColor(UIColor(red: 1, green: 165/255, blue: 0, alpha: 1), for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0,right: 8.0)
        button.backgroundColor = UIColor(red: 25/255, green: 13/255, blue: 134/255, alpha: 1)
        button.addTarget(self, action: #selector(self.pressed), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
    }
    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoryViewCell.self, forCellReuseIdentifier: CategoryViewCell.identifier)
        tableView.backgroundView = UIView()
        tableView.backgroundView!.backgroundColor = UIColor(red: 1, green: 165/255, blue: 0, alpha: 1)
        tableView.allowsSelection = true
        
        view.addSubview(tableView)
        
    }
    
    func setupTextField() {
        textField.attributedPlaceholder = NSAttributedString(
            string: "Tente rimar",
            attributes: [.foregroundColor: UIColor(red: 1, green: 165/255, blue: 0, alpha: 0.5)]
        )
        textField.isSecureTextEntry = false
        textField.backgroundColor = UIColor(red: 25/255, green: 13/255, blue: 134/255, alpha: 1)
        textField.textColor = UIColor(red: 1, green: 165/255, blue: 0, alpha: 1)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = .never
        textField.tintColor = .red
        textField.autocapitalizationType = .none
        textField.delegate = self
        
        view.addSubview(textField)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            
            //            textField
            
            textField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
            textField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            textField.bottomAnchor.constraint(equalTo: self.textField.topAnchor, constant: 40),
            textField.rightAnchor.constraint(equalTo: button.leftAnchor, constant: -10),
            
            
            //            button
            
            button.topAnchor.constraint(equalTo: textField.topAnchor),
            button.leftAnchor.constraint(equalTo: textField.rightAnchor),
            button.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
            button.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            
//            //            label
//
//            label.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 20),
//            label.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
//            label.bottomAnchor.constraint(equalTo: self.label.bottomAnchor, constant: -20),
//            label.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            
            //            tableview
            
            tableView.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 20),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),

        ])
    }
    
    @objc func pressed(sender: UIButton) {
        guard let name = self.textField.text else {
//            self.label.text = ""
            return
        }
//        self.label.text = name
        Task{
            
            self.rhymes = await fetchWordsFromAPI(word: name)
            self.categories = Array(Set(rhymes.map { $0.categoria }))
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryViewCell.identifier, for: indexPath) as? CategoryViewCell  else {
            fatalError("couldn't dequeue")
        }
        cell.configure(with: categories[indexPath.row])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        cell.addGestureRecognizer(tapGesture)
        
        return cell
    }
    
    @objc func cellTapped(sender: UITapGestureRecognizer) {
        if let indexPath = tableView.indexPathForRow(at: sender.location(in: tableView)) {
            let rhymesVC = RhymesViewController()
            rhymesVC.words = self.rhymes.filter{ $0.categoria == categories[indexPath.row] }.map{ $0.palavra }
            navigationController?.pushViewController(rhymesVC, animated: true)
        }
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
