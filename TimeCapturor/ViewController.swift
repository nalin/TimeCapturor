//
//  ViewController.swift
//  TimeCapturor
//
//  Created by YangTengfei on 12/21/15.
//  Copyright © 2015 TengfeiYang. All rights reserved.
//

import UIKit
//import Photos

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UIViewControllerTransitioningDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var toolBar: UIToolbar!
    var collectionView: UICollectionView!
    var selectedCell: CollectionViewCell?
    
//    @IBAction func btnTakingPhoto(sender: UIButton) {
//        if (UIImagePickerController.isSourceTypeAvailable(.Camera))
//        {
//            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil
//            {
//                let imagePicker = UIImagePickerController()
//                imagePicker.allowsEditing = false
//                imagePicker.sourceType = .Camera
//                imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.Front
//                imagePicker.cameraCaptureMode = .Photo
//                presentViewController(imagePicker, animated: true, completion: nil)
//            }
//            else
//            {
//                print("Rear camera doesn't exist")
//            }
//        }
//        else
//        {
//            //print("\(ImageData[1])")
//            print("Camera inaccessable")
//        }
//        
//        
//    }
    
    //func layoutAttributesForElementsInRt
    
    var collectionData = Album()
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Do any additional setup after loading the view, typically from a nib.
//    }
 ///////////////////////////////////////////////////////////
//    var collectionView: UICollectionView?

    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenSize = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        // self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: MyFlowLayout())
        let statusHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        let statusView = UIView(frame:
            CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.size.width, height:statusHeight) )
        //statusView.backgroundColor = UIColor.whiteColor()
    // statusView.backgroundColor = UIColor.redColor()
        
        // 1  add blur
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        // 2
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = statusView.bounds
        // 3
        statusView.addSubview(blurView)
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
       // UIApplication.sharedApplication().statusBarStyle = .BlackOpaque
        
        
        // change title color and drop the shadow like it's hot
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.blackColor();
        shadow.shadowOffset = CGSizeMake(1,2);
        UINavigationBar.appearance().titleTextAttributes = NSDictionary(objects: [UIColor.whiteColor(), shadow], forKeys: [NSForegroundColorAttributeName, NSShadowAttributeName]) as? [String : AnyObject];
        
        let border = CALayer()
        let width = CGFloat(0.6)
        border.borderColor = UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: 0, y: statusHeight, width:  screenWidth, height: 0.6)
        
        border.borderWidth = width
        statusView.layer.addSublayer(border)
        //statusView.layer.masksToBounds = true
        
      
        
        // self.navigationController?.navigationBar.tintColor = UIColor.grayColor()
        
      //  self.navigationController?.navigationBar.translucent = true
        
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 5, bottom: 10, right: 5)
        //layout.itemSize = CGSize(width: 150, height: 150)
      //  print("screen width \(self.collectionView.frame)")
       // print("view width \(self.view.frame)")
        //print(screenWidth)
       // print(screenHeight)
        //self.collectionView.frame = self.view.frame
        layout.itemSize = CGSize(width: (screenWidth-20) / 3, height: (screenWidth-20) / 3)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        
        //let margins = view.layoutMarginsGuide
        //self.collectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        // create the constraints with the constant value you want.
        
        
        
        let size = CGSize(width: view.frame.width, height: view.frame.height-toolBar.frame.height-0.7-statusHeight-0.6)
        //let frame = CGRect(origin: CGPoint(x: 0.0, y: statusHeight+0.6), size: size)
        let frame = CGRect(origin: CGPoint(x: 0.0, y: 0), size: size)
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
       collectionView!.dataSource = self
        collectionView!.delegate = self
        collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = UIColor.whiteColor()
        
        //collectionView.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true

        //collectionView.setCollectionViewLayout(layout, animated: false)
     
        
       
          self.view.addSubview(collectionView!)
        self.view.addSubview(statusView)
        
    }
        //self.view.addSubview(collectionView!)
//        
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
//        layout.itemSize = CGSize(width: CGFloat(screenWidth / 3), height: CGFloat(screenWidth / 3))
//        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
//        print(collectionView)
//        collectionView!.dataSource = self
//        collectionView!.delegate = self
//        collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
//        collectionView!.backgroundColor = UIColor.greenColor()
//        self.view.addSubview(collectionView!)
        
        
    
//        
    
//
//        // Do any additional setup after loading the view, typically from a nib
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
//        layout.itemSize = CGSize(width: screenWidth / 3, height: screenWidth / 3)
//        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
//        
//        collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
//        collectionView!.backgroundColor = UIColor.greenColor()
//        self.view.addSubview(collectionView!)
   
   

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
       // self.navigationController?.delegate = self
    
            
            navigationController?.hidesBarsOnSwipe = true
    
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
         //self.navigationController?.navigationBarHidden = true
        collectionData.updateData()
        collectionView.reloadData()
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection: Int)->Int{
        //print(cellData.count)
        return collectionData.cellData.count
    }
   
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath)->UICollectionViewCell{
        let cell: CollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        //cell.backgroundColor = UIColor.whiteColor()
        //cell.layer.borderColor = UIColor.blackColor().CGColor
        //cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = CGFloat(4)
        //cell.frame.size.width = screenWidth / 3
        //cell.frame.size.height = screenWidth / 3
     

        
        //cell.layer.borderWidth = 0.5
       
        cell.titleLable?.text = collectionData.cellData[indexPath.row].lableData
        cell.imageView?.image = collectionData.cellData[indexPath.row].ImageData

       // print("11")
        return cell
        
    }
    

//    func animationControllerForPresentedController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        if ((toVC as? NewViewController) != nil){
//            if operation == UINavigationControllerOperation.Push {
//                print("1")
//                return MagicMoveTransion()
//            } else {
//                print("2")
//                return nil
//            }
//        }else {
//            print("3")
//            return FadeAnimator()
//        }
//    }
    
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MagicMoveTransion()
    }

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.selectedCell = collectionView.cellForItemAtIndexPath(indexPath) as? CollectionViewCell
        
        self.performSegueWithIdentifier("showImage", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showImage"{
            let indexPaths = self.collectionView!.indexPathsForSelectedItems()!
            let indexPath = indexPaths[0] as NSIndexPath
            let vc = segue.destinationViewController as! NewViewController
            vc.transitioningDelegate = self
           // vc.image = self.cellData[indexPath.row].ImageData
            
            vc.index = indexPath.item
            //vc.photoCollection = collectionData.getAllImageAndDate().ImageData
           // vc.urlCollection = collectionData.getAllImageAndDate().groupNSURL
            
          //  vc.image = self.selectedCell!.imageView.image!
            //vc.title = self.collectionData.cellData[indexPath.row].lableData
            
        }
    }
    
    
}

