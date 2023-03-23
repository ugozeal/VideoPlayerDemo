//
//  String+Utility.swift
//  VideoPlayerDemo
//
//  Created by David Okonkwo on 23/03/2023.
//

import Foundation

extension String {
    var asUrl: URL? {
        URL(string: self)
    }
}
