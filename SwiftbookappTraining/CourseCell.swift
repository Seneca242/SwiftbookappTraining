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
//        guard let imageData = ImageManager.shared.fetchImageData(from: course.imageUrl) else { return }
        guard let url = course.imageUrl else { return }
        ImageManager.shared.fetchImage(from: url) { data, response in
            content.image = UIImage(data: data)
            self.contentConfiguration = content
        }
//        content.image = UIImage(data: imageData)
//        contentConfiguration = content
        contentConfiguration = content
    }
    
}
