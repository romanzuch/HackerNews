//
//  ActivityViewController.swift
//  HackerNews
//
//  Created by Roman on 12.10.21.
//

import Foundation
import UIKit

struct ShareViewController {
    func share(_ title: String, urlString: String) {
        guard let urlShare = URL(string: urlString) else { return }
        let shareString = "\(title): \(urlShare)"
        let activityVC = UIActivityViewController(activityItems: [shareString], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
}
