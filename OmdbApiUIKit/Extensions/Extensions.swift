//
//  Extensions.swift
//  OmdbApiUIKit
//
//  Created by Mohd Kashif on 16/07/24.
//

import Foundation

extension String{
    var urlEncode:String?{
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
