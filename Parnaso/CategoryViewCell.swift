//
//  CategoryViewCell.swift
//  Parnaso
//
//  Created by aaav on 20/11/23.
//

import UIKit

class CategoryViewCell: UITableViewCell {

    static let identifier = "CategoryViewCell"
    
    private let category : UILabel = {
        let label = UILabel()
        label.text = "Nenhuma categoria"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder hasn't been implemented")
    }

    public func configure(with categoryType : String){
        self.category.text = categoryType
        self.category.textColor = UIColor(red: 25/255, green: 13/255, blue: 134/255, alpha: 1)
        self.category.font = .systemFont(ofSize: 24, weight: .black)
        self.isUserInteractionEnabled = true
        self.accessoryType = .disclosureIndicator
        self.tintColor = .red
        self.selectionStyle = .blue
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.3)
        self.selectedBackgroundView = bgColorView
    }
    
    func setupUI(){
        self.backgroundColor = .clear
        self.contentView.addSubview(category)
        
        category.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            category.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            category.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            category.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            category.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
