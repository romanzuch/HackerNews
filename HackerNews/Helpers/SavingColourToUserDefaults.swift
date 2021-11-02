//
//  SavingColourToUserDefaults.swift
//  HackerNews
//
//  Created by Roman on 02.11.21.
//

import Foundation
import UIKit
import SwiftUI

extension Numeric {
    var data: Data {
        var bytes = self
        return Data(bytes: &bytes, count: MemoryLayout<Self>.size)
    }
}

extension Data {
    func object<T>() -> T { withUnsafeBytes{$0.load(as: T.self)} }
    var color: UIColor { .init(data: self) }
}

extension UIColor {
    convenience init(data: Data) {
        let size = MemoryLayout<CGFloat>.size
        self.init(red:   data.subdata(in: size*0..<size*1).object(),
                  green: data.subdata(in: size*1..<size*2).object(),
                  blue:  data.subdata(in: size*2..<size*3).object(),
                  alpha: data.subdata(in: size*3..<size*4).object())
    }
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var (red, green, blue, alpha): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        return getRed(&red, green: &green, blue: &blue, alpha: &alpha) ?
        (red, green, blue, alpha) : nil
    }
    var data: Data? {
        guard let rgba = rgba else { return nil }
        return rgba.red.data + rgba.green.data + rgba.blue.data + rgba.alpha.data
    }
}

extension UserDefaults {
    func set(_ color: UIColor?, forKey defaultName: String) {
        guard let data = color?.data else {
            removeObject(forKey: defaultName)
            return
        }
        set(data, forKey: defaultName)
    }
    func color(forKey defaultName: String) -> UIColor? {
        data(forKey: defaultName)?.color
    }
}

extension UserDefaults {
    var backgroundColor: UIColor? {
        get { color(forKey: "backgroundColor") }
        set { set(newValue, forKey: "backgroundColor") }
    }
    var highlightColor: UIColor? {
        get { color(forKey: "highlightColor") }
        set { set(newValue, forKey: "highlightColor") }
    }
}
