//
//  CourseDetailsViewController.swift
//  SwiftbookappTraining
//
//  Created by Дмитрий Дмитрий on 15.02.2023.
//

import UIKit

class CourseDetailsViewController: UIViewController {
    
    private lazy var courseNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Menlo Regular", size: 23)
        label.text = course.name
        label.textAlignment = .center
        return label
    }()
    
    private lazy var favouriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(toggleFavourite), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var numberOfLessonsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 14)
        label.text = "Number of lessons: \(course.numberOfLessons)"
        return label
    }()
    
    private lazy var numberOfTestsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 14)
        label.text = "Number of tests: \(course.numberOfTests)"
        return label
    }()
    
    private lazy var courseImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    var course: Course!
    
    private var isFavourite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews(to: courseNameLabel, courseImage, favouriteButton, stackView)
        addSubviewsToStackView(subviews: numberOfLessonsLabel, numberOfTestsLabel)
        loadFavouriteStatus()
        setupUI()
        setupConstraints()
    }

    private func addSubviews(to views: UIView...) {
        views.forEach { subView in
            view.addSubview(subView)
        }
    }
    
    private func addSubviewsToStackView(subviews: UIView...) {
        subviews.forEach { subview in
            stackView.addArrangedSubview(subview)
        }
    }
    
    @objc private func toggleFavourite() {
        isFavourite.toggle()
        setStatusForFavouriteButton()
        DataManager.shared.setFavoriteStatus(for: course.name, with: isFavourite)
    }
    
    private func setupUI() {
        courseNameLabel.text = course.name
        numberOfLessonsLabel.text = "Number of lessons: \(course.numberOfLessons)"
        numberOfTestsLabel.text = "Number of tests: \(course.numberOfTests)"
        
        guard let url = course.imageUrl else { return }
        ImageManager.shared.fetchImage(from: url) { data, response in
            self.courseImage.image = UIImage(data: data)
        }
        
        setStatusForFavouriteButton()
    }
    
    private func setStatusForFavouriteButton() {
        favouriteButton.tintColor = isFavourite ? .red : .gray
    }
    
    private func loadFavouriteStatus() {
        isFavourite = DataManager.shared.getFavoriteStatus(for: course.name)
    }
    
    private func setupConstraints() {
        courseNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            courseNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 39),
            courseNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            courseNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
        
        courseImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            courseImage.topAnchor.constraint(equalTo: courseNameLabel.bottomAnchor, constant: 27),
            courseImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            courseImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            courseImage.heightAnchor.constraint(equalToConstant: 203)
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: courseImage.bottomAnchor, constant: 48),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 34),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -34)
        ])
        
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favouriteButton.trailingAnchor.constraint(equalTo: courseImage.trailingAnchor, constant: 10),
            favouriteButton.bottomAnchor.constraint(equalTo: courseImage.bottomAnchor, constant: -10),
            favouriteButton.heightAnchor.constraint(equalToConstant: 40),
            favouriteButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        favouriteButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favouriteButton.imageView?.leadingAnchor.constraint(equalTo: favouriteButton.leadingAnchor),
            favouriteButton.imageView?.trailingAnchor.constraint(equalTo: favouriteButton.trailingAnchor),
            favouriteButton.imageView?.topAnchor.constraint(equalTo: favouriteButton.topAnchor),
            favouriteButton.imageView?.bottomAnchor.constraint(equalTo: favouriteButton.bottomAnchor)
        ].compactMap { $0 })
    }
    
}
