//
//  ViewController.swift
//  StarWarsPeople
//
//  Created by Adonis Rumbwere on 13/10/2021.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(PeopleTableViewCell.self,
                       forCellReuseIdentifier: PeopleTableViewCell.identifier)
        
        
        return table
    }()
    private let searchVC = UISearchController(searchResultsController: nil)
    private var viewModels = [PeopleTableViewCellViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        
        starWarsPeopleList()
        createSearchBar()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func createSearchBar(){
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    
    //function to populate star wars people on the table view
    func starWarsPeopleList(){
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
    
    // Search star wars people by name
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        APICaller.shared.searchWithName(with: text) { [weak self] result in
            switch result {
                case .success(let people):
                    
                    self?.viewModels = people.compactMap({ PeopleTableViewCellViewModel(name: $0.name!
                    )
                })
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        self?.searchVC.dismiss(animated: true, completion: nil)

                    }
                case .failure( let error):
                    print(error)
                    
            }
        }
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        return 100
    }
    
}
