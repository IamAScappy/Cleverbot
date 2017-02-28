//
//  BaseMessageCell.swift
//  Cleverbot
//
//  Created by Suyeol Jeon on 01/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

class BaseMessageCell: BaseCollectionViewCell {

  // MARK: Types

  struct Appearance {
    let bubbleViewBackgroundColor: UIColor
    let bubbleViewAlignment: BubbleViewAlignment
    let messageLabelTextColor: UIColor
  }

  enum BubbleViewAlignment {
    case left, right
  }


  // MARK: Constants

  fileprivate struct Metric {
    static let bubbleViewMaximumWidth = ceil(UIScreen.main.bounds.width * 2 / 3)
    static let messageLabelTopBottom = 10.f
    static let messageLabelLeftRight = 10.f
  }

  fileprivate struct Font {
    static let messageLabel = UIFont.systemFont(ofSize: 14)
  }


  // MARK: Properties

  fileprivate let appearance: Appearance


  // MARK: UI

  fileprivate let bubbleView = UIView()
  fileprivate let messageLabel = UILabel().then {
    $0.font = Font.messageLabel
    $0.numberOfLines = 0
  }


  // MARK: Initializing

  init(frame: CGRect, appearance: Appearance) {
    self.appearance = appearance
    super.init(frame: frame)

    self.bubbleView.backgroundColor = appearance.bubbleViewBackgroundColor
    self.messageLabel.textColor = appearance.messageLabelTextColor

    self.bubbleView.addSubview(self.messageLabel)
    self.contentView.addSubview(self.bubbleView)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: Configuring

  func configure(viewModel: MessageCellModelType) {
    self.messageLabel.text = viewModel.messageLabelText
    self.setNeedsLayout()
  }


  // MARK: Size

  class func size(thatFitsWidth width: CGFloat, viewModel: MessageCellModelType) -> CGSize {
    var height: CGFloat = 0
    let bubbleWidth = min(width, Metric.bubbleViewMaximumWidth)
    if let message = viewModel.messageLabelText {
      let messageLabelWidth = bubbleWidth - Metric.messageLabelLeftRight * 2
      height += Metric.messageLabelTopBottom
      height += message.height(thatFitsWidth: messageLabelWidth, font: Font.messageLabel)
      height += Metric.messageLabelTopBottom
    }
    return CGSize(width: width, height: height)
  }


  // MARK: Layout

  override func layoutSubviews() {
    super.layoutSubviews()

    self.messageLabel.top = Metric.messageLabelTopBottom
    self.messageLabel.left = Metric.messageLabelLeftRight
    self.messageLabel.width = min(self.contentView.width, Metric.bubbleViewMaximumWidth)
      - Metric.messageLabelLeftRight * 2
    self.messageLabel.sizeToFit()

    self.bubbleView.width = self.messageLabel.width + Metric.messageLabelLeftRight * 2
    self.bubbleView.height = self.contentView.height

    switch self.appearance.bubbleViewAlignment {
    case .left:
      self.bubbleView.left = 0
    case .right:
      self.bubbleView.right = self.contentView.width
    }
  }

}
