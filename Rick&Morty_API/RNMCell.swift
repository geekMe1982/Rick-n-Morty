//
//  RNMCell.swift
//  Rick&Morty_API
//
//  Created by Adam Khalifa on 15.04.2022.
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

class RNMCell: UICollectionViewCell {

    var representedId: Int?

    let name: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let race: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let gender: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 5.0
        contentView.backgroundColor = .white
        
        contentView.addSubview(name)
        contentView.addSubview(race)
        contentView.addSubview(gender)
        contentView.addSubview(profileImageView)
    }
    
    private func setupLayouts() {
        name.translatesAutoresizingMaskIntoConstraints = false
        race.translatesAutoresizingMaskIntoConstraints = false
        gender.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant:8),
        ])
        
        NSLayoutConstraint.activate([
            race.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            race.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 15),
        ])
        
        NSLayoutConstraint.activate([
            gender.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            gender.topAnchor.constraint(equalTo: race.bottomAnchor, constant: 15),
            
        ])
        
        NSLayoutConstraint.activate([
            profileImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            profileImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with profile: Character) {
        name.text = "Name: \(profile.name)"
        race.text = "Type: \(profile.species)"
        gender.text = "Gender: \(profile.gender)"
        profileImageView.load(profile.image)
    }
}

extension RNMCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIImageView {
    func load(_ urlString: String) {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                guard let url = URL(string: urlString) else {
                    return
                }
                guard let data = try? Data(contentsOf: url) else {
                    return
                }
                self.image = UIImage(data: data)
            }
        }
    }
}
