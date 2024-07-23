//
//  ContentView.swift
//  Split Bills
//
//  Created by Jesutofunmi Adewole on 12/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercent = 10
    @FocusState private var isFocused: Bool
    
    var individualBill: Double {
        (((Double(tipPercent)/100) * billAmount) + billAmount) / Double(numberOfPeople)
    }
    
    var totalBill: Double {
        ((Double(tipPercent)/100) * billAmount) + billAmount
    }
    
    let tipOption = [0, 5, 10, 15, 20]
    
    var body: some View {
        NavigationStack {
            Form {
                Section ("How much is the bill you want to split?") {
                    TextField("Amount", value: $billAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                }
                Section ("How many people are splitting the bill?") {
                    TextField("Number of people to split bill between", value: $numberOfPeople, format: .number)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                }
                
                Section ("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercent) {
                        ForEach (tipOption, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
//                        ForEach (0..<101) {
//                            Text($0, format: .percent)
//                        }
//                    }
//                    .pickerStyle(.navigationLink)
                }
                
                Section ("Amount per person") {
                    Text(individualBill, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        
                }
                
                Section ("Total amount payable") {
                    Text(totalBill, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercent == 0 ? .red: .black)
                }
            }
            .navigationTitle("Split Bills")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if isFocused {
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
