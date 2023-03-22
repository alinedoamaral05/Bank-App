//
//  RegisterViewController.swift
//  Bank App
//
//  Created by Aline do Amaral on 14/03/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //MARK: - Dependency Injection:
    
    let viewModel: ViewModel
    
    // pode ser feito por protocolo - de maneira abstrata
    
    //MARK: - Variables
    private var  occupancyList: [String] = []
    
    //MARK: - Components
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "gradient")
        image.contentMode = .scaleToFill
        return image
    }()
    
    private let stackForLabels: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        return stack
    }()
    
    private let occupancyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: 20)
        label.textColor = .white
        label.text = "Qual a sua profissão?"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let occupancySubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: 13)
        label.textColor = .white
        label.text = "Digite e selecione a opção correspondente"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let dropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        return dropDown
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("OK", for: .normal)
        button.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    //MARK: - Init
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        dropDown.delegate = self
        viewModel.viewDidLoad()
        viewModel.delegate = self
    }
    
    //MARK: - Methods
    @objc private func goToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func goToNextScreen() {
        let navigation = CountrySelectionViewController()
        navigationController?.pushViewController(navigation, animated: false)
        
    }
    
    //MARK: - UI Setup
    private func setupInterface() {
        setupHierarchy()
        setupConstraints()
        navigationLayoutSetup()
    }
    
    private func navigationLayoutSetup() {
        navigationItem.title = "Passo 2 de 3 - Cadastro"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backItem?.backButtonTitle = " "
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(goToRoot))
    }
    
    private func setupHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(stackForLabels)
        stackForLabels.addArrangedSubview(occupancyLabel)
        stackForLabels.addArrangedSubview(occupancySubtitleLabel)
        view.addSubview(dropDown)
        view.addSubview(continueButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            stackForLabels.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackForLabels.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackForLabels.heightAnchor.constraint(equalToConstant: 70),
            
            dropDown.topAnchor.constraint(equalTo: stackForLabels.bottomAnchor, constant: 20),
            dropDown.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dropDown.heightAnchor.constraint(equalToConstant: 500),
            dropDown.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 5),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
//MARK: - DropDownDelegateProtocol
extension RegisterViewController: DropDownDelegateProtocol {
    func getHeight() -> Int {
        return occupancyList.count
    }
    
    func getOptions() -> [String] {
        return occupancyList
    }
    
    func didUpdateSelection(text: String?) {
        if text?.isEmpty ?? true {
            continueButton.isEnabled = false
        } else {
            continueButton.isEnabled = true
        }
    }
}

//MARK: - OccupancyInfoDelegate
extension RegisterViewController: ViewModelDelegate {
    func errorData(error: Error) {
        print(error)
    }
    
    func successData(_ data: [Occupancy]?) {
        print("entrei aqui")
        DispatchQueue.main.async {
            guard let infos = data else {return}
            let names = infos.map { $0.name }
            self.occupancyList = names
            self.dropDown.reloadData()
        }
        
    }
}
