//
//  ViewModel.swift
//  Bank App
//
//  Created by Aline do Amaral on 17/03/23.
//

import UIKit

protocol ViewModelDelegate {
    func successData(_ data: [Occupancy]?)
    func errorData(error: Error)
}

class ViewModel {
    
    var delegate: ViewModelDelegate?
    private let endPoint = "https://630e1bf2109c16b9abf4db0b.mockapi.io/servicebff"
    
    func viewDidLoad() {
        getOptions()
    }
    
    private func getOptions() {
        if let url: URL = URL(string: endPoint) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.errorData(error: error!)
                    print("something went wrong")
                    return
                }
                if let safeData = data {
                    let occupancy = self.parseOccupancy(safeData)
                    self.delegate?.successData(occupancy)
                }
            }
            task.resume()
        }
    }
    
    private func parseOccupancy(_ occupancyData: Data) -> [Occupancy]? {
            let decoder = JSONDecoder()
            do {
                let decoderData = try decoder.decode([Occupancy].self, from: occupancyData)
                return decoderData
            } catch {
                self.delegate?.errorData(error: error)
                return nil
            }
        }

private func setLabel(string: String) {
    
}
}
