//
//  String.swift
//  GLSimpleDownloadButton
//
//  Created by LeoGeng on 14/03/2017.
//  Copyright © 2017 LeoGeng. All rights reserved.
//

import Foundation

extension String{
    func heightWithConstraint(width:CGFloat,font:UIFont) -> CGFloat {
        let rect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}
