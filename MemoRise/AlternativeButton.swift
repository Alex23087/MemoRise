//
//  AlternativeButton.swift
//  MemoRise
//
//  Created by Alessandro Scala on 15/10/2018.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import UIKit

@IBDesignable
class AlternativeButton: UIButton {
    
    var alternateButton: AlternativeButton?;
    @IBInspectable var isSelectedByDefault: Bool = false;
    
    @IBInspectable var cornerRadius: CGFloat = 5;
    @IBInspectable var borderWidth: CGFloat = 2.0;
    @IBInspectable var masksToBounds: Bool = true;
    
    @IBInspectable var selectedColor: UIColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1);
    @IBInspectable var deselectedColor: UIColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1);
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.isSelected = isSelectedByDefault;
    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = cornerRadius;
        self.layer.borderWidth = borderWidth;
        self.layer.masksToBounds = masksToBounds;
    }
    
    func unselectAlternateButtons(){
        if alternateButton != nil {
            self.isSelected = true
            alternateButton?.isSelected = false;
        }else{
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton(){
        self.isSelected = !isSelected;
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = selectedColor.cgColor;
            } else {
                self.layer.borderColor = deselectedColor.cgColor;
            }
        }
    }
}
