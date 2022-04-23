//
//  MainViewController.swift
//  ConceptCubeTest
//
//  Created by Huy Hà on 4/21/22.
//

import UIKit
import Firebase

class MainViewController: UIViewController {

    //MARK: IBOulets
    var images: [String] = ["m00","m01.png","m02.png","m03.png","m04.png","m05.png","m06.png","m07.png","m08.png","m09.png","m10.png","m11.png","m12.png","m13.png","m14.png",
                            
        "c01.png","c02.png","c03.png","c04.png","c05.png","c06.png","c07.png","c08.png","c09.png","c10.png","c11.png","c12.png","c13.png","c14.png","m15.png","m16.png","m17.png","m18.png","m19.png","m20.png","m21.png",
        
        "p01.png","p02.png","p03.png","p04.png","p05.png","p06.png","p07.png","p08.png","p09.png","p10.png","p11.png","p12.png","p13.png","p14.png",
        
        "s01.png","s02.png","s03.png","s04.png","s05.png","s06.png","s07.png","s08.png","s09.png","s10.png","s11.png","s12.png","s13.png","s14.png",
        
        "w01.png","w02.png","w03.png","w04.png","w05.png","w06.png","w07.png","w08.png","w09.png","w10.png","w11.png","w12.png","w13.png","w14.png"]
    
    
    var imageViews = [UIImageView]()
    var panGesture  = UIPanGestureRecognizer()
    var gesture = UIGestureRecognizer()
    var customGesture = CustomTapGestureRecognizer()
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayOfCards()
        images.shuffle()
        for x in 0...(images.count-1) {
            render(imageView: imageViews[x], position: x)
        }
    }
    //MARK: Helper
    func arrayOfCards() {
        for x in 0...(images.count-1) {
            var imgv = UIImageView()
            createDefaultImage(name: "bb.png", imageView: imgv)
            imageViews.append(imgv)
        }
    }
    
    func render(imageView: UIImageView, position: Int) {
        view.addSubview(imageView)
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGestureHandler(_:)))
        imageView.addGestureRecognizer(panGesture)
        customGesture = CustomTapGestureRecognizer(target: self, action: #selector(tapSelector(sender:)))
        customGesture.ourCustomValue = position
        imageView.addGestureRecognizer(customGesture)
        
    }

    
    func createDefaultImage(name: String, imageView: UIImageView) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 10, y: 20, width: 70, height: 108)
        imageView.image = UIImage(named: name)
        imageView.isUserInteractionEnabled = true
        
    }
    
    
    @objc func panGestureHandler(_ gesture: UIPanGestureRecognizer){
        if let x = gesture.view
        {
//            self.view.bringSubviewToFront(x)
        }
      let translation = gesture.translation(in: view)

      guard let gestureView = gesture.view else {
        return
      }
      gestureView.center = CGPoint(
        x: gestureView.center.x + translation.x,
        y: gestureView.center.y + translation.y
      )

      gesture.setTranslation(.zero, in: view)
    }
    
    func tapped( position : Int) {
        UIView.transition(from: imageViews[0], to: imageViews[position], duration: 1, options: UIView.AnimationOptions.transitionFlipFromRight, completion: nil)
    }
   
    //MARK: IBActions
    
    @IBAction func shuffleButtonPressed(_ sender: Any) {
        
        images.shuffle()
        for x in 0...(images.count-1) {
            imageViews[x].image = UIImage(named: "bb.png")
            imageViews[x].frame = CGRect(x: 10, y: 20, width: 70, height: 108)
        }
        
        
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
       
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @objc
    func tapSelector(sender: CustomTapGestureRecognizer) {
        print(sender.ourCustomValue)
        let x = sender.ourCustomValue
        print(x)
        imageViews[x!].image = UIImage(named: images[x!])
        
    }
}
class CustomTapGestureRecognizer: UITapGestureRecognizer {
    var ourCustomValue: Int?
}


