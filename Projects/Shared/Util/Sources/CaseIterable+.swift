//
//  CaseIterable+.swift
//  Util
//
//  Created by 정종인 on 10/2/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import Foundation

public extension CaseIterable where Self: Equatable {
    func previous() -> Self {
        let all = Self.allCases
        var idx = all.firstIndex(of: self)!
        if idx == all.startIndex {
            let lastIndex = all.index(all.endIndex, offsetBy: -1)
            return all[lastIndex]
        } else {
            all.formIndex(&idx, offsetBy: -1)
            return all[idx]
        }
    }

    func next() -> Self {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let next = all.index(after: idx)
        return all[next == all.endIndex ? all.startIndex : next]
    }
}
