//
//  DetailViewController.swift
//  CryptoRates
//
//  Created by Admin on 29/04/2020.
//

import Foundation
import UIKit
import MaterialComponents.MaterialAppBar
import Charts
import SDWebImage

class DetailViewController: UIViewController, UIScrollViewDelegate {
    private var historicalProvider: Provider?
    private var appBar: MDCAppBar?
    private var dataForChart: [Cached]?

    private let priceChartView : ChartView = {
       let priceChartView = ChartView(frame: CGRect())
       priceChartView.chartDescription?.enabled = false
        priceChartView.rightAxis.enabled = false
        priceChartView.legend.enabled = false
        priceChartView.isUserInteractionEnabled = false
       priceChartView.translatesAutoresizingMaskIntoConstraints = false
       return priceChartView
    }()
    
    private let logoImageContainerView : UIView = {
        let logoImageContainerView = UIView()
        //logoImageContainerView.backgroundColor = .yellow
        logoImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageContainerView
    }()
    
    private let logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFit
        return logoImageView
    }()
    
    private let imageActivityIndicator : UIActivityIndicatorView = {
        let imageActivityIndicator = UIActivityIndicatorView()
        imageActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        imageActivityIndicator.startAnimating()
        imageActivityIndicator.isHidden = false
        return imageActivityIndicator
    }()

    private let nameLabelContainerView : UIView = {
        let labelContainerView = UIView()
       // labelContainerView.backgroundColor = .gray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
       // label.backgroundColor = .red
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let fullNameLabelContainerView : UIView = {
        let labelContainerView = UIView()
      //  labelContainerView.backgroundColor = .lightGray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .red
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let lastUpdateLabelContainerView : UIView = {
        let labelContainerView = UIView()
        //labelContainerView.backgroundColor = .lightGray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let lastUpdateLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .red
        
        label.text = "Last update"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let lastUpdateValueContainerView : UIView = {
        let labelContainerView = UIView()
       // labelContainerView.backgroundColor = .gray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let lastUpdateValue: UILabel = {
        let label = UILabel()
       // label.backgroundColor = .yellow
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let priceLabelContainerView : UIView = {
        let labelContainerView = UIView()
       // labelContainerView.backgroundColor = .gray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
       // label.backgroundColor = .yellow
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let priceValueContainerView : UIView = {
        let labelContainerView = UIView()
        //labelContainerView.backgroundColor = .lightGray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let priceValue: UILabel = {
        let label = UILabel()
       // label.backgroundColor = .yellow
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let changePctLabelContainerView : UIView = {
        let labelContainerView = UIView()
       // labelContainerView.backgroundColor = .lightGray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let changePctLabel: UILabel = {
        let label = UILabel()
      //  label.backgroundColor = .yellow
        
        label.text = "Change percentage"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let changePctValueContainerView : UIView = {
        let labelContainerView = UIView()
      //  labelContainerView.backgroundColor = .gray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let changePctValue: UILabel = {
        let label = UILabel()
      //  label.backgroundColor = .yellow
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let supplyLabelContainerView : UIView = {
        let labelContainerView = UIView()
      //  labelContainerView.backgroundColor = .gray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let supplyLabel: UILabel = {
        let label = UILabel()
     //   label.backgroundColor = .yellow
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let supplyValueContainerView : UIView = {
        let labelContainerView = UIView()
    //    labelContainerView.backgroundColor = .lightGray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let supplyValue: UILabel = {
        let label = UILabel()
    //    label.backgroundColor = .yellow
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let marketCapLabelContainerView : UIView = {
        let labelContainerView = UIView()
     //   labelContainerView.backgroundColor = .lightGray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let marketCapLabel: UILabel = {
        let label = UILabel()
     //   label.backgroundColor = .yellow
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let marketCapValueContainerView : UIView = {
        let labelContainerView = UIView()
    //    labelContainerView.backgroundColor = .gray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let marketCapValue: UILabel = {
        let label = UILabel()
     //   label.backgroundColor = .yellow
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let volume24HLabelContainerView : UIView = {
        let labelContainerView = UIView()
   //     labelContainerView.backgroundColor = .gray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let volume24HLabel: UILabel = {
        let label = UILabel()
    //    label.backgroundColor = .yellow
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let volume24HValueContainerView : UIView = {
        let labelContainerView = UIView()
   //     labelContainerView.backgroundColor = .lightGray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let volume24HValue: UILabel = {
        let label = UILabel()
 //       label.backgroundColor = .yellow
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let totalVolumeLabelContainerView : UIView = {
        let labelContainerView = UIView()
  //      labelContainerView.backgroundColor = .lightGray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let totalVolumeLabel: UILabel = {
        let label = UILabel()
  //      label.backgroundColor = .yellow
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let totalVolumeValueContainerView : UIView = {
        let labelContainerView = UIView()
 //       labelContainerView.backgroundColor = .gray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let totalVlolumeValue: UILabel = {
        let label = UILabel()
  //      label.backgroundColor = .yellow
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let open24HLabelContainerView : UIView = {
        let labelContainerView = UIView()
//        labelContainerView.backgroundColor = .gray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let open24HLabel: UILabel = {
        let label = UILabel()
  //      label.backgroundColor = .yellow
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let open24HValueContainerView : UIView = {
        let labelContainerView = UIView()
 //       labelContainerView.backgroundColor = .lightGray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let open24HValue: UILabel = {
        let label = UILabel()
   //     label.backgroundColor = .yellow
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let high24HLabelContainerView : UIView = {
        let labelContainerView = UIView()
 //       labelContainerView.backgroundColor = .lightGray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let high24HLabel: UILabel = {
        let label = UILabel()
 //       label.backgroundColor = .yellow
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let high24HValueContainerView : UIView = {
        let labelContainerView = UIView()
  //      labelContainerView.backgroundColor = .gray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let high24HValue: UILabel = {
        let label = UILabel()
 //       label.backgroundColor = .yellow
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let low24HLabelContainerView : UIView = {
        let labelContainerView = UIView()
//        labelContainerView.backgroundColor = .gray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let low24HLabel: UILabel = {
        let label = UILabel()
  //      label.backgroundColor = .yellow
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let low24HValueContainerView : UIView = {
        let labelContainerView = UIView()
  //      labelContainerView.backgroundColor = .lightGray
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return labelContainerView
    }()
    
    private let low24HValue: UILabel = {
        let label = UILabel()
  //      label.backgroundColor = .yellow
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let gradientView: GradientView = {
        let view = GradientView()
        view.layer.cornerRadius = 10;
        view.layer.masksToBounds = true
        return view
    }()
    
    private let detailView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let items = ["Year", "Month", "Week"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentTintColor = UIColor(red: 255/255.0, green: 170/255.0, blue: 104/255.0, alpha: 1.0)
        let unselectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        control.setTitleTextAttributes(unselectedTextAttributes, for: .normal)
        control.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        control.layer.masksToBounds = true
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(handleSegmentedControlValueChanged(_:)), for: .valueChanged)
        return control
    }()
    
    @objc func handleSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        
        configureChartData()
    
    }
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        appBar = MDCAppBar()
        if let appBar = appBar {
            addChild(appBar.headerViewController)
            appBar.headerViewController.headerView.backgroundColor = .clear
            appBar.navigationBar.tintColor = .white
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }
    
  
    
    
    @objc func receivedHistoricalData() {
        
                dataForChart = historicalProvider?.getDataFromDatabase()
                configureChartData()
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureConstraints()
        configureAppBar()
        dataForChart = historicalProvider?.getDataFromDatabase()
        configureChartData()
        self.view.backgroundColor = .clear
        NotificationCenter.default.addObserver(self, selector: #selector(receivedHistoricalData), name: NotificationConstants.notificationHist, object: nil)
        if let symbol = nameLabel.text {
            if symbol != "" {
                historicalProvider = ProviderFactory.getProvider(type: .HistoricalProvider, symbol: symbol)
            }
        }
        configureLabelFonts()
    }
    
    private func configureLabelFonts() {
        let screenFrameWidth = view.frame.width

        nameLabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/15)
        fullNameLabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/15)
        lastUpdateLabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/15)
        lastUpdateLabel.textColor = .gray
        lastUpdateValue.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/15)
        priceLabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/17)
        priceLabel.textColor = .gray
        priceValue.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/16)
        changePctLabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/15)
        changePctLabel.textColor = .gray
        changePctValue.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/15)
        supplyLabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/17)
        supplyLabel.textColor = .gray
        supplyValue.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/16)
        marketCapLabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/15)
        marketCapLabel.textColor = .gray
        marketCapValue.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/16)
        volume24HLabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/15)
        volume24HLabel.textColor = .gray
        volume24HValue.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/15)
        totalVolumeLabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/15)
        totalVolumeLabel.textColor = .gray
        totalVlolumeValue.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/15)
        open24HLabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/15)
        open24HLabel.textColor = .gray
        open24HValue.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/15)
        high24HLabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/15)
        high24HLabel.textColor = .gray
        high24HValue.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/15)
        low24HLabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/15)
        low24HLabel.textColor = .gray
        low24HValue.font = UIFont(name: FontsConstants.proximaNovaRegular, size: screenFrameWidth/15)
    }
    
    private func configureChartData() {
        
        if let dataForChart = dataForChart {
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                setChartData(historcalData: dataForChart)
            case 1:
                let monthData = Array(dataForChart[dataForChart.endIndex - 31 ..< dataForChart.endIndex])
                setChartData(historcalData: monthData)
            case 2:
                let weekData = Array(dataForChart[dataForChart.endIndex - 8 ..< dataForChart.endIndex])
                setChartData(historcalData: weekData)
            default:
                setChartData(historcalData: dataForChart)
            }
        }
    }
    
    fileprivate func configureAppBar() {
        if let appBar = appBar {
            appBar.addSubviewsToParent()
            let backButton = UIBarButtonItem(title:"",
                                             style:.done,
                                             target:self,
                                             action:#selector(dismissDetails))
            let backImage = MDCIcons.imageFor_ic_arrow_back()
            backButton.image = backImage
            appBar.navigationBar.leftBarButtonItem = backButton
        }
    }
    
    func setChartData(historcalData: [Cached]) {
        var values = [ChartDataEntry]()
        for value in historcalData {
            if let historicalDatum = value as? HistoricalDatumCached {
                let x = Double(historicalDatum.time)
                let y = Double(historicalDatum.close)
                values.append(ChartDataEntry(x: x, y: y))
            }
        }
        priceChartView.setData(values: values)
    }
    
    public func populateView(imageURL:String, name:String, fullName:String, lastUpdate:String, fromSymbol:String, toSymbol:String, priceUSD:String, volume24Hour:String, volume24HourTo:String, open24Hour:String, high24Hour:String, low24Hour:String, changepct24Hour:String, supply:String, marketCapUSD:String, totalVolume24Hour:String, totalVolume24HourTo:String) {
        
        if let unwrappedURL = URL(string: "https://www.cryptocompare.com\(imageURL)") {
            logoImageView.sd_setImage(with: unwrappedURL) { (image, error, SDImageCacheType, URL) in
                if let image = image {
                    self.logoImageView.image = image
                }
                if let error = error {
                    print(error)
                }
                self.imageActivityIndicator.stopAnimating()
                self.imageActivityIndicator.isHidden = true
            }
        }
        
        nameLabel.text = name
        fullNameLabel.text = fullName
        lastUpdateValue.text = lastUpdate
        priceValue.text = priceUSD
        priceLabel.text = "Price (\(toSymbol))"
        changePctValue.text = "\(changepct24Hour)%"
        supplyValue.text = supply
        supplyLabel.text = "Supply (\(fromSymbol))"
        marketCapValue.text = marketCapUSD
        marketCapLabel.text = "Market cap. (\(toSymbol))"
        volume24HValue.text = "\(volume24Hour) /\n\(volume24HourTo)"
        volume24HLabel.text = "Volume 24h (\(fromSymbol) / \(toSymbol))"
        totalVlolumeValue.text = "\(totalVolume24Hour) / \(totalVolume24HourTo)"
        totalVolumeLabel.text = "Total volume (\(fromSymbol) / \(toSymbol))"
        open24HValue.text = open24Hour
        open24HLabel.text = "Opening price 24h (\(toSymbol))"
        high24HValue.text = high24Hour
        high24HLabel.text = "Highest price 24h (\(toSymbol))"
        low24HValue.text = low24Hour
        low24HLabel.text = "Lowest price 24h (\(toSymbol))"
    }
    
    @objc func dismissDetails() {
      dismiss(animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0.0
    }
    
    fileprivate func configureConstraints() {
        self.view.addSubview(detailView)
        detailView.fillSuperview()
        
        detailView.addSubview(gradientView)
        gradientView.anchor(top: detailView.topAnchor, leading: detailView.leadingAnchor, bottom: nil, trailing: detailView.trailingAnchor, constraintsToSuperview: CGSize(width: 0, height: 0.675))
        
        detailView.addSubview(logoImageContainerView)
        logoImageContainerView.anchor(top: detailView.topAnchor, leading: detailView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 0, left: view.frame.width * 0.12, bottom: 0, right: 0), constraintsToSuperview: CGSize(width: 0.35, height: 0.2))
        
        logoImageContainerView.addSubview(logoImageView)
        logoImageView.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        logoImageView.addSubview(imageActivityIndicator)
        imageActivityIndicator.centerInSuperview(constraintsToSuperview: CGSize(width: 0.5, height: 0.5))
        
        detailView.addSubview(nameLabelContainerView)
        nameLabelContainerView.anchor(top: detailView.topAnchor, leading: logoImageContainerView.trailingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.53, height: 0.1))
        
        nameLabelContainerView.addSubview(nameLabel)
        nameLabel.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        detailView.addSubview(fullNameLabelContainerView)
        fullNameLabelContainerView.anchor(top: nameLabelContainerView.bottomAnchor, leading: logoImageContainerView.trailingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.53, height: 0.1))
        
        fullNameLabelContainerView.addSubview(fullNameLabel)
        fullNameLabel.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        detailView.addSubview(priceChartView)
        priceChartView.anchor(top: logoImageContainerView.bottomAnchor, leading: detailView.leadingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 1, height: 0.4))
        
        detailView.addSubview(segmentedControl)
        segmentedControl.anchor(top: priceChartView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0), constraintsToSuperview: CGSize(width: 0.5, height: 0.05))
        segmentedControl.centerXAnchor.constraint(equalTo: detailView.centerXAnchor).isActive = true
        
        detailView.addSubview(lastUpdateLabelContainerView)
        lastUpdateLabelContainerView.anchor(top: segmentedControl.bottomAnchor, leading: detailView.leadingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.4, height: 0.1))
        
        lastUpdateLabelContainerView.addSubview(lastUpdateLabel)
        lastUpdateLabel.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        detailView.addSubview(lastUpdateValueContainerView)
        lastUpdateValueContainerView.anchor(top: segmentedControl.bottomAnchor, leading: lastUpdateLabelContainerView.trailingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.6, height: 0.1))
        
        lastUpdateValueContainerView.addSubview(lastUpdateValue)
        lastUpdateValue.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        detailView.addSubview(priceLabelContainerView)
        priceLabelContainerView.anchor(top: lastUpdateLabelContainerView.bottomAnchor, leading: detailView.leadingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.4, height: 0.1))
        
        priceLabelContainerView.addSubview(priceLabel)
        priceLabel.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        detailView.addSubview(priceValueContainerView)
        priceValueContainerView.anchor(top: lastUpdateValueContainerView.bottomAnchor, leading: priceLabelContainerView.trailingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.6, height: 0.1))
        
        priceValueContainerView.addSubview(priceValue)
        priceValue.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        detailView.addSubview(changePctLabelContainerView)
        changePctLabelContainerView.anchor(top: priceLabelContainerView.bottomAnchor, leading: detailView.leadingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.4, height: 0.1))
        
        changePctLabelContainerView.addSubview(changePctLabel)
        changePctLabel.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        detailView.addSubview(changePctValueContainerView)
        changePctValueContainerView.anchor(top: priceValueContainerView.bottomAnchor, leading: changePctLabelContainerView.trailingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.6, height: 0.1))
        
        changePctValueContainerView.addSubview(changePctValue)
        changePctValue.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        detailView.addSubview(supplyLabelContainerView)
        supplyLabelContainerView.anchor(top: changePctLabelContainerView.bottomAnchor, leading: detailView.leadingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.4, height: 0.1))
        
        supplyLabelContainerView.addSubview(supplyLabel)
        supplyLabel.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        detailView.addSubview(supplyValueContainerView)
        supplyValueContainerView.anchor(top: changePctValueContainerView.bottomAnchor, leading: supplyLabelContainerView.trailingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.6, height: 0.1))
        
        supplyValueContainerView.addSubview(supplyValue)
        supplyValue.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        detailView.addSubview(marketCapLabelContainerView)
        marketCapLabelContainerView.anchor(top: supplyLabelContainerView.bottomAnchor, leading: detailView.leadingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.4, height: 0.1))
        
        marketCapLabelContainerView.addSubview(marketCapLabel)
        marketCapLabel.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        detailView.addSubview(marketCapValueContainerView)
        marketCapValueContainerView.anchor(top: supplyValueContainerView.bottomAnchor, leading: marketCapLabelContainerView.trailingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.6, height: 0.1))
        
        marketCapValueContainerView.addSubview(marketCapValue)
        marketCapValue.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        detailView.addSubview(volume24HLabelContainerView)
        volume24HLabelContainerView.anchor(top: marketCapLabelContainerView.bottomAnchor, leading: detailView.leadingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.4, height: 0.1))
        
        volume24HLabelContainerView.addSubview(volume24HLabel)
        volume24HLabel.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        detailView.addSubview(volume24HValueContainerView)
        volume24HValueContainerView.anchor(top: marketCapValueContainerView.bottomAnchor, leading: volume24HLabelContainerView.trailingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.6, height: 0.1))
        
        volume24HValueContainerView.addSubview(volume24HValue)
        volume24HValue.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        detailView.addSubview(totalVolumeLabelContainerView)
        totalVolumeLabelContainerView.anchor(top: volume24HLabelContainerView.bottomAnchor, leading: detailView.leadingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.4, height: 0.1))
        
        totalVolumeLabelContainerView.addSubview(totalVolumeLabel)
        totalVolumeLabel.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        detailView.addSubview(totalVolumeValueContainerView)
        totalVolumeValueContainerView.anchor(top: volume24HValueContainerView.bottomAnchor, leading: totalVolumeLabelContainerView.trailingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.6, height: 0.1))
        
        totalVolumeValueContainerView.addSubview(totalVlolumeValue)
        totalVlolumeValue.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        detailView.addSubview(open24HLabelContainerView)
        open24HLabelContainerView.anchor(top: totalVolumeLabelContainerView.bottomAnchor, leading: detailView.leadingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.4, height: 0.1))
        
        open24HLabelContainerView.addSubview(open24HLabel)
        open24HLabel.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        detailView.addSubview(open24HValueContainerView)
        open24HValueContainerView.anchor(top: totalVolumeValueContainerView.bottomAnchor, leading: open24HLabelContainerView.trailingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.6, height: 0.1))
        
        open24HValueContainerView.addSubview(open24HValue)
        open24HValue.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        detailView.addSubview(high24HLabelContainerView)
        high24HLabelContainerView.anchor(top: open24HLabelContainerView.bottomAnchor, leading: detailView.leadingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.4, height: 0.1))
        
        high24HLabelContainerView.addSubview(high24HLabel)
        high24HLabel.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        detailView.addSubview(high24HValueContainerView)
        high24HValueContainerView.anchor(top: open24HValueContainerView.bottomAnchor, leading: high24HLabelContainerView.trailingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.6, height: 0.1))
        
        high24HValueContainerView.addSubview(high24HValue)
        high24HValue.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        detailView.addSubview(low24HLabelContainerView)
        low24HLabelContainerView.anchor(top: high24HLabelContainerView.bottomAnchor, leading: detailView.leadingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.4, height: 0.1))
        low24HLabelContainerView.bottomAnchor.constraint(equalTo: detailView.bottomAnchor).isActive = true
        
        low24HLabelContainerView.addSubview(low24HLabel)
        low24HLabel.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        detailView.addSubview(low24HValueContainerView)
        low24HValueContainerView.anchor(top: high24HValueContainerView.bottomAnchor, leading: low24HLabelContainerView.trailingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.6, height: 0.1))
        low24HValueContainerView.rightAnchor.constraint(equalTo: detailView.rightAnchor).isActive = true
        
        low24HValueContainerView.addSubview(low24HValue)
        low24HValue.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
    }
}

