
import Charts
import UIKit

class ChartView: LineChartView {

    // MARK: - LineChartView

    fileprivate func setupAxes() {
        setupLeftAxis()
        setupXAxis()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupNoData()
        setupAxes()
        
        
        
    }

    // MARK: - Public

    func setData(values: [ChartDataEntry]) {
        let line = self.line(values: values)

        let data = LineChartData()
        data.addDataSet(line)

        self.data = data
        setupAxes()
        self.animate(xAxisDuration: 1.0)
    }

    // MARK: - Private

    private func line(values: [ChartDataEntry]) -> LineChartDataSet {
        let color = UIColor.white
        let line = LineChartDataSet(entries: values, label: nil)

        line.setColor(color)
        line.setCircleColor(color)
        line.lineWidth = 3
        line.drawCirclesEnabled = false
        line.drawValuesEnabled = false

        return line
    }

    private func setupNoData() {
        noDataFont = UIFont.systemFont(ofSize: 20)
        noDataTextColor = UIColor.white
        noDataText = "No chart data available."
    }

    private func setupLeftAxis() {
        setupAxis(leftAxis)
        leftAxis.labelFont = UIFont.systemFont(ofSize: 10)

        leftAxis.valueFormatter = DefaultAxisValueFormatter.with(block: { value, _ -> String in
            return Float(value).toCurrencyString(fractionDigits: 0)
        })
    }

    private func setupXAxis() {
        setupAxis(xAxis)
        xAxis.labelPosition = .bottom
        xAxis.labelFont = UIFont.systemFont(ofSize: 9)

        xAxis.valueFormatter = DefaultAxisValueFormatter.with(block: { value, _ -> String in
            let dateFormat = "yy-MM-dd"
            return Date(timeIntervalSince1970: value).toString(dateFormat: dateFormat)
        })
    }

    private func setupAxis(_ axis: AxisBase) {
        axis.gridColor = UIColor.lightGray
        axis.labelTextColor = UIColor.white
        axis.axisLineColor = UIColor.clear
    }

}

