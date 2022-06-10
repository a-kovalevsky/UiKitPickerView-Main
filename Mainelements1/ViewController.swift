//
//  ViewController.swift
//  Mainelements1
//
//  Created by andrew on 26.04.22.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var uiElements = ["UISegmentedControl",
                      "UILabel",
                      "UISlider",
                      "UIDatePicker",
                      "UITextField",
                      "UIDoneButton"] //массив всех элеменов создаем
    
    var selectedElement:String?

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var labelSwitch: UILabel!
    
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2
        label.font = label.font.withSize(35)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = String(slider.value)
        
        segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: true)
        
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .blue
        slider.thumbTintColor = .black
        
        datePicker.locale = Locale(identifier: "ru_RU")
        
        choiceUIElement()//вызов метода на замену клавы
        createToolBar()//вызов метода для тулбара над замененной клавиатуре,не забывай вызывать методы когда их создаешь для чего-либо
    }
    func hideAllElements() {
        segmentedControl.isHidden = true
        label.isHidden = true
        slider.isHidden = true
        datePicker.isHidden = true
        doneButton.isHidden = true
    }//объявили фукнцию , в которой обращаекмся к каждому аутлету и делаем его скрытым
        
    func choiceUIElement () {//также необходимо подключить делегат пикера(проткоол) через экстэншн лучше всего или напрямую к классу )
        let elementPicker = UIPickerView()
        elementPicker.delegate = self //назначаем делегатом (фактически передает ответсвенность (можем юзать функции когда является делегатом протокола и тп,но тут гляди конкретно к одной переменной
        name.inputView = elementPicker //кастом инпут вью, тоесть фактически замены классической клавы ,вылетающей на текст филд
        
        //custom
        elementPicker.backgroundColor = .systemOrange
        
    }//метод для того,чтоб вместо клавиатуры вылетел uipicker view
    
    func createToolBar () {
        let toolBar = UIToolbar() //создаем экземпляр класса ,юи тулбар как надстройка типа нашего элемента замены клавиатуры , можно делать разные
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeybord) )//создаем саму кнопку типа барбатонитем и не через интерфейс билдер,а напрямую в коде ето все настриваем,также тут в экшене вызывается отдельная функция для скрытия клавиатуры,ее можно по-разному написать !!!!!!!селектор  принимает функцию objectiveC, не забудь указать при ее создании @objc
        toolBar.setItems([doneButton], animated: true)//размещаем кнопку в тулбаре,можно несколько объектов,так как массив,можно разные кнопки.
        toolBar.isUserInteractionEnabled = true//позволяем взаимодействовать с элементом
        name.inputAccessoryView = toolBar//добавляем как бы етот тулбар на замененную клавиатуру
        
        //customization
        toolBar.tintColor = .white //шрифт
        toolBar.barTintColor = .systemOrange //бэкграунд
        
    }//cоздаем ету кнопку над пикервью ,done,чтоб закрывать клавиатуру,
    @objc func dismissKeybord() {//objc когда обращаемся к селектору
        view.endEditing(true)
    }
    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
        label.isHidden = false
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            label.text = "The first segment is selected"
            label.textColor = .red
        case 1:
            label.text = "The second segment is selected"
            label.textColor = .yellow
        case 2:
            label.text = "The third segment is selected"
            label.textColor = .black
        default:
            print("Something went wrong")
            label.text = "something went wrong"
        }
    }
    @IBAction func sliderAction(_ sender: UISlider) {
        label.text = String(slider.value)
        let backgroungcolor = self.view.backgroundColor
        self.view.backgroundColor = backgroungcolor?.withAlphaComponent(CGFloat(slider.value))
    }
    @IBAction func donePressed(_ sender: UIButton) {
        guard name.text?.isEmpty == false else {return}
        let check = name.text
        let numberOfChar = NSCharacterSet.decimalDigits
        if ((check?.rangeOfCharacter(from: numberOfChar)) != nil){
            let alert = UIAlertController(title: "Wrong Format", message: "Please enter your name", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            print("Name format is wrong")
        } else {
        label.text = name.text
        name.text = nil
    }
    }
    @IBAction func datePickerAct(_ sender: UIDatePicker) {
        
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .medium
        dateFormat.locale = Locale(identifier: "ru_RU")
        let dateValue = dateFormat.string(from: sender.date).capitalized
       
        label.text = dateValue
        
    }
    @IBAction func switchOFF(_ sender: UISwitch) {
            label.isHidden = !label.isHidden
            slider.isHidden = !slider.isHidden
            name.isHidden = !name.isHidden
            doneButton.isHidden = !doneButton.isHidden
            datePicker.isHidden = !datePicker.isHidden
        if sender.isOn {
            labelSwitch.text = "При нажатии все элементы появятся"
        } else {
            labelSwitch.text = "Скрыть все элементы"
        }
    }
   
}
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 //количесвто барабанов
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        uiElements.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        uiElements[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedElement = uiElements[row]
        name.text = selectedElement
        
        switch row {
        case 0:
            hideAllElements()
            segmentedControl.isHidden = false
        case 1:
            hideAllElements()
            label.isHidden = false
        case 2:
            hideAllElements()
            slider.isHidden = false
        case 3:
            hideAllElements()
            datePicker.isHidden = false
        case 4:
            hideAllElements()
            hideAllElements()
        case 5:
            hideAllElements()
            doneButton.isHidden = false
        default: hideAllElements()
        }
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerViewLabel = UILabel()
        
        if let currentLabel = view as? UILabel {
            pickerViewLabel = currentLabel
        } else {
            pickerViewLabel = UILabel()
        }
        
        pickerViewLabel.textColor = .white //ну и собстна настраиваем лэйбл
        pickerViewLabel.textAlignment = .center
        pickerViewLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 23)
        pickerViewLabel.text = uiElements[row] //присваиваем и пересоздаем как будет выглядеть внешний вид пикер вью и присвоили собственно массив с выборами

        
        return pickerViewLabel
    }
}
