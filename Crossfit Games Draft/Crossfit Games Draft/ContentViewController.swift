//
//  ContentView.swift
//  Crossfit Games Draft
//
//  Created by Tracey Bernstein on 4/2/26.
//

import SwiftUI
import UIKit


class DetailViewContoller: UIViewController {
    init (imageURL: URL, name: String, division: String, score: Int ){
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        Task {
            @MainActor in
            if let data = try? Data(contentsOf: imageURL) {
                image.image = UIImage(data: data)
            }
        }
        //THIS HANDLES THE WAY THE MODAL VIEW LOOKS.
        let nameLabel = UILabel()
        nameLabel.text = "name: \(name)"
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.numberOfLines = 0
        nameLabel.frame = CGRect(x: 100, y: 100, width: 80, height: 60)
        
        let divisionLabel = UILabel()
        nameLabel.text = "division: \(division)"
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.numberOfLines = 0
        nameLabel.frame = CGRect(x: 100, y: 100, width: 80, height: 60)
        
        let scoreLabel = UILabel()
        nameLabel.text = "score: \(score)"
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.numberOfLines = 0
        nameLabel.frame = CGRect(x: 100, y: 100, width: 80, height: 60)
        
        let stack = UIStackView(arrangedSubviews: [image, nameLabel, divisionLabel, scoreLabel])
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack) // ADDS VIEW WE CREATED ONTO THE SCREEN
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: 200),
            image.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




#Preview {
    ContentView()
}
