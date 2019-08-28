//
//  Result.swift
//  SchoolLink
//
//  Created by Abhishek Pachal on 2/11/19.
//  Copyright © 2019 Abhishek Pachal. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}
