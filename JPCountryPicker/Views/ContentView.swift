//
//  ContentView.swift
//  JPCountryPicker
//
//  Created by Jaykar Parmar on 11/07/24.
//

import SwiftUI

/// The main view of the JPCountryPicker app, displaying the selected country's details and allowing the user to change the country.
struct ContentView: View {
    
    /// The list of countries loaded from a JSON file.
    @State private var countries: [Country] = loadJSON(filename: "Countries")
    /// The currently selected country.
    @State private var selectedCountry: Country?
    /// A Boolean state that determines whether the country list view is presented.
    @State var isCountryDisplayed = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Country Flag: \(self.selectedCountry?.flag ?? "")")
                Text("Country Name: \(self.selectedCountry?.name ?? "")")
                Text("Country Code: \(self.selectedCountry?.code ?? "")")
                Text("Country Phone Code: \(self.selectedCountry?.dialCode ?? "")")
            }
            .font(.title2)
            .padding(.horizontal, 16)
            
            Button {
                self.isCountryDisplayed = true
            } label: {
                Text("Change the country")
            }
            Spacer()
        }
        .fullScreenCover(isPresented: $isCountryDisplayed, content: {
            CountryListView(countries: self.countries, selectedCountry: $selectedCountry, isCountryDisplayed: $isCountryDisplayed)
        })
        
        .onAppear(perform: {
            self.setupView()
        })
    }
}

extension ContentView {
    /// Sets up the view by initializing the selected country.
    func setupView() {
        self.selectedCountry = currentCountry(countries: self.countries)
    }
}

#Preview {
    ContentView()
}
