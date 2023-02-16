//
//  CourseCellViewController.swift
//  SwiftbookappTraining
//
//  Created by Дмитрий Дмитрий on 15.02.2023.
//

import UIKit

class CourseCell: UITableViewCell {
    func configure(with course: Course) {
        var content = defaultContentConfiguration()
        content.text = course.name
        guard let imageData = ImageManager.shared.fetchImageData(from: course.imageUrl) else { return }
        content.image = UIImage(data: imageData)
        contentConfiguration = content
    }
}
