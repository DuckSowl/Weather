//
//  String+.swift
//  Weather
//
//  Created by Anton Tolstov on 22.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

extension String {
    func firstIndex(of aString: String) -> Int? {
        self.range(of: aString)?.lowerBound.utf16Offset(in: self)
    }
}
