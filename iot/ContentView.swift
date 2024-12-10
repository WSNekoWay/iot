//
//  ContentView.swift
//  iot
//
//  Created by WanSen on 10/12/24.
//
import SwiftUI

struct ContentView: View {
    @State private var showAddSheet = false // State for showing the sheet
    @State private var feedingSchedule = ["07:00", "12:00", "17:00"] // Only times as schedule
    @State private var suhu = "28°C" // Temperature value
    @State private var ph = "7.5"    // pH value

    var body: some View {
        VStack(spacing: 20) {
            // Suhu and pH View
            
            HStack {
                Text("Kontrol Tambak")
                    .font(.system(size: 28)) // Set a custom font size
                    .fontWeight(.bold)       // Optional: Add weight for emphasis
            }

            HStack(spacing: 20) {
                // Suhu View
                VStack {
                    Text("Suhu")
                        .font(.headline)
                    Text(suhu)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity)
                
                // pH View
                VStack {
                    Text("pH")
                        .font(.headline)
                    Text(ph)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
            
            // Jadwal Pakan View
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Jadwal Pakan")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        if feedingSchedule.count < 10 {
                            showAddSheet = true // Show the sheet
                        }
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .padding(8)
                            .background(feedingSchedule.count < 10 ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    .disabled(feedingSchedule.count >= 10) // Disable the button when the limit is reached
                }
                
                // Check if the list is empty
                if feedingSchedule.isEmpty {
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Text("Belum Ada Jadwal Otomatis Pemberian Pakan")
                                .font(.body)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        Spacer()
                    }
                } else {
                    // Feeding Schedule Items
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(feedingSchedule, id: \.self) { time in
                            HStack {
                                Text(time)
                                    .font(.title3)
                                    .padding(.vertical, 8)
                                Spacer()
                                Button(action: {
                                    if let index = feedingSchedule.firstIndex(of: time) {
                                        feedingSchedule.remove(at: index)
                                    }
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
            
            // Kasih Makan Button
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
            AddFeedingScheduleView(feedingSchedule: $feedingSchedule)
        }
    }
}

#Preview {
    ContentView()
}
