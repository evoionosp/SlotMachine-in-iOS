//
//  ViewController.swift
//  SlotMachine
//
//  Created by Shubh Patel on 2019-01-15.
//  Copyright © 2019 Shubh Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
   
    
   
    
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var wonLabel: UILabel!
    @IBOutlet weak var same2: UILabel!
    @IBOutlet weak var jackpot: UILabel!
    
    
    var imageArray = [String]()
    var dataArray1 = [Int]()
    var dataArray2 = [Int]()
    var dataArray3 = [Int]()
    
    var credit = 100
    var won = 0
    var spent = 0
    
    @IBAction func buttonClicked(sender: AnyObject) {
        
        let bet = sender.tag
        if (credit >= bet!){
            credit -= bet!
            spent += bet!
        pickerView.selectRow(Int(arc4random_uniform(1000))%94 + 3, inComponent: 0, animated: true)
        pickerView.selectRow(Int(arc4random_uniform(1000))%94 + 3, inComponent: 1, animated: true)
        pickerView.selectRow(Int(arc4random_uniform(1000))%94 + 3, inComponent: 2, animated: true)
        
        
        
        if(dataArray1[pickerView.selectedRow(inComponent: 0)] == dataArray2[pickerView.selectedRow(inComponent: 1)] && dataArray2[pickerView.selectedRow(inComponent: 1)] == dataArray3[pickerView.selectedRow(inComponent: 2)]) {
            credit += (500 + spent*2)
            spent = 0;
            won += (500 + spent*2)
            print("Won: "+won.description)
        } else if(dataArray1[pickerView.selectedRow(inComponent: 0)] == dataArray2[pickerView.selectedRow(inComponent: 1)] || dataArray2[pickerView.selectedRow(inComponent: 1)] == dataArray3[pickerView.selectedRow(inComponent: 2)] || dataArray3[pickerView.selectedRow(inComponent: 2)] == dataArray1[pickerView.selectedRow(inComponent: 0)]) {
            credit += (50 + spent/5)
            spent = 0;
            won += (50 + spent/5)
            print("Won: "+won.description)
        }
        
        updateLabel()
        } else {
            let alert = UIAlertController(title: "Oops...", message: "No enough credit! Do you want to load money from your Credit card ?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                self.credit += 100
            }))
            alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { action in
               // exit(0)
            }))
            
            self.present(alert, animated: true)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        
        if component == 0{
            pickerLabel.text = imageArray[(Int)(dataArray1[row])]
        } else if component == 1 {
            pickerLabel.text = imageArray[(Int)(dataArray2[row])]
        } else {
            pickerLabel.text = imageArray[(Int)(dataArray3[row])]
        }
        
        pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 80)
        pickerLabel.textAlignment = NSTextAlignment.center
        
        return pickerLabel
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
   
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imageArray = ["🍎","😍","🐮","🐼","🐔","⛄️","🚘","❤️","🎂","👻"]
        
        for _ in 0..<100
        {
            dataArray1.append((Int)(arc4random_uniform(100) % 10))
            dataArray2.append((Int)(arc4random_uniform(100) % 10))
            dataArray3.append((Int)(arc4random_uniform(100) % 10))
        }
        
        updateLabel()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.isUserInteractionEnabled = false
        
    }
    
    func updateLabel() {
        creditLabel.text = "$ "+credit.description
        wonLabel.text = "$ "+won.description
        let jamt = 500 + spent*2
        let any2amt = 50 + spent/5
        jackpot.text = "$ "+jamt.description
        same2.text = "$ "+any2amt.description
        
    }


}

