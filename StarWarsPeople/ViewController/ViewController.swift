//
//  ViewController.swift
//  StarWarsPeople
//
//  Created by Adonis Rumbwere on 13/10/2021.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    var activityView: UIActivityIndicatorView?
    private var personDetails = [Result]()
    
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
    
    func showActivityIndicator() {
       activityView = UIActivityIndicatorView(style: .large)
        activityView!.center = self.view.center
        self.view.addSubview(activityView!)
        activityView!.startAnimating()
    }
    
    func hideActivityIndicator(){
        if ( activityView != nil){
            activityView?.stopAnimating()
        }
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
        showActivityIndicator()
        APICaller.shared.getStarWarsPeople { [weak self] result in
            switch result {
                case .success(let people):
                    self?.viewModels = people.compactMap({
                        PeopleTableViewCellViewModel(
                            name: $0.name!
                        )
                        
                    })
                    
                    people.forEach { details in
                        self?.personDetails.append(Result(name: details.name, height: details.height, mass: details.mass, hair_color: details.hair_color, skin_color: details.skin_color, eye_color: details.eye_color, birth_year: details.birth_year, gender: details.gender, homeworld: details.homeworld))
                    }
                    
                    DispatchQueue.main.async {
                        self!.hideActivityIndicator()
                        self?.tableView.reloadData()
                        
                    }
                    
                case .failure(let error):
                    print(error)
                    self!.hideActivityIndicator()
                    
            }
        }
        
    }
    
    // Search star wars people by name
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showActivityIndicator()
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
                        self!.hideActivityIndicator()
                        self?.tableView.reloadData()
                        self?.searchVC.dismiss(animated: true, completion: nil)

                    }
                case .failure( let error):
                    print(error)
                    self!.hideActivityIndicator()
                    
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
        
        let selectedPerson = personDetails[indexPath.row]
        
        if let viewController = UIStoryboard(name: "PeopleDetails", bundle: nil).instantiateViewController(identifier: "PeopleViewController") as? PeopleViewController {
         viewController.personInfo = selectedPerson
                navigationController?.pushViewController(viewController, animated: true)
            }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
}
