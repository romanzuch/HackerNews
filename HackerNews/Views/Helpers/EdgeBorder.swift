//
//  EdgeBorder.swift
//  HackerNews
//
//  Created by Roman on 12.10.21.
//

import Foundation
import SwiftUI
import UIKit

struct EdgeBorder: Shape {

    var width: CGFloat
    var edges: [Edge]
    var padding: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading:
                    switch padding {
                    case let x where x < 0: return rect.minX + padding
                    case let x where x > 0: return rect.minX - padding
                    default: return rect.minX
                    }
                case .trailing:
                    switch padding {
                    case let x where x < 0: return rect.maxX - width + padding
                    case let x where x > 0: return rect.maxX - width - padding
                    default: return rect.maxX - width
                    }
                }
            }

            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }

            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return self.width
                }
            }

            var h: CGFloat {
                switch edge {
                case .top, .bottom: return self.width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: Color, padding: CGFloat) -> some View {
        overlay(EdgeBorder(width: width, edges: edges, padding: padding).foregroundColor(color))
    }
}
