//
//  barChartCell.swift
//  iOSAuth
//
//  Created by 吴宇飞 on 2018/1/29.
//  Copyright © 2018年 Aran. All rights reserved.
//

import UIKit
import Charts
class barChartCell: UITableViewCell {

    let barchartV = BarChartView(frame: CGRect(x: 10, y: 0, width: UIScreen.main.bounds.size.width, height: 240))
    var data:BarChartData?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configBarChart(yData:[Double]) {
        
        barchartV.delegate = self as? ChartViewDelegate
        self.contentView.addSubview(barchartV)
        
        //基本样式
        barchartV.backgroundColor = UIColor(red: 230.0/255, green: 253.0/255, blue: 253.0/255, alpha: 1)
        barchartV.noDataText = "暂无数据"
        barchartV.drawValueAboveBarEnabled = true
        barchartV.drawBarShadowEnabled = false
        
        //交互设置
        barchartV.scaleYEnabled = false
        barchartV.doubleTapToZoomEnabled = false
        barchartV.dragEnabled = true
        barchartV.dragDecelerationEnabled = true
        barchartV.dragDecelerationFrictionCoef = 0.9
        
        //x轴样式
        let xa = barchartV.xAxis
        xa.valueFormatter = self as? IAxisValueFormatter
        xa.axisLineWidth = 1
        xa.labelPosition = .bottom
        xa.drawGridLinesEnabled = false //x轴的网格样式
        xa.labelWidth = 15
        xa.labelTextColor = UIColor.brown
        
        //y轴样式
        barchartV.rightAxis.enabled = false
        
        let leftax = barchartV.leftAxis
        leftax.forceLabelsEnabled = false
        
        //根据最大值、最小值、和等分数量设置Y值数据
        leftax.axisMinimum = 0
        //leftax.axisMaximum = 100
        leftax.labelCount = 5
        leftax.inverted = false
        leftax.axisLineWidth = 0.5
        leftax.axisLineColor = UIColor.black
        //        let number:NumberFormatter = leftax.valueFormatter as! NumberFormatter
        //        number.positiveSuffix = " %"
        leftax.labelPosition = .outsideChart
        leftax.labelTextColor = UIColor.brown
        leftax.labelFont = UIFont.systemFont(ofSize: 10)
        
        //设置虚线样式的网络格
        leftax.gridLineDashLengths = [3.0,3.0]
        leftax.gridColor = UIColor(red: 200.0/255, green: 200.0/255, blue: 200.0/255, alpha: 1)
        leftax.gridAntialiasEnabled = true //开启锯齿
        barchartV.chartDescription?.text = ""
        
        barchartV.data = setData(ydata: yData)
        barchartV.animate(yAxisDuration: 1.0)
    }
    
    func setData(ydata:[Double]) -> BarChartData {
        
    
        let xDataArr = ["登录成功","登录失败","异地登录"]
        
        
        //y轴数据
        var ydataArr:[Any] = Array()
        for index in ydata.enumerated() {
            let entry = BarChartDataEntry(x: Double(index.offset), y: index.element)
            ydataArr.append(entry)
            
        }
        
        barchartV.xAxis.valueFormatter = IndexAxisValueFormatter(values: xDataArr )
        
        //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
        let set1 = BarChartDataSet(values: ydataArr as? [ChartDataEntry], label: nil)
        set1.barBorderWidth = 0.2
        set1.drawValuesEnabled = true
        set1.highlightEnabled = true
        //set1.setColor(UIColor.green)
        set1.setColors(UIColor.green,UIColor.gray,UIColor.red)
        let dataSets = [set1]
        
        //创建barChartData对象
        let data:BarChartData = BarChartData(dataSets: dataSets)
        data.barWidth = 0.4
        data.setValueFont(NSUIFont(name: "HelveticaNeue-Light", size: 10))
        data.setValueTextColor(NSUIColor.orange)
        
        return data
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
