//
//  CountrySelectionViewController.swift
//  Bank App
//
//  Created by Aline do Amaral on 20/03/23.
//

import UIKit

class CountrySelectionViewController: UIViewController {

    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "gradient")
        image.contentMode = .scaleToFill
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        
    }
    
    private func setupHierarchy() {
        view.addSubview(backgroundImage)
    }
    private func setupInterface() {
        setupHierarchy()
        setupConstraints()
        navigationLayoutSetup()
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    private func navigationLayoutSetup() {
        navigationItem.title = "Passo 2 de 3 - Cadastro"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backItem?.backButtonTitle = " "
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(goPreviousScreen))
        view.backgroundColor = .systemBlue
    }
    
    @objc private func goPreviousScreen() {
        navigationController?.popViewController(animated: false)
    }

}
