//
//  FeedingScheduleViewModel.swift
//  iot
//
//  Created by WanSen on 11/12/24.
//

import SwiftUI
import FirebaseFirestore

class FeedingScheduleViewModel: ObservableObject {
    @Published var feedingSchedules: [FeedingSchedule] = [] // Stores the list of schedules
    private let db = Firestore.firestore()
    private let collectionName = "feedingSchedules"

    init() {
        fetchFeedingSchedules()
    }

    // Fetch data from Firestore
    func fetchFeedingSchedules() {
        db.collection(collectionName).addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            self.feedingSchedules = documents.compactMap { doc -> FeedingSchedule? in
                try? doc.data(as: FeedingSchedule.self) // Decode Firestore document
            }
        }
    }

    // Add a new feeding schedule
    func addFeedingSchedule(time: String) {
        let newSchedule = FeedingSchedule(time: time)
        do {
            try db.collection(collectionName).document(newSchedule.id).setData(from: newSchedule)
        } catch {
            print("Error adding schedule: \(error.localizedDescription)")
        }
    }

    // Delete a feeding schedule
    func deleteFeedingSchedule(schedule: FeedingSchedule) {
        db.collection(collectionName).document(schedule.id).delete { error in
            if let error = error {
                print("Error deleting schedule: \(error.localizedDescription)")
            }
        }
    }

    // Update an existing feeding schedule
    func updateFeedingSchedule(schedule: FeedingSchedule, newTime: String) {
        db.collection(collectionName).document(schedule.id).updateData(["time": newTime]) { error in
            if let error = error {
                print("Error updating schedule: \(error.localizedDescription)")
            }
        }
    }
}
