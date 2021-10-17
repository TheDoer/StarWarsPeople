//
//  PeopleViewController.swift
//  StarWarsPeople
//
//  Created by Adonis Rumbwere on 17/10/2021.
//

import UIKit

class PeopleViewController: UIViewController {
    
    var personInfo:Result!
    
    
    
    //@IBOutlet weak var personNameLbl: UILabel!
    
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var massLbl: UILabel!
    @IBOutlet weak var hairColorLbl: UILabel!
    @IBOutlet weak var eyeColorLbl: UILabel!
    @IBOutlet weak var skinColorLbl: UILabel!
    @IBOutlet weak var birthYearLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var homeworldLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }
    
    
    
    func setUpView(){
        
        title = "\(personInfo.name!)'s"
        
        heightLbl.text = "Height: \(personInfo.height!)"
        massLbl.text = "Mass: \(personInfo.mass!)"
        hairColorLbl.text = "Hair Color: \(personInfo.hair_color!)"
        eyeColorLbl.text = "Eye Color: \(personInfo.eye_color!)"
        skinColorLbl.text = "Skin Color: \(personInfo.skin_color!)"
        birthYearLbl.text = "Birth Year: \(personInfo.birth_year!)"
        genderLbl.text = "Gender: \(personInfo.gender!)"
        homeworldLbl.text = "HW: \(personInfo.homeworld!)"
        
    }

    

}
