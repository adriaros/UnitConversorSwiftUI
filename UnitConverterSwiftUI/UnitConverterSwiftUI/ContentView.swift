//
//  ContentView.swift
//  UnitConverterSwiftUI
//
//  Created by Adrià Ros on 14/3/21.
//

/*
 
 Your challenge
 You need to build an app that handles unit conversions: users will select an input unit and an output unit, then enter a value, and see the output of the conversion.

 Which units you choose are down to you, but you could choose one of these:

 - Temperature conversion: users choose Celsius, Fahrenheit, or Kelvin.
 - Length conversion: users choose meters, kilometers, feet, yards, or miles.
 - Time conversion: users choose seconds, minutes, hours, or days.
 - Volume conversion: users choose milliliters, liters, cups, pints, or gallons.
 
 If you were going for length conversion you might have:

 - A segmented control for meters, kilometers, feet, yard, or miles, for the input unit.
 - A second segmented control for meters, kilometers, feet, yard, or miles, for the output unit.
 - A text field where users enter a number.
 - A text view showing the result of the conversion.
 
 So, if you chose meters for source unit and feet for output unit, then entered 10, you’d see 32.81 as the output.
 
 */

import SwiftUI

/// The types of temperatures
enum TemperatureType: String, CaseIterable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
}

struct ContentView: View {
    
    /// The initial value of the temperature
    @State private var temperature = "0"
    
    /// The initial index of the input temperature type (celsius)
    @State private var inputTemperatureTypeIndex = 0
    
    /// The initial index of the output temperature type (fahrenheit)
    @State private var outputTemperatureTypeIndex = 1
    
    /// It returns the current type of the input temperature
    /// - For exemple, ff the user clicks on the first item, the type is "Celsius"
    private var inputTemperatureType: String {
        TemperatureType.allCases[inputTemperatureTypeIndex].rawValue
    }
    
    /// It returns the current type of the output temperature
    /// - For exemple, ff the user clicks on the second item, the type is "Fahrenheit"
    private var outputTemperatureType: String {
        TemperatureType.allCases[outputTemperatureTypeIndex].rawValue
    }
    
    /// We have to change all the temperatures to the same type to be able to operate with them later.
    /// In this case, we pass all the temperatures to Celsius
    private var base: Double {
        switch inputTemperatureType {
        case TemperatureType.fahrenheit.rawValue:
            return ((Double(temperature) ?? 0) - 32) * (5 / 9)
        case TemperatureType.kelvin.rawValue:
            return (Double(temperature) ?? 0) - 273.15
        default:
            return Double(temperature) ?? 0
        }
    }
    
    /// We calculate the result temperature from the "base"  depending on the type
    private var convertedTemperature: Double {
        switch outputTemperatureType {
        case TemperatureType.fahrenheit.rawValue:
            return base * (9 / 5) + 32
        case TemperatureType.kelvin.rawValue:
            return base + 273.15
        default:
            return base
        }
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("Temperature converter. Input data")) {
                    
                    Picker("Input temperature type", selection: $inputTemperatureTypeIndex) {
                        ForEach(0 ..< TemperatureType.allCases.count) {
                            Text("\(TemperatureType.allCases[$0].rawValue)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    TextField("Write here the temperature", text: $temperature)
                        .keyboardType(.decimalPad)
                    
                }.textCase(nil)
                
                Section(header: Text("Temperature converter. Output data")) {
                    
                    Picker("Input temperature type", selection: $outputTemperatureTypeIndex) {
                        ForEach(0 ..< TemperatureType.allCases.count) {
                            Text("\(TemperatureType.allCases[$0].rawValue)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Text("Result: \(convertedTemperature, specifier: "%.2f")")
                    
                }.textCase(nil)
            }
            .navigationBarTitle("Unit Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
