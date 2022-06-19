//
//  ContentView.swift
//  WeSplit
//
//  Created by Hugo Silva on 18/06/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    let tipPercentages = [0, 5, 10, 15, 20, 25]
    var totalPerPerson: Double {
        // calculate the total per person here
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let amountPerPerson = checkAmount * (1 + tipSelection/100) / peopleCount
        return amountPerPerson
    }
    var totalForCheck : Double {
        let tipSelection = Double(tipPercentage)
        let totalForCheck = checkAmount * (1 + tipSelection/100)
        return totalForCheck
    }
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format:
                            .currency(code: Locale.current.currencyCode ?? "BRL"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    Text(totalForCheck, format: .currency(code: Locale.current.currencyCode ?? "BRL"))
                } header: {
                    Text("Total amount for the check")
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "BRL"))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
