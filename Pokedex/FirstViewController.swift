//
//  FirstViewController.swift
//  Pokedex
//
//  Created by Dennis on 07-04-18.
//  Copyright © 2018 Dennis. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tvPokemons: UITableView!
    let list = ["Franje", "Sjors", "Piet", "Superfrans"]
    var pokemonNames = [String]()
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (pokemonNames.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = pokemonNames[indexPath.row]
        
        return (cell!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
        
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!) as! [String: Any]
                let main: Array<AnyObject> = json["results"] as! Array<AnyObject>
                for index in 0...main.count - 1 {
                    let name = main[index]["name"] as! String
                    self.pokemonNames.append(name)
                }
                
                
                
                print(self.pokemonNames)
                
                DispatchQueue.main.async {
                    self.tvPokemons.reloadData()
                }
            } catch {
                
            }
        }
        task.resume()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

