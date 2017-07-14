//
//  ViewController.swift
//  SportsApp
//
//  Created by Strongman on 7/13/17.
//  Copyright © 2017 Ilya. All rights reserved.
//

import UIKit

class NewPlayerVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var flagPickerView: UIPickerView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtHeight: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(newPlayer))
        
        
        flagPickerView.delegate = self;
        flagPickerView.dataSource = self;
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newPlayer(sender: UIBarButtonItem) {
        if (txtName.text?.characters.count == 0) {
            let alert = UIAlertController(title: "Warning", message: "Please input player's name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return;
        }
        
        if (txtAge.text?.characters.count == 0 || Int(txtAge.text!) == nil) {
            let alert = UIAlertController(title: "Warning", message: "Please input player's age", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return;
        }
        
        if (txtHeight.text?.characters.count == 0 || Float(txtHeight.text!) == nil) {
            let alert = UIAlertController(title: "Warning", message: "Please input player's height", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return;
        }
        
        if (txtWeight.text?.characters.count == 0 || Float(txtWeight.text!) == nil) {
            let alert = UIAlertController(title: "Warning", message: "Please input player's weight", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return;
        }
        
        let player = Player();
        player.name = txtName.text;
        player.age = Int(txtAge.text!)!;
        player.height = Float(txtHeight.text!)!
        player.weight = Float(txtWeight.text!)!
        player.country = DataManager.countries[flagPickerView.selectedRow(inComponent: 0)]
        DataManager.sharedInstance.newPlayer(player: player)
        
        navigationController?.popViewController(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DataManager.countries.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30;
    }
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: pickerView.bounds.width - 30, height: 30)))
        let flagImageView = UIImageView(frame: CGRect(origin: CGPoint(x:view.bounds.width / 2 - 15, y: 0) , size: CGSize(width: 25, height: 25)))
        flagImageView.image = UIImage(named: DataManager.flags[DataManager.countries[row]]!)
        view.addSubview(flagImageView);
        return view;
    }
    
    func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.contentScrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.contentScrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.contentScrollView.contentInset = contentInset
    }
}

