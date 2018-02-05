//
//  mapCell.swift
//  iOSAuth
//
//  Created by 吴宇飞 on 2018/1/29.
//  Copyright © 2018年 Aran. All rights reserved.
//

import UIKit
import MapKit
class mapCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(text:String)  {
        let loginState = UILabel()
        loginState.text = text
        if text == "登录成功" {
            loginState.textColor = UIColor.green
        }
        else
        {
            loginState.textColor = UIColor.red
        }
        loginState.textAlignment = .center
        loginState.font = UIFont.systemFont(ofSize: 30)
        self.contentView.addSubview(loginState)
        
        let mapView = MKMapView()
        mapView.mapType = .standard
        
        mapView.backgroundColor = UIColor.orange
        self.contentView.addSubview(mapView)
        
        let title = UILabel()
        title.text = "mapView"
        title.textAlignment = .center
        title.textColor = UIColor.white
        
        let location = CLLocationCoordinate2D(latitude: 114.41, longitude: 30.46)
        var span = MKCoordinateSpan()
        span.latitudeDelta = 0.01
        span.longitudeDelta = 0.01
        let region = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
        

        title.font = UIFont.systemFont(ofSize: 30)
        mapView.addSubview(title)
        
        
        loginState.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.size.equalTo(CGSize(width: UIScreen.main.bounds.size.width, height: 40))
        }
        
        mapView.snp.makeConstraints { (make) in
            make.top.equalTo(loginState.snp.bottom).offset(0)
            make.left.equalTo(0)
            make.size.equalTo(CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-64-155))
        }
        
        title.snp.makeConstraints { (make) in
            make.centerX.equalTo(mapView.snp.centerX);
            make.centerY.equalTo(mapView.snp.centerY);
            make.size.equalTo(CGSize(width: 200, height: 40))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
