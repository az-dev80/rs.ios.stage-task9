//
// 📰 🐸
// Project: RSSchool_T9
//
// Author: Albert Zhloba
// On: 2.08.21
//
// Copyright © 2021 RSSchool. All rights reserved.
import UIKit

public struct DetailImageInfo {
    
    public enum ImageMode : Int {
        case aspectFit  = 1
        case aspectFill = 2
    }
    
    public let image     : UIImage
    public let imageMode : ImageMode
    
    public var contentMode : UIView.ContentMode {
        return UIView.ContentMode(rawValue: imageMode.rawValue)!
    }
    
    public init(image: UIImage, imageMode: ImageMode) {
        self.image     = image
        self.imageMode = imageMode
    }
    
    func calculateRect(_ size: CGSize) -> CGRect {
        
        let widthRatio  = size.width  / image.size.width
        let heightRatio = size.height / image.size.height
        
        switch imageMode {
            
        case .aspectFit:
            
            return CGRect(origin: CGPoint.zero, size: size)
            
        case .aspectFill:
            
            return CGRect(
                x      : 0,
                y      : 0,
                width  : image.size.width  * max(widthRatio, heightRatio),
                height : image.size.height * max(widthRatio, heightRatio)
            )
            
        }
    }
    
    func calculateMaximumZoomScale(_ size: CGSize) -> CGFloat {
        return max(3, max(
            image.size.width  / size.width,
            image.size.height / size.height
        ))
    }
    
}

open class DetailTransitionInfo {
    
    open var duration: TimeInterval = 0.35
    open var canSwipe: Bool         = true
    
    public init(fromView: UIView) {
        self.fromView = fromView
    }
    
    public init(fromRect: CGRect) {
        self.convertedRect = fromRect
    }
    
    weak var fromView : UIView?
    
    fileprivate var convertedRect : CGRect?
    
}

open class DetailViewController: UIViewController {
    
    public let imageInfo      : DetailImageInfo
    open var transitionInfo : DetailTransitionInfo?
    
    public let imageView  = UIImageView()
    public let scrollView = UIScrollView()
    
    open var dismissCompletion: (() -> Void)?
    
    open lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
    }()
    
    // MARK: Initialization
    
    public init(imageInfo: DetailImageInfo) {
        self.imageInfo = imageInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    public convenience init(imageInfo: DetailImageInfo, transitionInfo: DetailTransitionInfo) {
        self.init(imageInfo: imageInfo)
        self.transitionInfo = transitionInfo
        if
            let fromView = transitionInfo.fromView,
            let referenceView = fromView.superview {
            transitionInfo.convertedRect = referenceView.convert(fromView.frame, to: nil)
        }
        if transitionInfo.convertedRect != nil {
            self.transitioningDelegate = self
            self.modalPresentationStyle = .custom
        }
    }
    
    public convenience init(image: UIImage, imageMode: UIView.ContentMode, fromView: UIView?) {
        let imageInfo = DetailImageInfo(image: image, imageMode: DetailImageInfo.ImageMode(rawValue: imageMode.rawValue)!)
        if let fromView = fromView {
            self.init(imageInfo: imageInfo, transitionInfo: DetailTransitionInfo(fromView: fromView))
        } else {
            self.init(imageInfo: imageInfo)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupScrollView()
        setupImageView()
        setupGesture()
        
        edgesForExtendedLayout = UIRectEdge()
        //automaticallyAdjustsScrollViewInsets = false
        //dd
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        imageView.frame = imageInfo.calculateRect(view.bounds.size)
        
        scrollView.frame = view.bounds
        scrollView.contentSize = imageView.bounds.size
        scrollView.maximumZoomScale = imageInfo.calculateMaximumZoomScale(scrollView.bounds.size)
    }
    
    // MARK: Setups
    
    fileprivate func setupView() {
        view.backgroundColor = UIColor.black
    }
    
    fileprivate func setupScrollView() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
    }
    
    fileprivate func setupImageView() {
        imageView.image = imageInfo.image
        imageView.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
    }
    
    fileprivate func setupGesture() {
        let single = UITapGestureRecognizer(target: self, action: #selector(singleTap))
        let double = UITapGestureRecognizer(target: self, action: #selector(doubleTap(_:)))
        double.numberOfTapsRequired = 2
        single.require(toFail: double)
        scrollView.addGestureRecognizer(single)
        scrollView.addGestureRecognizer(double)
        
        if transitionInfo?.canSwipe == true {
            let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
            pan.delegate = self
            scrollView.addGestureRecognizer(pan)
        }
    }
    
    // MARK: Gesture
    
    @objc fileprivate func singleTap() {
        if navigationController == nil || (presentingViewController != nil && navigationController!.viewControllers.count <= 1) {
            dismiss(animated: true, completion: dismissCompletion)
        }
    }
    
    @objc fileprivate func doubleTap(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: scrollView)
        
        if scrollView.zoomScale == 1.0 {
            scrollView.zoom(to: CGRect(x: point.x-40, y: point.y-40, width: 80, height: 80), animated: true)
        } else {
            scrollView.setZoomScale(1.0, animated: true)
        }
    }
    
    fileprivate var panViewOrigin : CGPoint?
    fileprivate var panViewAlpha  : CGFloat = 1
    
    @objc fileprivate func pan(_ gesture: UIPanGestureRecognizer) {
        
        func getProgress() -> CGFloat {
            let origin = panViewOrigin!
            let changeX = abs(scrollView.center.x - origin.x)
            let changeY = abs(scrollView.center.y - origin.y)
            let progressX = changeX / view.bounds.width
            let progressY = changeY / view.bounds.height
            return max(progressX, progressY)
        }
        
        func getChanged() -> CGPoint {
            let origin = scrollView.center
            let change = gesture.translation(in: view)
            return CGPoint(x: origin.x + change.x, y: origin.y + change.y)
        }
        
        func getVelocity() -> CGFloat {
            let vel = gesture.velocity(in: scrollView)
            return sqrt(vel.x*vel.x + vel.y*vel.y)
        }
        
        switch gesture.state {

        case .began:
            
            panViewOrigin = scrollView.center
            
        case .changed:
            
            scrollView.center = getChanged()
            panViewAlpha = 1 - getProgress()
            view.backgroundColor = UIColor(white: 0.0, alpha: panViewAlpha)
            gesture.setTranslation(CGPoint.zero, in: nil)

        case .ended:
            
            if getProgress() > 0.25 || getVelocity() > 1000 {
                dismiss(animated: true, completion: dismissCompletion)
            } else {
                fallthrough
            }
            
        default:
            
            UIView.animate(withDuration: 0.3,
                animations: {
                    self.scrollView.center = self.panViewOrigin!
                    self.view.backgroundColor = UIColor(white: 0.0, alpha: 1.0)
                },
                completion: { _ in
                    self.panViewOrigin = nil
                    self.panViewAlpha  = 1.0
                }
            )
            
        }
    }
    
}

extension DetailViewController: UIScrollViewDelegate {
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        imageView.frame = imageInfo.calculateRect(scrollView.contentSize)
    }
    
}

