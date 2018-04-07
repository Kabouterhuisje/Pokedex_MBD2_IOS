//
//  DetailsViewController.swift
//  Pokedex
//
//  Created by Dennis on 07-04-18.
//  Copyright © 2018 Dennis. All rights reserved.
//
import UIKit

struct defaultsKeys {
    static let pkName = "pkName"
}
class DetailsViewController: UIViewController {

    var pokemonName: String?
    var favoritePokemons = [String]()
    
    @IBOutlet weak var lblPokemonName: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/" + pokemonName! + "/")!
        
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!) as! [String: Any]
                let pkName: String = json["name"] as! String
                let pkHeight: Int = json["height"] as! Int
                let pkWeight: Int = json["weight"] as! Int
                
                print(pkHeight)
                DispatchQueue.main.async {
                    self.lblPokemonName.text = pkName
                    self.lblHeight.text = "\(pkHeight)"
                    self.lblWeight.text = "\(pkWeight)"
                }
            } catch {
                
            }
        }
        task.resume()
        
        let defaults = UserDefaults.standard
        if let stringOne = defaults.array(forKey: defaultsKeys.pkName) {
            for favoritePokemon in stringOne {
                if favoritePokemon as? String == pokemonName {
                    btnFavorite.isHidden = true
                }
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addToFavorites(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        
        if let stringOne = defaults.array(forKey: defaultsKeys.pkName) {
            for favoritePokemon in stringOne {
                favoritePokemons.append(favoritePokemon as! String)
            }
    
        }
        
        favoritePokemons.append(pokemonName!)
        defaults.set(favoritePokemons, forKey: defaultsKeys.pkName)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
