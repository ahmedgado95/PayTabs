//
//  ViewController.swift
//  AGPayTabs
//
//  Created by ahmed gado on 08/07/2021.
//

import UIKit
import PaymentSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    
    let profileID = "66724"
//    let serverKey = "SMJNRHRW2R-JBLL2HTZ2W-H2HTN2M29N"
    let serverKey = "S9JNRHRWZW-JBLL2HTZLG-MRZDNDHHHT"
//    let clientKey = "C2KM6R-K7DP62-BBMH79-DKB7HR"
    let clientKey = "C9KM6R-K7DH62-BBMH79-7669RD"

   
    var billingDetails: PaymentSDKBillingDetails! {
        return PaymentSDKBillingDetails(name: "Ahmed Gado",
                                     email: "gado@test.com",
                                     phone: "+201000000000",
                                     addressLine: "Street1",
                                     city: "Cairo",
                                     state: "Egypt",
                                     countryCode: "eg",
                                     zip: "12345")
    }
    
   
    var configuration: PaymentSDKConfiguration! {
        let theme = PaymentSDKTheme.default
        theme.logoImage = UIImage(named: "Logo")
        
        return PaymentSDKConfiguration(profileID: profileID,
                                       serverKey: serverKey,
                                       clientKey: clientKey,
                                       currency: "EGP",
                                       amount: 5.0,
                                       merchantCountryCode: "EG")
            .cartDescription("Flowers")
            .cartID("1234")
            .screenTitle("Pay with Gado")
            .theme(theme)
            .billingDetails(billingDetails)
    }
    

    
    func showError(message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController.init(title: self.title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction.init(title: "Ok", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func payButtonPressed(_ sender: Any) {
        PaymentManager.startCardPayment(on: self, configuration: configuration,                                 delegate: self)

    }
}

extension ViewController: PaymentManagerDelegate {
    
    func paymentManager(didFinishTransaction transactionDetails: PaymentSDKTransactionDetails?, error: Error?) {
        if let transactionDetails = transactionDetails {
            print("Response Code: " + (transactionDetails.paymentResult?.responseCode ?? ""))
            print("Result: " + (transactionDetails.paymentResult?.responseMessage ?? ""))
            print("Token: " + (transactionDetails.token ?? ""))
            print("Transaction Reference: " + (transactionDetails.transactionReference ?? ""))
            print("Transaction Time: " + (transactionDetails.paymentResult?.transactionTime ?? "" ))
        } else if let error = error {
            showError(message: error.localizedDescription)
        }
    }
}
