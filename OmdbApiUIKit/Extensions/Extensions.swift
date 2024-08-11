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
    
    func timeHour()->String{
        let trimMinPart=self.replacingOccurrences(of: " min", with: "")
        guard let timeInMinutes=Int(trimMinPart) else {return ""}
        let hour=timeInMinutes/60
        let min=timeInMinutes%60
        return "\(hour)h \(min)min"
    }
}

