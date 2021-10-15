//
//  ViewController.swift
//  StarWarsPeople
//
//  Created by Adonis Rumbwere on 13/10/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(PeopleTableViewCell.self,
                       forCellReuseIdentifier: PeopleTableViewCell.identifier)
        
        
        return table
    }()
    
    private var viewModels = [PeopleTableViewCellViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        APICaller.shared.getStarWarsPeople { [weak self] result in
            switch result {
                case .success(let people):
                    self?.viewModels = people.compactMap({
                        PeopleTableViewCellViewModel(
                            name: $0.name!
                        )
                    })
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                    
                case .failure(let error):
                    print(error)
                    
            }
        }
    
      
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PeopleTableViewCell.identifier,
            for: indexPath
        ) as? PeopleTableViewCell else {
            fatalError()
        }
        
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    


}

