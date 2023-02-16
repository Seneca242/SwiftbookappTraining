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
        label.font = UIFont(name: "Arial", size: 14)
        label.text = course.name
        return label
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
    
    private lazy var favouriteButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    
    
    var course: Course!
    
    private var isFavourite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews(to: courseNameLabel, numberOfLessonsLabel, numberOfTestsLabel, courseImage, favouriteButton)
//        loadFavouriteStatus()
//        setupUI()

       
    }
    

    private func addSubviews(to views: UIView...) {
        views.forEach { subView in
            view.addSubview(subView)
        }
    }
  
}
