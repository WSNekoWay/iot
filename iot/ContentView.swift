//
//  ContentView.swift
//  iot
//
//  Created by WanSen on 10/12/24.
//
import SwiftUI
import FirebaseCore
struct ContentView: View {
    @StateObject private var viewModel = FeedingScheduleViewModel()
    @State private var showAddSheet = false // State for showing the sheet

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Kontrol Tambak")
                    .font(.system(size: 28))
                    .fontWeight(.bold)
            }

            HStack(spacing: 20) {
                VStack {
                    Text("Suhu")
                        .font(.headline)
                    Text("28°C")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity)

                VStack {
                    Text("pH")
                        .font(.headline)
                    Text("7.5")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Jadwal Pakan")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        if viewModel.feedingSchedules.count < 10 {
                            showAddSheet = true
                        }
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .padding(8)
                            .background(viewModel.feedingSchedules.count < 10 ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    .disabled(viewModel.feedingSchedules.count >= 10)
                }

                if viewModel.feedingSchedules.isEmpty {
                    Text("Belum Ada Jadwal Otomatis Pemberian Pakan")
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                } else {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(viewModel.feedingSchedules) { schedule in
                            HStack {
                                Text(schedule.time)
                                    .font(.title3)
                                    .padding(.vertical, 8)
                                Spacer()
                                Button(action: {
                                    viewModel.deleteFeedingSchedule(schedule: schedule)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                        .padding(8)
                                        .background(Color(.systemGray6))
                                        .clipShape(Circle())
                                }
                            }
                            .padding(.horizontal)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        }
                    }
                    .padding(.top, 10)
                }
            }
            .padding(.horizontal)

            Spacer()

            HStack {
                Spacer()
                Button(action: {
                    print("Kasih Makan button pressed")
                }) {
                    Text("Kasih Makan")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 150, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                Spacer()
            }
        }
        .padding()
        .sheet(isPresented: $showAddSheet) {
            AddFeedingScheduleView(viewModel: viewModel)
        }
    }
}


#Preview {
    ContentView()
}
