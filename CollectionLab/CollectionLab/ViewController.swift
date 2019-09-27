//
//  ViewController.swift
//  CollectionLab
//
//  Created by EricM on 9/26/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var countries = [Country](){
        didSet{
            self.collectionOutlet.reloadData()
        }
    }
    @IBOutlet weak var collectionOutlet: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchString: String? = nil
    var countrySearchResults: [Country]{
        guard let _ = searchString else{
            return countries
        }
        guard searchString != "" else {
            return countries
        }
        let results = countries.filter{$0.name.lowercased().contains(searchString!.lowercased())}
        return results
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchString = searchBar.text
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countrySearchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let location = countrySearchResults[indexPath.row]
        if let cell = collectionOutlet.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? CountryCollectionViewCell {
            //cell.image1
            cell.name.text = location.name
            cell.capital.text = location.capital
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        collectionOutlet.dataSource = self
        collectionOutlet.delegate = self
        // Do any additional setup after loading the view.
    }
    
    private func loadData() {
        StuffAPIClient.manager.getCountry{ (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let place):
                    self.countries = place
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

