//
//  CanvasViewController.swift
//  animation
//
//  Created by Kaila Prochaska on 10/18/18.
//  Copyright © 2018 Kaila Prochaska. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!
    
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    var newlyCreatedFace: UIImageView!

    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    
    
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            var imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPanNewFace(_ :)))
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)

        } else if sender.state == .ended {
            newlyCreatedFace.transform = view.transform.scaledBy(x: 1.0, y: 1.0)
            
        }
        
        
    }

    //this function is to handle the panning of the faces on the canvas
    @objc func didPanNewFace(_ sender: UIPanGestureRecognizer) {
        var imageView = sender.view as! UIImageView

        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            newlyCreatedFace = sender.view as! UIImageView // to get the face that we panned on.
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center // so we can offset by translation later.
             newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)

           
        } else if sender.state == .ended {
             newlyCreatedFace.transform = view.transform.scaledBy(x: 1.0, y: 1.0)
           
        }
        
        
    }
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            trayOriginalCenter = trayView.center
            
        } else if sender.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
            let velocity = sender.velocity(in: view)
           //if y component of velocity is (+) => user is panning down
            //if y component of velocity is (-) => user is panning up
            if velocity.y > 0 {
                UIView.animate(withDuration: 0.3) {
                    self.trayView.center = self.trayDown
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.trayView.center = self.trayUp
                }
            }
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        trayDownOffset = 160
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
        
        UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options:[] ,
                       animations: { () -> Void in
                        self.trayView.center = self.trayDown
        }, completion: nil)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
