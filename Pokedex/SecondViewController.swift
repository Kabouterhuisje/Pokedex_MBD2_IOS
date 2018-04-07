//
//  SecondViewController.swift
//  Pokedex
//
//  Created by Dennis on 07-04-18.
//  Copyright © 2018 Dennis. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tvFavorites: UITableView!
    var favoriteList = [String]()
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (favoriteList.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        
        let object = favoriteList[indexPath.row]
        cell.textLabel!.text = object.description
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewLoadSetup()
    }
    
    
    func viewLoadSetup(){
        let defaults = UserDefaults.standard
        
        if let stringOne = defaults.array(forKey: defaultsKeys.pkName) {
            favoriteList = stringOne as! [String]
        }
        DispatchQueue.main.async{
            self.tvFavorites.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

