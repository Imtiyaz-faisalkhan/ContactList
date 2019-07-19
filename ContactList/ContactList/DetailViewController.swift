//
//  DetailViewController.swift
//  ContactList
//
//  Created by Faisal Khan on 18/07/2019.
//  Copyright © 2019 Faisal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var contact: Contact?
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var labelStreet: UILabel!
    @IBOutlet weak var labelCity: UILabel!
    
    @IBOutlet weak var UIimage: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadContact()
    }
    func formatName(contactname: ContactName) -> String {
        return contactname.title.capitalized + " " + contactname.first.capitalized + " " + contactname.last.uppercased()
    }
    
    
    
    func loadContact() {
        let name=formatName(contactname: contact!.name)
        labelName.text = name
        labelEmail.text = contact?.email
        labelPhone.text = contact?.phone
        labelCell.text = contact?.cell
        labelStreet.text = contact?.location.street
        labelCity.text = contact?.location.city
        setImage(url: URL(string: (contact?.picture.large)!)!)
    }
    
    func setImage(url:URL)
    {
        let data:Data=try! Data(contentsOf:url)
        UIimage.image=UIImage(data:data)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
