//
//  RNMCollectionViewController.swift
//  Rick&Morty_API
//
//  Created by Adam Khalifa on 15.04.2022.
//

import UIKit

class RNMCollectionViewController: UICollectionViewController {

    let networker = NetworkManager.shared
    
    var results: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        networker.getCharacters(query: "") { [weak self] posts, error in
          if let error = error {
            print("error", error)
            return
          }

          self?.results = posts!
          DispatchQueue.main.async {
            self?.collectionView.reloadData()
          }
        }
        
        self.title = "Rick and Morty"
        navigationController?.navigationBar.prefersLargeTitles = true
        
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

        cell.profileImageView.image = nil

        let representedIdentifier = profile.id

        cell.representedId = representedIdentifier

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

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath)
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = collectionView.contentOffset.y
        if position > (collectionView.contentSize.height-100-scrollView.frame.size.height) {
            print("more data")
        }
    }

}
