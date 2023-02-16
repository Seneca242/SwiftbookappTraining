//
//  ViewController.swift
//  SwiftbookappTraining
//
//  Created by Дмитрий Дмитрий on 15.02.2023.
//

import UIKit

class CourseListViewController: UIViewController {
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .red
        tableView.rowHeight = 30
        return tableView
    }()
    
    var courseCell: CourseCell = {
        let cell = CourseCell()
        cell.backgroundColor = .blue
        return cell
    }()
    
    private var activityIndicator: UIActivityIndicatorView?
    private var courses: [Course] = []

    private let cellID = "CourseCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        activityIndicator = showActivityIndicator(in: view)
        tableView.register( CourseCell.self, forCellReuseIdentifier: cellID)
        addSubViews(subViews: tableView)
        tableView.addSubview(courseCell)
        setupConstraints()
        getCourses()
//        tableView.delegate = self
//        tableView.dataSource = self
        
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
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
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
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
//            tableView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        courseCell.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            courseCell.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 50),
            courseCell.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 0),
            courseCell.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: 0)
        ])
    }

}

extension CourseListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        guard let cell = cell as? CourseCell else { return UITableViewCell() }
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
