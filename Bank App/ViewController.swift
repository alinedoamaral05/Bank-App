//
//  ViewController.swift
//  Bank App
//
//  Created by Aline do Amaral on 14/03/23.
//

/*
 Vinicius da Silva - Superdigital (legado - Brasil)
 
 Indicações de livros: Código Limpo, Programador Pragmático
 
 O dev ia migrar alguns fluxos da Super para design system, mas houve uma realocação e ele foi para o projeto do legado, que roda apenas no Brasil;
 Estão sendo adicionadas algumas telas no fluxo de onboarding.
 O projeto está em storyboard (todas dentro de um arquivo só, gerando grande delay até mesmo para abrir este arquivo).
 Foi-nos proposto montar um app "réplica" do projeto da super (não nos foi concedido o código nem acesso ao figma, mas ele tirou prints para nos guiarmos).
 Houve breve explicações sobre:
 
 - Diferença entre instanciar uma ViewController por init com PushViewController x instância com PresentViewController:
 
     *Push = quando quer manter a navegação (fluxo), sentido de continuidade; telas vêm da direita pra esquerda (e são fechadas com pop da esquerda pra direita)
     *Present = inicia um novo fluxo, fechada com dismiss, fecha a primeira tela de navegação.
 
 - Testes unitários a partir de structs/classes, AAA {
      Arrange {
        numero1 = 20
        numero2 = 50
      }
 
      Action {
        resultado = numero1 + numero2
      }
 
      Assert {
        verifica se resultado == 70
      }
 
 - Pirâmide de testes {
      * Testes End-to-End
      * Testes de Integração
      * Unit tests
 
 - Armazenamento em cache por FileManager
 - console.log() po (print object) indexPath com breakingPoint ativo
 - Protocolos, completion handles, closures
 - Patterns: Guru Factory, coordinator/router (navegação), UseCase (regra de negócio, validações - ele fez um request de countries pegar opções e mostrar na tableview)
 - Componentização
 - Firebase analytics
 */

import UIKit


class ViewController: UIViewController {
    
    //MARK: Variables
    
    //MARK: Components
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "gradient")
        image.contentMode = .scaleToFill
        return image
    }()
    
    private let labelAndButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 30
        stack.alignment = .center
        return stack
    }()
    
    private let wannaJoinLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Quer fazer parte deste time?"
        label.font = UIFont(name: "Arial", size: 25)
        label.textColor = .white
        return label
    }()
    
    lazy var joinUsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Entrar", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.setTitleColor(.purple, for: .normal)
        button.addTarget(self, action: #selector(goToRegistrationScreen), for: .touchUpInside)
        return button
    }()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }
    
    //MARK: Methods
    @objc private func goToRegistrationScreen() {
        navigationController?.pushViewController(RegisterViewController(viewModel: ViewModel()), animated: false)
    }
    
    //MARK: Interface Setup
    private func setupInterface() {
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(labelAndButtonStack)
        labelAndButtonStack.addArrangedSubview(wannaJoinLabel)
        labelAndButtonStack.addArrangedSubview(joinUsButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            labelAndButtonStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelAndButtonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            joinUsButton.heightAnchor.constraint(equalToConstant: 50),
            joinUsButton.widthAnchor.constraint(equalToConstant: 170)
        ])
    }

}

