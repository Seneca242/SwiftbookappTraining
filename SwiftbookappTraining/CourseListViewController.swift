//
//  ViewController.swift
//  SwiftbookappTraining
//
//  Created by Дмитрий Дмитрий on 15.02.2023.
//

import UIKit

class CourseListViewController: UIViewController {
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .red
        tableView.rowHeight = 43.5
        return tableView
    }()
    
    private var courseCell: CourseCell = {
        let cell = CourseCell()
//        cell.backgroundColor = .blue
        cell.contentMode = .scaleToFill
        return cell
    }()
    
//    private lazy var contentView: UIView = {
//        let contentView = UIView()
//        contentView.backgroundColor = .white
////        contentView.frame.size = contentSize
//        return contentView
//    }()
//
//    private lazy var imageForCell: UIImageView = {
//        var image = UIImageView()
//        image.backgroundColor = .black
//        image.contentMode = .scaleAspectFit
//        return image
//    }()
    
//    private var contentSize: CGSize {
//        CGSize(width: view.frame.width, height: view.frame.height + 200)
//    }
    
    private var activityIndicator: UIActivityIndicatorView?
    private var courses: [Course] = []

    private let cellID = "CourseCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Courses"
        view.backgroundColor = .white
        activityIndicator = showActivityIndicator(in: view)
        tableView.register( CourseCell.self, forCellReuseIdentifier: cellID)
        addSubViews(subViews: tableView)
        tableView.addSubview(courseCell)
//        courseCell.addSubview(contentView)
//        courseCell.addSubview(imageForCell)
        setupConstraints()
        setupNavigationBar()
        getCourses()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func addSubViews(subViews: UIView...) {
        subViews.forEach { subView in
            view.addSubview(subView)
        }
    }
    
    private func getCourses() {
        NetworkManager.shared.fetchData { courses in
            self.courses = courses
            DispatchQueue.main.async {
                self.activityIndicator?.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupNavigationBar() {
        title = "Courses"
        navigationController?.navigationBar.prefersLargeTitles = true

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
//        navigationController?.navigationItem.title = "Courses"
//        title = "Courses"
//        navigationController?.title = "Courses"
//        navigationItem.title = "Courses"
       
    }

    private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        courseCell.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
//            courseCell.widthAnchor.constraint(equalToConstant: 375),
            courseCell.heightAnchor.constraint(equalToConstant: 43.5),
            courseCell.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 50),
            courseCell.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            courseCell.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 0),
            courseCell.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: 0)
        ])
        
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            contentView.topAnchor.constraint(equalTo: courseCell.topAnchor, constant: 50),
//            contentView.leadingAnchor.constraint(equalTo: courseCell.leadingAnchor, constant: 0),
//            contentView.trailingAnchor.constraint(equalTo: courseCell.trailingAnchor, constant: 0)
//        ])
//
//        imageForCell.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            imageForCell.topAnchor.constraint(equalTo: courseCell.topAnchor, constant: 0),
//            imageForCell.leadingAnchor.constraint(equalTo: courseCell.leadingAnchor, constant: 0),
//            imageForCell.widthAnchor.constraint(equalToConstant: 50),
//            imageForCell.heightAnchor.constraint(equalToConstant: 43.5)
//        ])
    }

}

extension CourseListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        guard let cell = cell as? CourseCell else { return UITableViewCell() }
//        cell.textLabel?.numberOfLines = 1
        let course = courses[indexPath.row]
        cell.configure(with: course)
        return cell
    }
}

extension CourseListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let course = courses[indexPath.row]
        let courseDetailsVC = CourseDetailsViewController()
        courseDetailsVC.course = course
        present(courseDetailsVC, animated: true)
    }
}
