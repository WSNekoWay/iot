//
//  AddFeedingView.swift
//  iot
//
//  Created by WanSen on 10/12/24.
//
import SwiftUI

struct AddFeedingScheduleView: View {
    @ObservedObject var viewModel: FeedingScheduleViewModel
    @Environment(\.dismiss) var dismiss
    @State private var selectedTime = Date()

    var body: some View {
        NavigationView {
            VStack {
                Text("Pilih Jadwal Pakan")
                    .font(.headline)
                    .padding(.top)

                DatePicker(
                    "Jam dan Menit",
                    selection: $selectedTime,
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .padding()

                Button(action: {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm"
                    let timeString = formatter.string(from: selectedTime)
                    viewModel.addFeedingSchedule(time: timeString)
                    dismiss()
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

