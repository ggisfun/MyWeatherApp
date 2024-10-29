//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Adam Chen on 2024/10/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var currentTemoLabel: UILabel!
    @IBOutlet weak var currentWeatherImageView: UIImageView!
    @IBOutlet weak var precipprobLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let cities: [String: String] = [
        "台北市": "Taipei City",
        "新北市": "New Taipei City",
        "桃園市": "Taoyuan City",
        "台中市": "Taichung City",
        "台南市": "Tainan City",
        "高雄市": "Kaohsiung City",
        "基隆市": "Keelung City",
        "新竹市": "Hsinchu City",
        "嘉義市": "Chiayi City",
        "新竹縣": "Hsinchu County",
        "苗栗縣": "Miaoli County",
        "彰化縣": "Changhua County",
        "南投縣": "Nantou County",
        "雲林縣": "Yunlin County",
        "嘉義縣": "Chiayi County",
        "屏東縣": "Pingtung County",
        "宜蘭縣": "Yilan County",
        "花蓮縣": "Hualien County",
        "台東縣": "Taitung County",
        "澎湖縣": "Penghu County",
        "金門縣": "Kinmen County",
        "連江縣": "Lienchiang County"
    ]
    var weatherData = [Day]()
    var hourlyData = [Hour]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        tableView.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.gradientBegin.cgColor, UIColor.gradientEnd.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        let cityMenu = UIMenu(title: "請選擇區域", options: .displayInline, children: createMenuActions())
        cityButton.menu = cityMenu
        cityButton.showsMenuAsPrimaryAction = true
        
        callWeatherAPI(city: "Taipei")
    }
    
    // 建立按鈕選單
    func createMenuActions() -> [UIAction] {
        var actions: [UIAction] = []
        let sortedCities = cities.sorted { $0.key < $1.key }
        for city in sortedCities {
            let action = UIAction(title: city.key, handler: { _ in
                self.cityButton.setTitle("當前區域: \(city.key)", for: .normal)
                self.callWeatherAPI(city: city.value)
            })
            actions.append(action)
        }
        return actions
    }
    
    func callWeatherAPI(city: String) {
        WeatherService.shared.fetchWeatherData(for: city) { result in
            switch result {
            case .success(let weatherResponse):
                self.weatherData = weatherResponse.days
                self.hourlyData = weatherResponse.days.first!.hours
                let currentWeatherData: CurrentConditions = weatherResponse.currentConditions
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.currentTemoLabel.text = "\(Int(currentWeatherData.temp))°"
                    self.precipprobLabel.text = "\(Int(currentWeatherData.precipprob)) %"
                    self.windSpeedLabel.text = "\(Int(currentWeatherData.windspeed)) km/h"
                    self.currentWeatherImageView.image = UIImage(named: currentWeatherData.icon)
                }
            case .failure(let error):
                print("Error fetching weather data: \(error)")
            }
        }
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return weatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as! HourlyTableViewCell
            cell.configure(with: hourlyData)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        cell.configure(with: weatherData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        }
        return 80
    }
    
}
