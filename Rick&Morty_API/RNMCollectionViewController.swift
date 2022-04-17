//
//  RNMCollectionViewController.swift
//  Rick&Morty_API
//
//  Created by Adam Khalifa on 15.04.2022.
//

import UIKit

class RNMCollectionViewController: UICollectionViewController {
    
    var results: [Character] = []
    
    let url = "https://rickandmortyapi.com/api/character"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Rick and Morty"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        fetchData()
        collectionView.register(RNMCell.self, forCellWithReuseIdentifier: RNMCell.identifier)
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "details", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? DetailsViewController {
            let indexPath = sender as! IndexPath
            destination.name = results[indexPath.row].name
            destination.type = results[indexPath.row].species
            destination.gender = results[indexPath.row].gender
            destination.location = "📍\(results[indexPath.row].location.name)"
            
            let url = URL(string: results[indexPath.row].image)!
            
            if let data = try? Data(contentsOf: url) {
                destination.img = UIImage(data: data)!
            }
            destination.number = "\(results[indexPath.row].episode.count)"
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RNMCell.identifier, for: indexPath) as! RNMCell
        
        let profile = results[indexPath.row]
        
        // Configure the cell
        cell.setup(with: profile)
        cell.contentView.backgroundColor = .systemTeal
        return cell
    }
}

extension RNMCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
}

extension RNMCollectionViewController {
    
    func fetchData() {
        guard let url = URL(string: url) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.results = jsonResult.results
                    print(jsonResult)
                    self?.collectionView.reloadData()
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}
