//
//  DropDown.swift
//  Bank App
//
//  Created by Aline do Amaral on 14/03/23.
//

import UIKit

//MARK: Communication
protocol DropDownDelegateProtocol {
    func didUpdateSelection(text: String?)
    func getOptions() -> [String]
    func getHeight() -> Int
}

class DropDown: UIView {
    //MARK: - Variables
    var delegate: DropDownDelegateProtocol?
    var selectedOccupancy: String = ""
    
    //variável computada, atribuida na hora que chama - não é armazenada na memória
    //Computa sua propriedade a partir de um request. It can be a valuable addition to any of your types to add a new property value based on other conditions. This post explains how and when to use them, as well as the differences between a computed value and a method.
    var tableViewHeight = 8 * 50
    
    //MARK: - Components
    private let dropDownCell = DropDownTableViewCell()
    
    private let stackForSearchAndImage: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 1
        stack.distribution = .fillProportionally
        stack.alignment = .center
        return stack
    }()
    
    lazy var searchTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.attributedPlaceholder = NSAttributedString(string: "Profissão", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
        textfield.backgroundColor = .clear
        textfield.textColor = .white
        textfield.tintColor = .clear
        textfield.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showTableView)))
        return textfield
    }()
    
    lazy var dropDownImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "chevron.down")
        image.backgroundColor = .clear
        image.tintColor = .white
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showTableView)))
        return image
    }()
    
    private let viewUnderTextFieldAndImage: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let tableViewForItems: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.tintColor = .black
        tableView.layer.cornerRadius = 10
        tableView.register(DropDownTableViewCell.self, forCellReuseIdentifier: "DropDownTableViewCell")
        return tableView
    }()
    
    //MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInterface()
        setDelegates()
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInterface()
        setDelegates()
    }
    //MARK: Delegates
    private func setDelegates() {
        searchTextField.delegate = self
        tableViewForItems.delegate = self
        tableViewForItems.dataSource = self
    }
    
    //MARK: Methods
    
    func reloadData() {
        tableViewForItems.reloadData()
    }
    
    //MARK: UI Setup
    private func setupInterface() {
        setupHierarchy()
        setupConstraints()
        tableViewForItems.isHidden = true
    }
    
    @objc private func showTableView() {
        tableViewForItems.isHidden = false
    }
    
    private func setupHierarchy() {
        self.addSubview(stackForSearchAndImage)
        stackForSearchAndImage.addArrangedSubview(searchTextField)
        stackForSearchAndImage.addArrangedSubview(dropDownImage)
        self.addSubview(viewUnderTextFieldAndImage)
        self.addSubview(tableViewForItems)
        
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackForSearchAndImage.topAnchor.constraint(equalTo: self.topAnchor),
            stackForSearchAndImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackForSearchAndImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackForSearchAndImage.heightAnchor.constraint(equalToConstant: 50),
            
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            searchTextField.widthAnchor.constraint(equalToConstant: 100),
            searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            
            dropDownImage.heightAnchor.constraint(equalToConstant: 22),
            dropDownImage.widthAnchor.constraint(equalToConstant: 22),
            
            viewUnderTextFieldAndImage.heightAnchor.constraint(equalToConstant: 1),
            viewUnderTextFieldAndImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            viewUnderTextFieldAndImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            viewUnderTextFieldAndImage.topAnchor.constraint(equalTo: stackForSearchAndImage.bottomAnchor),
            
            tableViewForItems.topAnchor.constraint(equalTo: viewUnderTextFieldAndImage.topAnchor),
            tableViewForItems.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableViewForItems.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableViewForItems.heightAnchor.constraint(equalToConstant: CGFloat(self.tableViewHeight))
        ])
    }
}

//MARK: Extensions
extension DropDown: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        tableViewForItems.isHidden = false
        
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
}

extension DropDown: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = delegate?.getHeight() else {return 0}
        
        return count * 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownTableViewCell", for: indexPath)
        guard let options = delegate?.getOptions() else {return .init()}
        
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let options = delegate?.getOptions() else {return}
        searchTextField.text = options[indexPath.row]
        guard let text = searchTextField.text else {return}
        selectedOccupancy = text
        tableViewForItems.isHidden = true
        delegate?.didUpdateSelection(text: text)
        
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
