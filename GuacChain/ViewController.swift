//
//  ViewController.swift
//  GuacChain
//
//  Created by Chris Bond on 4/30/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tacoQuantityLabel: UILabel!
    @IBOutlet weak var burritoQuantityLabel: UILabel!
    @IBOutlet weak var chipsQuantityLabel: UILabel!
    @IBOutlet weak var horchataQuantityLabel: UILabel!
    @IBOutlet weak var tacoStepper: UIStepper!
    @IBOutlet weak var burritoStepper: UIStepper!
    @IBOutlet weak var chipsStepper: UIStepper!
    @IBOutlet weak var horchataStepper: UIStepper!
    @IBOutlet weak var bitcoindTotalLabel: UILabel!
    @IBOutlet weak var dollarTotalLabel: UILabel!
    @IBOutlet weak var currencySegmentedControl: UISegmentedControl!
    
    var currencyRate = CurrencyRate()
    
    let tacoPrice = 5.0
    let burritoPrice = 8.0
    let chipsPrice = 3.0
    let horchatePrice = 2.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyRate.getData {
            print("Called Successfully")
        }
    }

    func calcTotal() {
        
        let tacoQty = Double(tacoQuantityLabel.text!) ?? 0.0
        let burritoQty = Double(burritoQuantityLabel.text!) ?? 0.0
        let chipsQty = Double(chipsQuantityLabel.text!) ?? 0.0
        let horchataQty = Double(horchataQuantityLabel.text!) ?? 0.0
        
        let dollarTotal = (tacoQty * tacoPrice) + (burritoQty * burritoPrice) + (chipsQty * chipsPrice) + (horchataQty * horchatePrice)
        
        
        let bitcoinTotal = dollarTotal / currencyRate.dollarPerBTC
        bitcoindTotalLabel.text = "฿\(bitcoinTotal)"
        
        var currencyTotalString = ""
        
        switch currencySegmentedControl.selectedSegmentIndex {
        case 0:
            currencyTotalString = String(format: "$%.2f", dollarTotal)
            
        case 1:
            let poundTotal = dollarTotal * (currencyRate.poundPerBTC / currencyRate.dollarPerBTC)
            currencyTotalString = String(format: "£%.2f", poundTotal)
        case 2:
            let euroTotal = dollarTotal * (currencyRate.euroPerBTC / currencyRate.dollarPerBTC)
            currencyTotalString = String(format: "€%.2f", euroTotal)
        default:
            print("ERROR: this should never happen")
        }
        dollarTotalLabel.text = currencyTotalString
        

        
    }
    
    

    @IBAction func tacoStepperPressed(_ sender: UIStepper) {
        tacoQuantityLabel.text = "\(Int(sender.value))"
        calcTotal()
    }
    
    @IBAction func burritoStepperPressed(_ sender: UIStepper) {
        burritoQuantityLabel.text = "\(Int(sender.value))"
        calcTotal()

    }
    
    @IBAction func chipsStepperPressed(_ sender: UIStepper) {
        chipsQuantityLabel.text = "\(Int(sender.value))"
        calcTotal()

    }
    
    @IBAction func horchataStepperPressed(_ sender: UIStepper) {
        horchataQuantityLabel.text = "\(Int(sender.value))"
        calcTotal()

    }
    
    @IBAction func currencySegmentPresssed(_ sender: UISegmentedControl) {
        calcTotal()
    }
    
}

