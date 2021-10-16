//
//  PeopleTableViewCellViewModel.swift
//  StarWarsPeople
//
//  Created by Adonis Rumbwere on 16/10/2021.
//

import Foundation



struct PeopleTableViewCellViewModel {
    // a class as oppossed to a struct because we want to modify stuff in there
    // class are reference types
    
    let name: String
    init (name: String){
        self.name = name
    }
    
}
