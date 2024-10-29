//
//  WeatherCollectionViewCell.swift
//  MyWeatherApp
//
//  Created by Adam Chen on 2024/10/25.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "WeatherCollectionViewCell"
    
    static func nib() -> UINib {
        UINib(nibName: "WeatherCollectionViewCell", bundle: nil)
    }
    

    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    
    func configure(with model: Hour) {
        dateTimeLabel.text = convertTo12HourFormat(timeString: String(model.datetime))
        weatherImageView.contentMode = .scaleAspectFit
        weatherImageView.image = UIImage(named: model.icon)
        tempLabel.text = "\(model.temp)°"
    }
    
    func convertTo12HourFormat(timeString: String) -> String? {
        // 初始化 DateFormatter
        let dateFormatter = DateFormatter()
        
        // 設置輸入格式為24小時制
        dateFormatter.dateFormat = "HH:mm:ss"
        
        // 將時間字符串轉換為 Date 對象
        guard let date = dateFormatter.date(from: timeString) else {
            return nil // 如果轉換失敗，返回 nil
        }
        
        // 設置輸出格式為12小時制並包含 AM/PM
        dateFormatter.dateFormat = "h:mm a"
        
        // 返回轉換後的時間字符串
        return dateFormatter.string(from: date)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
