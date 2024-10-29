//
//  WeatherTableViewCell.swift
//  MyWeatherApp
//
//  Created by Adam Chen on 2024/10/25.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var precipprobImageView: UIImageView!
    @IBOutlet weak var precipprobLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    static let identifier = "WeatherTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with weatherData: Day) {
        dayLabel.text = getDayOfWeek(from: weatherData.datetime)
        lowTempLabel.text = "\(Int(weatherData.tempmin))°"
        highTempLabel.text = "\(Int(weatherData.tempmax))°"
        precipprobLabel.text = "\(Int(weatherData.precipprob))%"
        weatherImageView.image = UIImage(named: weatherData.icon)
        precipprobImageView.image = UIImage(named: "precipprob")
    }
    
    func getDayOfWeek(from dateString: String) -> String? {
        // 设置日期格式
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // 将日期字符串转换为 Date 对象
        guard let date = dateFormatter.date(from: dateString) else {
            return nil // 如果日期转换失败，返回 nil
        }
        
        // 设置新的格式来获取星期几的全称
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "zh_CN")
        let dayOfWeek = dateFormatter.string(from: date)
        
        return dayOfWeek
    }
    
}
