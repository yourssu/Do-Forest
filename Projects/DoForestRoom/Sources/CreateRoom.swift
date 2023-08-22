//
//  CreateRoom.swift
//  DoForestRoom
//
//  Created by 정종인 on 2023/08/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import SwiftUI

struct CreateRoom: View {
    struct Room {
        let title: String
        let description: String
    }
    let rooms: [Room] = [
        Room(title: "Custom", description: "직접 방을 커스텀할 수 있어요"),
        Room(title: "Solved.ac", description: "솔브?...이게 뭔데"),
        Room(title: "Github", description: "깃허브어쩌구"),
    ]
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Spacer()
            Text("방 종류를 선택해주세요")
            ForEach(rooms) { room in
                HStack {
                    Text(room.title)
                    Spacer()
                    Text(room.description)
                }
                .frame(height: 70)
                .padding(.horizontal, 24)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .inset(by: 1)
                        .stroke(Color(red: 0.58, green: 0.69, blue: 0.62), lineWidth: 2)
                }
            }
            Spacer()
            Spacer()
            HStack {
                Spacer()
                Button {
                    print("개설하기")
                } label: {
                    Text("개설하기")
                        .frame(width: 292, height: 48)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 0.16, green: 0.58, blue: 0.24))
                Spacer()
            }

        }
        .padding(16)
        .navigationTitle("방 개설하기")
    }
}
extension CreateRoom.Room: Identifiable {
    var id: UUID {
        UUID()
    }
}

struct CreateRoom_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CreateRoom()
        }
    }
}