extension DetailViewController: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DetailImageViewerTransition(imageInfo: imageInfo, transitionInfo: transitionInfo!, transitionMode: .present)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DetailImageViewerTransition(imageInfo: imageInfo, transitionInfo: transitionInfo!, transitionMode: .dismiss)
    }
    
}

class DetailImageViewerTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let imageInfo      : DetailImageInfo
    let transitionInfo : DetailTransitionInfo
    var transitionMode : TransitionMode
    
    enum TransitionMode {
        case present
        case dismiss
    }
    
    init(imageInfo: DetailImageInfo, transitionInfo: DetailTransitionInfo, transitionMode: TransitionMode) {
        self.imageInfo = imageInfo
        self.transitionInfo = transitionInfo
        self.transitionMode = transitionMode
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionInfo.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let tempMask = UIView()
            tempMask.backgroundColor = UIColor.black
        
        let tempImage = UIImageView(image: imageInfo.image)
            tempImage.layer.cornerRadius = transitionInfo.fromView?.layer.cornerRadius ?? 0
            tempImage.layer.masksToBounds = true
            tempImage.contentMode = imageInfo.contentMode
        
        containerView.addSubview(tempMask)
        containerView.addSubview(tempImage)
        
        if transitionMode == .present {
            transitionInfo.fromView?.alpha = 0
            let imageViewer = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! DetailViewController
                imageViewer.view.layoutIfNeeded()
            
                tempMask.alpha = 0
                tempMask.frame = imageViewer.view.bounds
                tempImage.frame = transitionInfo.convertedRect!
            
            UIView.animate(withDuration: transitionInfo.duration,
                animations: {
                    tempMask.alpha  = 1
                    tempImage.frame = imageViewer.imageView.frame
                },
                completion: { _ in
                    tempMask.removeFromSuperview()
                    tempImage.removeFromSuperview()
                    containerView.addSubview(imageViewer.view)
                    transitionContext.completeTransition(true)
                }
            )
            
        }
        
        if transitionMode == .dismiss {
            
            let imageViewer = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! DetailViewController
                imageViewer.view.removeFromSuperview()
            
                tempMask.alpha = imageViewer.panViewAlpha
                tempMask.frame = imageViewer.view.bounds
                tempImage.frame = CGRect(x: imageViewer.scrollView.contentOffset.x * -1, y: imageViewer.scrollView.contentOffset.y * -1, width: imageViewer.scrollView.contentSize.width, height: imageViewer.scrollView.contentSize.height)
            
            UIView.animate(withDuration: transitionInfo.duration,
                animations: {
                    tempMask.alpha  = 0
                    tempImage.frame = self.transitionInfo.convertedRect!
                },
                completion: { _ in
                    tempMask.removeFromSuperview()
                    imageViewer.view.removeFromSuperview()
                    self.transitionInfo.fromView?.alpha = 1
                    transitionContext.completeTransition(true)
                }
            )
            
        }
        
    }
    
}

extension DetailViewController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let pan = gestureRecognizer as? UIPanGestureRecognizer {
            if scrollView.zoomScale != 1.0 {
                return false
            }
            if imageInfo.imageMode == .aspectFill && (scrollView.contentOffset.x > 0 || pan.translation(in: view).x <= 0) {
                return false
            }
        }
        return true
    }
    
}
