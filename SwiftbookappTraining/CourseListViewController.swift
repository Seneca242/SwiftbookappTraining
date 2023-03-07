//
//  ViewController.swift
//  SwiftbookappTraining
//
//  Created by Дмитрий Дмитрий on 15.02.2023.
//

import UIKit

class CourseListViewController: UITableViewController {
    
    private var activityIndicator: UIActivityIndicatorView?
    private var courses: [Course] = []

    private let cellID = "CourseCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Courses"
        view.backgroundColor = .white
        tableView.backgroundColor = .red
        tableView.rowHeight = 43.5
        activityIndicator = showActivityIndicator(in: view)
        tableView.register( CourseCell.self, forCellReuseIdentifier: cellID)
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
        
        navigationController?.navigationBar.tintColor = .white
        
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
}

extension CourseListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        guard let cell = cell as? CourseCell else { return UITableViewCell() }
        let course = courses[indexPath.row]
        cell.configure(with: course)
        return cell
    }
}

extension CourseListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let course = courses[indexPath.row]
        let courseDetailsVC = CourseDetailsViewController()
        courseDetailsVC.modalPresentationStyle = .fullScreen
        courseDetailsVC.course = course
//        present(courseDetailsVC, animated: true)
        navigationController?.pushViewController(courseDetailsVC, animated: true)
    }
}
