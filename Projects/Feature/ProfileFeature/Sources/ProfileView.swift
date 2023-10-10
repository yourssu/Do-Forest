//
//  ProfileView.swift
//  ProfileFeature
//
//  Created by 정종인 on 10/9/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import SwiftUI
import ProfileFeatureInterface
import ComposableArchitecture

struct ProfileView: View {
    public init(store: StoreOf<Profile>) {
        self.store = store
    }
    public let store: StoreOf<Profile>
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            
        }
    }
}
