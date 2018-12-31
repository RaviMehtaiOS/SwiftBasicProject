//
//  ViewController.swift
//  BasicProject
//
//  Created by Ravi Mehta on 07/08/18.
//  Copyright © 2018 Ravi Mehta. All rights reserved.
//

import UIKit
import GoogleMobileAds

class LoginController: BaseViewController {

    @IBOutlet weak var adBannerView: GADBannerView!
    
    @IBOutlet weak var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(goToDashboard), name: .LoginSuccessful, object: nil)
        
//        adBannerView = GADBannerView(adSize: kGADAdSizeBanner)
        adBannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        adBannerView.rootViewController = self
        adBannerView.load(GADRequest())
        adBannerView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @objc func goToDashboard() {
        let dashboardVC = self.storyboard?.instantiateViewController(withIdentifier: "DashboardController") as! DashboardController
        self.navigationController?.pushViewController(dashboardVC, animated: true)
    }
    
}

extension LoginController: GADBannerViewDelegate {
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}
