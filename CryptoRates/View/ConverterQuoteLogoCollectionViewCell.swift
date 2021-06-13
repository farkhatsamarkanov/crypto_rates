//
//  ConverterQuoteLogoTableViewCell.swift
//  CryptoRates
//
//  Created by Admin on 17/06/2020.
//

import UIKit
import MaterialComponents.MaterialCards

class ConverterQuoteLogoCollectionViewCell: MDCCardCollectionCell {

    let logoAndNameContainerView : UIView = {
           let containerView = UIView()
        //containerView.backgroundColor = .yellow
           containerView.translatesAutoresizingMaskIntoConstraints = false
           return containerView
       }()
    let logoImageContainerView : UIView = {
        let logoImageContainerView = UIView()
      //  logoImageContainerView.backgroundColor = .red
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
    let fullNameLabelContainerView : UIView = {
        let nameLabelContainerView = UIView()
        nameLabelContainerView.translatesAutoresizingMaskIntoConstraints = false
        return nameLabelContainerView
    }()
    let fullNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.1
        return nameLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCellProperties()
        configureSubviews()
        configureConstraints()
        fullNameLabel.font = UIFont(name: FontsConstants.proximaNovaRegular, size: frame.width/15)
        
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
    
    private func configureSubviews() {
        contentView.addSubview(logoAndNameContainerView)
        logoAndNameContainerView.addSubview(logoImageContainerView)
        logoImageContainerView.addSubview(logoImageView)
        logoImageView.addSubview(imageActivityIndicator)
        logoAndNameContainerView.addSubview(fullNameLabelContainerView)
        fullNameLabelContainerView.addSubview(fullNameLabel)
    }
    
    private func configureConstraints() {
        logoAndNameContainerView.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        logoImageContainerView.anchor(top: logoAndNameContainerView.topAnchor, leading: logoAndNameContainerView.leadingAnchor, bottom: logoAndNameContainerView.bottomAnchor, trailing: nil)
        logoImageContainerView.widthAnchor.constraint(equalTo: logoImageContainerView.heightAnchor).isActive = true
        
        logoImageView.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.8))
        
        fullNameLabelContainerView.anchor(top: logoAndNameContainerView.topAnchor, leading: logoImageContainerView.trailingAnchor, bottom: logoAndNameContainerView.bottomAnchor, trailing: logoAndNameContainerView.trailingAnchor)
        
        fullNameLabel.centerInSuperview(constraintsToSuperview: CGSize(width: 0.8, height: 0.6))
    }
    
    public func populateCell(imageURL: String, fullName: String) {
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
        fullNameLabel.text = fullName
    }
    
    override func prepareForReuse() {
         super.prepareForReuse()
        logoImageView.image = nil
        fullNameLabel.text = nil
    }
    
    
}
