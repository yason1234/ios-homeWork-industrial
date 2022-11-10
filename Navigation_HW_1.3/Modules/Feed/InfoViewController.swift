//
//  InfoViewController.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 08.07.2022.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var buttonAlert = ButtonAlert()
    private lazy var dismissButton = UIButton()
    private lazy var JSONLabel = UILabel()
    private lazy var JSONCodableLabel = UILabel()
    private lazy var JSONTableView = UITableView()
    
    private let viewModel: FeedModelProtocol
    
    private var residents = [String]()
//    private var residents = ["1", "2", "3"]
    
    init(viewModel: FeedModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(buttonAlert)
        view.addSubview(dismissButton)
        view.addSubview(JSONLabel)
        view.addSubview(JSONCodableLabel)
        view.addSubview(JSONTableView)
        setConstraint()
        presentAlert()
        configure()
        dismiss()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.updateState(viewInput: .initial)
        viewModel.onStateDidChange = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .initial(let title, let titleCodable, let arrayResident):
                // вот здесь никак не хочет отрабатывать данный код, чтобы сразу был title отображен
                DispatchQueue.main.async {
                    guard let title, let titleCodable, let arrayResident else { return }
                    self.JSONLabel.text = title
                    self.JSONCodableLabel.text = titleCodable
                    self.residents = arrayResident
                    self.JSONTableView.reloadData()
                }
            case .loading:
                ()
            case .loaded:
                ()
            }
        }
    }
    
    private func configure() {
        
        dismissButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        dismissButton.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        dismissButton.tintColor = .black
        
        JSONLabel.translatesAutoresizingMaskIntoConstraints = false
        JSONLabel.textColor = .black
        
        JSONCodableLabel.translatesAutoresizingMaskIntoConstraints = false
        JSONCodableLabel.textColor = .black
        
        JSONTableView.dataSource = self
        JSONTableView.delegate = self
        JSONTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        JSONTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func dismiss() {
        
        dismissButton.addTarget(self, action: #selector(pressDismiss), for: .touchUpInside)
    }
    
    @objc private func pressDismiss() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: buttonAlert
extension InfoViewController {
    
    private func presentAlert() {
        
        buttonAlert.addTarget(self, action: #selector(alert), for: .touchUpInside)
    }
    
    @objc private func alert() {
        
        let alertController = UIAlertController(title: "Add info", message: "write some text", preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "Ok", style: .default) { _ in
            guard let text = alertController.textFields?.first?.text else { return }
            print(text)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(actionOK)
        alertController.addAction(actionCancel)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: constraint
extension InfoViewController {
    
    private func setConstraint() {
        
        NSLayoutConstraint.activate([
            buttonAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonAlert.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150),
            buttonAlert.widthAnchor.constraint(equalToConstant: 100),
            buttonAlert.heightAnchor.constraint(equalToConstant: 50),
        
            JSONLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            JSONLabel.bottomAnchor.constraint(equalTo: JSONCodableLabel.topAnchor),
            
            JSONCodableLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            JSONCodableLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            
            JSONTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            JSONTableView.bottomAnchor.constraint(equalTo: buttonAlert.topAnchor, constant: -50),
            JSONTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            JSONTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
    }
}

// MARK: tableview
extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        residents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = residents[indexPath.row]
        return cell
    }
    
}
