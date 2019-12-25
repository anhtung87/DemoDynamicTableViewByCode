//
//  DefaultDynamicTableView.swift
//  DynamicTableViewByCode
//
//  Created by Hoang Tung on 12/25/19.
//  Copyright © 2019 Hoang Tung. All rights reserved.
//

import UIKit

class DefaultDynamicTableView: UIViewController {
    
    var languages: [ProgrammingLanguage]?
    
    let dynamicTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let sortByYearButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sort by Year", for: .normal)
        button.backgroundColor = .systemPink
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let sortByNameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sort by Name", for: .normal)
        button.backgroundColor = .systemIndigo
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.systemTeal, for: .selected)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Default Dynamic"
        
        view.addSubview(dynamicTableView)
        view.addSubview(sortByYearButton)
        view.addSubview(sortByNameButton)
        
        setData()
        setupLayout()
        configTable()
        sortByYearButton.addTarget(self, action: #selector(sortByYear), for: .touchUpInside)
        sortByNameButton.addTarget(self, action: #selector(sortByName), for: .touchUpInside)
    }

    func setupLayout() {
        dynamicTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        dynamicTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        dynamicTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        dynamicTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        sortByYearButton.topAnchor.constraint(equalTo: dynamicTableView.bottomAnchor, constant: 16).isActive = true
        sortByYearButton.leadingAnchor.constraint(equalTo: dynamicTableView.centerXAnchor, constant: 20).isActive = true
        sortByYearButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
        sortByYearButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        sortByNameButton.topAnchor.constraint(equalTo: dynamicTableView.bottomAnchor, constant: 16).isActive = true
        sortByNameButton.trailingAnchor.constraint(equalTo: dynamicTableView.centerXAnchor, constant: -20).isActive = true
        sortByNameButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
        sortByNameButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configTable() {
        dynamicTableView.delegate = self
        dynamicTableView.dataSource = self
    }
    
    func setData() {
        languages = [
            ProgrammingLanguage(name: "Python", yearOfBirth: 1990, imageName: "python"),
//            ProgrammingLanguage(name: "Golang", yearOfBirth: 2009, imageName: "golang"),
            ProgrammingLanguage(name: "Elixir", yearOfBirth: 2011, imageName: "elixir"),
            ProgrammingLanguage(name: "Java", yearOfBirth: 1995, imageName: "java"),
            ProgrammingLanguage(name: "Javascript", yearOfBirth: 1995, imageName: "javascript"),
            ProgrammingLanguage(name: "Rust", yearOfBirth: 2010, imageName: "rust"),
            ProgrammingLanguage(name: "Swift", yearOfBirth: 2014, imageName: "swift"),
        ]
    }
    
    @objc func sortByYear() {
        languages?.sort(by: { $0.yearOfBirth < $1.yearOfBirth })
        dynamicTableView.reloadData()
    }
    
    @objc func sortByName() {
        languages?.sort(by: { $0.name < $1.name })
        dynamicTableView.reloadData()
    }

}

extension DefaultDynamicTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.maxY / 15
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Programming Languages"
        }
        return ""
    }
}

extension DefaultDynamicTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        cell = dynamicTableView.dequeueReusableCell(withIdentifier: "id")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "id")
        }
        cell?.textLabel?.text = languages![indexPath.row].name
        cell?.imageView?.image = UIImage(named: languages![indexPath.row].imageName)
        cell?.imageView?.contentMode = .scaleAspectFit
        cell?.detailTextLabel?.text = String(languages![indexPath.row].yearOfBirth)
        return cell!
    }
}
