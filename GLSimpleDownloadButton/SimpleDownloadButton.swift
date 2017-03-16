//
//  SimpleDownloadButton.swift
//  GLSimpleDownloadButton
//
//  Created by LeoGeng on 14/03/2017.
//  Copyright © 2017 LeoGeng. All rights reserved.
//

import UIKit

public enum GLDownloadStatus {
    case willDownload,downloading,downloaded,pending
}


public class GLSimpleDownloadButton: UIView {
    fileprivate var _pendingImage:UIImage?
    fileprivate var _willDownloadImage:UIImage?
    fileprivate var _downloadedImage:UIImage?
    fileprivate var _borderWidth:CGFloat = 0
    
    fileprivate var _pendingText:String? = "Pending"
    fileprivate var _willDownloadText:String? = "Download"
    fileprivate var _downloadedText:String? = "Complete"
    var font = UIFont.systemFont(ofSize: 16)
    
    fileprivate var _radius:CGFloat!{
        get{
            if  self.status == GLDownloadStatus.willDownload{
                return frame.width/8
            }else{
                return (frame.width < frame.height ? frame.width : frame.height)/2
            }
        }
    }
    
    fileprivate let _startAngle:CGFloat = CGFloat(M_PI * 1.5)
    
    fileprivate var _centerOfSelf:CGPoint!{
        get{
            return CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        }
    }
    
    public var tapEvent:((_ sender:GLSimpleDownloadButton)->Void)?
    public var status:GLDownloadStatus = .willDownload{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    public  var stopButtonWidth:CGFloat = 10{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    public var progress = 0.0{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    public var emptyLineWidth:CGFloat! = 1{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    public  var fillLineWidth:CGFloat = 3{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    override public var tintColor: UIColor!{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.tintColor = UIColor.blue
        let tapEvent = UITapGestureRecognizer(target: self, action: #selector(self.tapEvent(sender:)))
        self.addGestureRecognizer(tapEvent)
    }
    
    override public func draw(_ rect: CGRect) {
        switch self.status {
        case .willDownload:
            self.drawText(text: _willDownloadText)
            self.drawImage(img: _willDownloadImage)
            break
        case .pending:
            self.drawText(text: _pendingText)
            self.drawImage(img: _pendingImage)
            break
        case .downloading:
            self.drawStopRect()
            self.drawEmptyCircle()
            self.drawProgress()
            break
        case .downloaded:
            self.drawText(text: _downloadedText)
            self.drawImage(img: _downloadedImage)
            break
        }
    }
    
    @objc internal func tapEvent(sender:UIGestureRecognizer){
        switch self.status{
        case .willDownload:
            self.status = .downloading
            break
        case .downloading:
            self.status = .pending
            break
        case .pending:
            self.status = .downloaded
            break
        case .downloaded:
            self.status = .willDownload
            break
        }
        
        self.tapEvent?(self)
    }
}

extension GLSimpleDownloadButton{
    public func setImage(_ image:UIImage?,for status:GLDownloadStatus){
        switch status {
        case .willDownload:
            _willDownloadImage = image
            break
        case .downloading:
            _downloadedImage = image
            break
        case .pending:
            _pendingImage = image
            break
        case .downloaded:
            _downloadedImage = image
            break
        }
    }
    
    public func setTitle(_ title:String?,for status:GLDownloadStatus){
        switch status {
        case .willDownload:
            _willDownloadText = title
            break
        case .downloading:
            _downloadedText = title
            break
        case .pending:
            _pendingText = title
            break
        case .downloaded:
            _downloadedText = title
            break
        }
    }
}

extension GLSimpleDownloadButton{
    fileprivate func drawText(text:String?){
        guard let text = text else {
            return
        }
        
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        let attributeString = NSAttributedString(string: text, attributes: [NSFontAttributeName:self.font,NSParagraphStyleAttributeName:style,NSForegroundColorAttributeName:self.tintColor])
        
        let heightOfText = text.heightWithConstraint(width: self.bounds.width, font: self.font)
        let y = (self.bounds.height - heightOfText)/2
        attributeString.draw(in: CGRect(x: 0, y: y, width: self.bounds.width, height: heightOfText))
    }
    
    fileprivate func drawImage(img:UIImage?){
        img?.draw(in: self.bounds)
    }
    
    fileprivate func drawStopRect(){
        let x = _centerOfSelf.x - self.stopButtonWidth / 2
        let y = _centerOfSelf.y - self.stopButtonWidth / 2
        
        let rect = CGRect(x: x, y: y, width: self.stopButtonWidth, height: self.stopButtonWidth)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.tintColor.cgColor)
        context?.fill(rect)
    }
    
    fileprivate func drawEmptyCircle(){
        self.drawCircle(endAngle: _startAngle + CGFloat(M_PI * 2),lineWidth: self.emptyLineWidth,radius: _radius)
    }
    
    fileprivate func drawProgress(){
        let endAngle = _startAngle + CGFloat(M_PI * 2 * progress)
        let innerRadius = _radius - self.fillLineWidth/2
        self.drawCircle(endAngle: endAngle,lineWidth: self.fillLineWidth,radius: innerRadius)
    }
    
    fileprivate func drawCircle(endAngle:CGFloat,lineWidth:CGFloat,radius:CGFloat){
        let bezier = UIBezierPath()
        
        self.tintColor.setStroke()
        
        
        bezier.addArc(withCenter:_centerOfSelf, radius: radius, startAngle: _startAngle, endAngle: endAngle, clockwise: true)
        bezier.lineWidth = lineWidth
        bezier.stroke()
    }
}
