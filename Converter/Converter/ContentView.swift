//
//  ContentView.swift
//  Converter
//
//  Created by Mirna Olvera on 12/22/23.
//

import SwiftUI

struct ContentView: View {
    @State private var temperature = Measurement(value: 0, unit: UnitTemperature.celsius)
    @State private var currentTemperatureFormat: UnitTemperature = .celsius

    var symbol: String {
        switch currentTemperatureFormat {
        case .celsius:
            return "° C"
        case .fahrenheit:
            return "° F"
        case .kelvin:
            return "° K"
        default:
            return ""
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Temperature Converter") {
                    HStack {
                        TextField("Temperature", value: $temperature.value, format: .number).keyboardType(.decimalPad)
                        Text(symbol)
                    }
                    Picker("Unit Temperature", selection: $currentTemperatureFormat) {
                        Text("Celsius").tag(UnitTemperature.celsius)
                        Text("Fahrenheit").tag(UnitTemperature.fahrenheit)
                        Text("Kelvin").tag(UnitTemperature.kelvin)
                    }
                }

                Section("Converted Temperatures") {
                    Text("\(Measurement(value: temperature.value, unit: currentTemperatureFormat).converted(to: .celsius).value) ° C")

                    Text("\(Measurement(value: temperature.value, unit: currentTemperatureFormat).converted(to: .fahrenheit).value) ° F")

                    Text("\(Measurement(value: temperature.value, unit: currentTemperatureFormat).converted(to: .kelvin).value) ° K")
                }
            }
            .navigationTitle("Converter")
        }
    }
}

#Preview {
    ContentView()
}
