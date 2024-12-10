//
//  AddFeedingView.swift
//  iot
//
//  Created by WanSen on 10/12/24.
//
import SwiftUI

struct AddFeedingScheduleView: View {
    @Binding var feedingSchedule: [String]
    @Environment(\.dismiss) var dismiss
    @State private var selectedTime = Date() // State for selected time

    var body: some View {
        NavigationView {
            VStack {
                Text("Pilih Jadwal Pakan")
                    .font(.headline)
                    .padding(.top)

                // Time Picker for selecting hours and minutes
                DatePicker(
                    "Jam dan Menit",
                    selection: $selectedTime,
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden() // Hides label for cleaner UI
                .padding()

                Button(action: {
                    // Format and add the selected time to the schedule
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm"
                    let timeString = formatter.string(from: selectedTime)
                    feedingSchedule.append(timeString) // Add new schedule
                    dismiss() // Dismiss the sheet
                }) {
                    Text("Tambah")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(Color.green)
                        .cornerRadius(8)
                        .padding()
                }
                Spacer()
            }
            .navigationTitle("Tambah Jadwal Pakan")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Batal") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddFeedingScheduleView(feedingSchedule: .constant(["07:00", "12:00", "17:00"]))
}

