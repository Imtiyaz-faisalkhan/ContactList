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
    var SelectContact :Contact?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
            guard let detailViewController = segue.destination as? DetailViewController else{
                return
            }
        detailViewController.contact=SelectContact
    }

    func fetchUsers(){
        var request = URLRequest(url: URL(string: "https://randomuser.me/api/?results=50&seed=imtiyaz")!)
        
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

    func getImage(url : URL) -> UIImage{
        let data: Data = try! Data(contentsOf: url)
        return UIImage (data: data) ?? UIImage()
    }
}


extension TableViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Checking for count")
        return 50//ContactArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Viewcell") as? UserTableViewCell else {
                print("error here")
                return UITableViewCell()
            }
            print("no error here")
            if let user = ContactArray?[indexPath.row] {
                let FullName = formatName(contactname: user.name)
                cell.labelName.text = FullName
                cell.labelEmail.text=user.email
                cell.UserImage.image = getImage(url: URL(string : user.picture.thumbnail)!)
                cell.UserImage.layer.cornerRadius = cell.UserImage.frame.height/2
            }
        if indexPath.row % 2==0{
            cell.backgroundColor=#colorLiteral(red: 0.2860352695, green: 0.3415890336, blue: 0.998211205, alpha: 0.8899026113)
        }
        else
        {
            cell.backgroundColor=#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 0.3488067209)
            
        }
            return cell
        }
    
    
    
}




extension TableViewController:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SelectContact = ContactArray![indexPath.row]
        performSegue(withIdentifier: "Connection", sender: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
