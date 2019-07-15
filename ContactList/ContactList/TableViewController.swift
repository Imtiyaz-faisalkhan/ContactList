//
//  ViewController.swift
//  ContactList
//
//  Created by Faisal Khan on 15/07/2019.
//  Copyright © 2019 Faisal. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var ContactArray:[Contact]?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
        // Do any additional setup after loading the view.
    }

    func fetchUsers(){
        var request = URLRequest(url: URL(string: "https://randomuser.me/api/?results=10")!)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do{
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(ContactInfo.self, from: data!)
                self.ContactArray = responseModel.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print(responseModel)
            } catch let error {
                print("JSON Serialization ERROR: ", error)
            }
            }.resume()
    }
    
    func formatName(contactname: ContactName) -> String {
        return contactname.title.capitalized + " " + contactname.first.capitalized + " " + contactname.last.uppercased()
    }
}

extension TableViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Checking for count")
        return 10//ContactArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Viewcell") as? UserTableViewCell else {
                print("error here")
                return UITableViewCell()
            }
            print("no error here")
            if let user = ContactArray?[indexPath.row] {
                print("INNNNN error here")
                let FullName = formatName(contactname: user.name)
                cell.labelName.text = FullName
                cell.labelEmail.text=user.email
            }
            return cell
        }
    
    
    
}

extension TableViewController:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
