//
//  FeedingSchedule.swift
//  iot
//
//  Created by WanSen on 11/12/24.
//

import Foundation

struct FeedingSchedule: Identifiable, Codable {
    var id: String = UUID().uuidString // Unique identifier
    var time: String                   // Time in HH:mm format
}
