//
//  ContentView.swift
//  WeSplit
//
//  Created by Joel Groomer on 6/5/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var orderAmount: Double {
        return Double(checkAmount) ?? 0.0
    }
    
    var tipAmount: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        return orderAmount * tipSelection / 100
    }
    
    var grandTotal: Double {
        return orderAmount + tipAmount
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2) // picker is off by 2
        return grandTotal / peopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Text("Tip amount: $\(tipAmount, specifier: "%.2f")")
                    Text("Total with tip: $\(grandTotal, specifier: "%.2f")")
                }
                
                Section(header: Text("Total due per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
