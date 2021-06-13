//
//  CollectionViewCell.swift
//  CryptoRates
//
//  Created by Admin on 19/04/2020.
//

import UIKit
import MaterialComponents.MaterialCards
import SDWebImage

class CryptoRatesCollectionViewCell: MDCCardCollectionCell {
    
    //MARK: - cell content
    let logoImageContainerView : UIView = {
        let logoImageContainerView = UIView()
        logoImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageContainerView
    }()
    let logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFit
        return logoImageView
    }()
    let imageActivityIndicator : UIActivityIndicatorView = {
        let imageActivityIndicator = UIActivityIndicatorView()
        imageActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        imageActivityIndicator.startAnimating()
        imageActivityIndicator.isHidden = false
        return imageActivityIndicator
    }()
    let nameLabelContainerView : UIView = {
        let nameLabelContainerView = UIView()
        nameLabelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return nameLabelContainerView
    }()
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.1
        return nameLabel
    }()
    let priceLabelContainerView : UIView = {
        let priceLabelContainerView = UIView()
        priceLabelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return priceLabelContainerView
    }()
    let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textAlignment = .center
        priceLabel.numberOfLines = 0
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.minimumScaleFactor = 0.1
        return priceLabel
    }()
    let mktCapAndVolumeContainerView : UIView = {
        let mktCapAndVolumeContainerView = UIView()
        mktCapAndVolumeContainerView.translatesAutoresizingMaskIntoConstraints = false
        return mktCapAndVolumeContainerView
    }()
    let mktCapContainerView : UIView = {
        let mktCapContainerView = UIView()
        mktCapContainerView.translatesAutoresizingMaskIntoConstraints = false
        return mktCapContainerView
    }()
    let mktCapValueContainerView : UIView = {
        let mktCapValueContainerView = UIView()
        mktCapValueContainerView.translatesAutoresizingMaskIntoConstraints = false
        return mktCapValueContainerView
    }()
    let volumeContainerView : UIView = {
        let volumeContainerView = UIView()
        volumeContainerView.translatesAutoresizingMaskIntoConstraints = false
        return volumeContainerView
    }()
    let volumeValueContainerView : UIView = {
        let volumeValueContainerView = UIView()
        volumeValueContainerView.translatesAutoresizingMaskIntoConstraints = false
        return volumeValueContainerView
    }()
    let marketCapLabel: UILabel = {
        let marketCapLabel = UILabel()
        marketCapLabel.translatesAutoresizingMaskIntoConstraints = false
        marketCapLabel.textAlignment = .left
        marketCapLabel.numberOfLines = 0
        marketCapLabel.adjustsFontSizeToFitWidth = true
        marketCapLabel.minimumScaleFactor = 0.1
        return marketCapLabel
    }()
    let marketCapValueLabel: UILabel = {
        let marketCapValueLabel = UILabel()
        marketCapValueLabel.translatesAutoresizingMaskIntoConstraints = false
        marketCapValueLabel.textAlignment = .left
        marketCapValueLabel.numberOfLines = 0
        marketCapValueLabel.adjustsFontSizeToFitWidth = true
        marketCapValueLabel.minimumScaleFactor = 0.1
        return marketCapValueLabel
    }()
    let volumeLabel: UILabel = {
        let volumeLabel = UILabel()
        volumeLabel.translatesAutoresizingMaskIntoConstraints = false
        volumeLabel.textAlignment = .left
        volumeLabel.numberOfLines = 0
        
        volumeLabel.adjustsFontSizeToFitWidth = true
        volumeLabel.minimumScaleFactor = 0.1
        return volumeLabel
    }()
    let volumeValueLabel: UILabel = {
        let volumeValueLabel = UILabel()
        volumeValueLabel.translatesAutoresizingMaskIntoConstraints = false
        volumeValueLabel.textAlignment = .left
        volumeValueLabel.numberOfLines = 0
        volumeValueLabel.adjustsFontSizeToFitWidth = true
        volumeValueLabel.minimumScaleFactor = 0.1
        return volumeValueLabel
    }()
    let changeAndLastUpdatedContainerView : UIView = {
        let changeAndLastUpdatedContainerView = UIView()
        changeAndLastUpdatedContainerView.translatesAutoresizingMaskIntoConstraints = false
        return changeAndLastUpdatedContainerView
    }()
    let changeContainerView : UIView = {
        let changeContainerView = UIView()
        changeContainerView.translatesAutoresizingMaskIntoConstraints = false
        return changeContainerView
    }()
    let lastUpdatedContainerView : UIView = {
        let lastUpdatedContainerView = UIView()
        lastUpdatedContainerView.translatesAutoresizingMaskIntoConstraints = false
        return lastUpdatedContainerView
    }()
    let changePctLabel: UILabel = {
        let changePctLabel = UILabel()
        changePctLabel.translatesAutoresizingMaskIntoConstraints = false
        changePctLabel.textAlignment = .center
        changePctLabel.numberOfLines = 0
        changePctLabel.adjustsFontSizeToFitWidth = true
        changePctLabel.minimumScaleFactor = 0.1
        return changePctLabel
    }()
    let lastUpdatedlabel: UILabel = {
        let lastUpdatedlabel = UILabel()
        lastUpdatedlabel.translatesAutoresizingMaskIntoConstraints = false
        lastUpdatedlabel.textAlignment = .center
        lastUpdatedlabel.numberOfLines = 0
        lastUpdatedlabel.adjustsFontSizeToFitWidth = true
        lastUpdatedlabel.minimumScaleFactor = 0.1
        return lastUpdatedlabel
    }()
    
    
    
    
    //MARK:-init
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCellProperties()
        
        configureSubviews()
        
        configureConstraints()
        configureLabelFonts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func configureCellProperties() {
        inkView.inkColor = UIColor(red: 253/255.0, green: 82/255.0, blue: 143/255.0, alpha: 0.2)
        backgroundColor = .white
        cornerRadius = 8.0
        setShadowColor(UIColor(red: 253/255.0, green: 82/255.0, blue: 143/255.0, alpha: 1.0), for: .normal)
    }
    
    func configureLabelFonts() {
        nameLabel.font = UIFont(name: FontsConstants.proximaNovaBlack, size: 100)
        priceLabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: 100)
        changePctLabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: 100)
        lastUpdatedlabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: 100)
        lastUpdatedlabel.textColor = .lightGray
        marketCapLabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: 100)
        marketCapLabel.textColor = .lightGray
        marketCapValueLabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: 100)
        volumeLabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: 100)
        volumeLabel.textColor = .lightGray
        volumeValueLabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: 100)
    }
    
    public func configureConstraints() {
        //logoImageView constraints
        logoImageContainerView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.2, height: 0.5))
        
        logoImageView.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        imageActivityIndicator.centerInSuperview(constraintsToSuperview: CGSize(width: 0.5, height: 0.5))
        
        nameLabelContainerView.anchor(top: logoImageContainerView.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: nil, constraintsToSuperview: CGSize(width: 0.2, height: 0))
        
        nameLabel.centerInSuperview(constraintsToSuperview: CGSize(width: 0.75, height: 0.45))
        
        priceLabelContainerView.anchor(top: contentView.topAnchor, leading: logoImageContainerView.trailingAnchor, bottom: nil, trailing: nil,  constraintsToSuperview: CGSize(width: 0.4, height: 0.5))
        
        priceLabel.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.5))
        
        changeAndLastUpdatedContainerView.anchor(top: contentView.topAnchor, leading: priceLabelContainerView.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor,  constraintsToSuperview: CGSize(width: 0, height: 0.5))
        
        changeContainerView.anchor(top: changeAndLastUpdatedContainerView.topAnchor, leading: changeAndLastUpdatedContainerView.leadingAnchor, bottom: nil, trailing: changeAndLastUpdatedContainerView.trailingAnchor, constraintsToSuperview: CGSize(width: 0, height: 0.5))
        
        changePctLabel.centerInSuperview(constraintsToSuperview: CGSize(width: 0.7, height: 0.65))
        
        lastUpdatedContainerView.anchor(top: changeContainerView.bottomAnchor, leading: changeAndLastUpdatedContainerView.leadingAnchor, bottom: nil, trailing: changeAndLastUpdatedContainerView.trailingAnchor, constraintsToSuperview: CGSize(width: 0, height: 0.5))

        lastUpdatedlabel.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.6))
        
        mktCapAndVolumeContainerView.anchor(top: priceLabelContainerView.bottomAnchor, leading: nameLabelContainerView.trailingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor)
        
        mktCapContainerView.anchor(top: mktCapAndVolumeContainerView.topAnchor, leading: mktCapAndVolumeContainerView.leadingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.3, height: 0.5))
        
        marketCapLabel.anchor(top: nil, leading: mktCapContainerView.leadingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.85, height: 0.55))
        marketCapLabel.centerYAnchor.constraint(equalTo: mktCapContainerView.centerYAnchor).isActive = true
        
        mktCapValueContainerView.anchor(top: mktCapContainerView.bottomAnchor, leading: mktCapAndVolumeContainerView.leadingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.3, height: 0.5))
        
        marketCapValueLabel.anchor(top: nil, leading: mktCapValueContainerView.leadingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.9, height: 0.6))
        marketCapValueLabel.centerYAnchor.constraint(equalTo: mktCapValueContainerView.centerYAnchor).isActive = true
        
        volumeContainerView.anchor(top: mktCapAndVolumeContainerView.topAnchor, leading: mktCapContainerView.trailingAnchor, bottom: nil, trailing: mktCapAndVolumeContainerView.trailingAnchor, constraintsToSuperview: CGSize(width: 0, height: 0.5))
       
        volumeLabel.anchor(top: nil, leading: volumeContainerView.leadingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.6, height: 0.55))
        volumeLabel.centerYAnchor.constraint(equalTo: volumeContainerView.centerYAnchor).isActive = true
        
        volumeValueContainerView.anchor(top: volumeContainerView.bottomAnchor, leading: mktCapValueContainerView.trailingAnchor, bottom: mktCapAndVolumeContainerView.bottomAnchor, trailing: mktCapAndVolumeContainerView.trailingAnchor)
        
        volumeValueLabel.anchor(top: nil, leading: volumeValueContainerView.leadingAnchor, bottom: nil, trailing: nil, constraintsToSuperview: CGSize(width: 0.98, height: 0.6))
        volumeValueLabel.centerYAnchor.constraint(equalTo: volumeValueContainerView.centerYAnchor).isActive = true
        
       
    }
    
    fileprivate func configureSubviews() {
        contentView.addSubview(nameLabelContainerView)
        nameLabelContainerView.addSubview(nameLabel)
        contentView.addSubview(priceLabelContainerView)
        priceLabelContainerView.addSubview(priceLabel)
        contentView.addSubview(mktCapAndVolumeContainerView)
        mktCapAndVolumeContainerView.addSubview(mktCapContainerView)
        mktCapAndVolumeContainerView.addSubview(mktCapValueContainerView)
        mktCapContainerView.addSubview(marketCapLabel)
        mktCapValueContainerView.addSubview(marketCapValueLabel)
        mktCapAndVolumeContainerView.addSubview(volumeContainerView)
        mktCapAndVolumeContainerView.addSubview(volumeValueContainerView)
        volumeContainerView.addSubview(volumeLabel)
        volumeValueContainerView.addSubview(volumeValueLabel)
        contentView.addSubview(changeAndLastUpdatedContainerView)
        changeAndLastUpdatedContainerView.addSubview(changeContainerView)
        changeContainerView.addSubview(changePctLabel)
        changeAndLastUpdatedContainerView.addSubview(lastUpdatedContainerView)
        lastUpdatedContainerView.addSubview(lastUpdatedlabel)
        contentView.addSubview(logoImageContainerView)
        logoImageContainerView.addSubview(logoImageView)
        logoImageView.addSubview(imageActivityIndicator)
    }
    
    func poopulateCell(name:String, imageURL:String, price: String, marketCap: String, volume24:String, volume24To:String, lastUpdated: String, changePct:String) {
        nameLabel.text = name
        priceLabel.text = price
        lastUpdatedlabel.text = lastUpdated
        marketCapValueLabel.text = marketCap
        marketCapLabel.text = "Mkt.Cap"
        volumeLabel.text = "Vol.24H"
        volumeValueLabel.text = "\(volume24)/\(volume24To)"
        if let unwrappedURL = URL(string: "\(Constants.imageBaseUrl)\(imageURL)") {
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
        
        changePctLabel.text = "\(changePct)%"
        if let changePctInt = Double(changePct) {
            if changePctInt > 0 {
                changePctLabel.textColor = UIColor(red: 82/255.0, green: 173/255.0, blue: 92/255.0, alpha: 1)
            } else {
                changePctLabel.textColor = UIColor(red: 250/255.0, green: 75/255.0, blue: 58/255.0, alpha: 1)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        logoImageView.image = nil
        priceLabel.text = nil
        changePctLabel.text = nil
        lastUpdatedlabel.text = nil
        marketCapValueLabel.text = nil
        volumeValueLabel.text = nil
    }
    
}
