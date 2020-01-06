//
//  ViewController.swift
//  26HWControlsSwift
//
//  Created by Сергей on 16.12.2019.
//  Copyright © 2019 Sergei. All rights reserved.
//

import UIKit

//Такой вот на мой взгляд получился простенький урок, но все равно нужно практиковаться.
//
//Будем делать небольшое приложение:
//
//Мы будем применять анимации к тестируемой вьюхе
//
//Ученик.
//
//1. Расположите тестируюмую вьюху на верхней половине экрана
//2. На нижней половине создайте 3 свича: Rotation, Scale, Translation. По умолчанию все 3 выключены
//3. Также создайте сладер скорость, со значениями от 0.5 до 2, стартовое значение 1
//4. Создайте соответствующие проперти для свитчей и слайдера, а также методы для события valueChanged
//
//Студент.
//
//5. Добавьте сегментед контрол с тремя разными сегментами
//6. Они должны соответствовать трем разным картинкам, которые вы должны добавить
//7. Когда переключаю сегменты, то картинка должна меняться на соответствующую
//
//Мастер.
//
//8. Как только мы включаем один из свичей, наша вьюха должна начать соответствующую анимацию
//(либо поворот, либо скеил, либо перенос). Используйте свойство transform из урока об анимациях
//9. Так же следует помнить, что если вы переключили свич, но какойто другой включен одновременно с ним, то вы должны делать уже двойную анимацию. Например и увеличение и поворот одновременно (из урока про анимации)
//10. Анимации должны быть бесконечно повторяющимися, единственное что их может остановить, так это когда все три свича выключены
//
//Супермен.
//
//11. Добавляем использование слайдера. Слайдер регулирует скорость. То есть когда значение на 0.5, то скорость анимаций должна быть в два раза медленнее, а если на 2, то в два раза быстрее обычной.
//12. Попробуйте сделать так, чтобы когда двигался слайдер, то анимация обновлялась без прерывания, а скорость изменялась в соответствующую сторону.
//1значение скорости анимации нужно делить на значение слайдела
//2добавить в функции по анимациям атрибут speedAnimation
//3в значение дуратион добавляем текущаая скорость делимая на скорость анимации
//Такое вот задание :)

//1первая тема успех
//2вторая тема космос
//3добавить imageView on view

//задание 13
//1 при запуске приложения тема нитральная (никаких картинок)
//1.1 картинки и заставка устанавливается только когда выбрана тема
//2 при нажатии на сегмент контрол для выбора темы картинки и текст меняются в соответствии с темой
//3 текст в приложении красного цвета

class ViewController: UIViewController {

    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var translationSwitch: UISwitch!
    @IBOutlet weak var rotationSwitch: UISwitch!
    @IBOutlet weak var scaleSwitch: UISwitch!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var changeImageSegmentedControl: UISegmentedControl!
    @IBOutlet weak var speedAnimationLabel: UILabel!
    @IBOutlet weak var translationValueLabel: UILabel!
    @IBOutlet weak var scaleValueLabel: UILabel!
    @IBOutlet weak var rotationValueLabel: UILabel!
    @IBOutlet var mainImageView: UIImageView?
    
    private var imageView: UIImageView?
    private var image: UIImage?
    private var makeAnimation = false
    private var mainImage: UIImage?
    private var topicImage: TopicImage = .none
    
    let titles = (none: "None", myCar: "My Car", myHome: "My Home", mySalary: "My salary", land: "Land", mars: "Mars", venus: "Venus")
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.mainImageView = UIImageView(frame: self.view.frame)
        self.view.insertSubview(self.mainImageView ?? UIImageView(), at: 0)
        self.testView.layer.masksToBounds = true
        self.testView.layer.cornerRadius = 200
        self.imageView = UIImageView(frame: self.testView.bounds)
        self.testView.addSubview(self.imageView ?? UIImageView())
        self.imageView?.image = UIImage(named: "none.jpeg")
        self.mainImageView?.image = UIImage(named: "colors")
        self.speedSlider.minimumValue = 0.5
        
    }

    //MARK: Action
    
    @IBAction func valueChangeSwitch(_ sender: UISwitch) {
        //если все свичи лож тогда мы не выполняем анимацию
        
        if !self.translationSwitch.isOn && !self.scaleSwitch.isOn &&
            !self.rotationSwitch.isOn {
            
            self.makeAnimation = false
            
        } else {
            
            self.makeAnimation = true
            
        }
        
        print("sender.tag = \(sender.tag), self..makeAnimation = \(self.makeAnimation)")
        
        switch sender.tag {
        case AnimationType.translation.rawValue where self.makeAnimation:
            self.translationAnimationIn(view: self.view, forView: self.testView, durationAnim: 1.0, activate: self.makeAnimation)
        case AnimationType.scale.rawValue where self.makeAnimation:
            print("AnimationType.scale.rawValue where self.makeAnimation = \(self.makeAnimation)")
            self.scaleAnimationFor(view: self.testView, durationAnim: 2, activate: self.makeAnimation)
        case AnimationType.rontation.rawValue where self.makeAnimation:
            self.rotationAnimationFor(view: self.testView, durationAnim: 3, activate: self.makeAnimation)
        default:
            break
        }
        
    }
    
    //MARK: Slider
    
    @IBAction func valueChangeSlider(_ sender: UISlider) {
        
        self.speedAnimationLabel.text = String(format: "Value slider:  { %.2f }", sender.value)
        
    }
    
    //MARK: Segmented control image
    
    @IBAction func actionChangeImageSegmentedControl(_ sender: UISegmentedControl) {
        print("actionChangeImageSegmentedControl")
    
        switch sender.selectedSegmentIndex {
        
        case ImageNumber.first.rawValue where self.topicImage == .luck:
            self.imageView?.image = UIImage(named: "MyHome")
        case ImageNumber.first.rawValue where self.topicImage == .cosmoc:
                self.imageView?.image = UIImage(named: "land")
        case ImageNumber.second.rawValue where self.topicImage == .luck:
            self.imageView?.image = UIImage(named: "MyCar")
        case ImageNumber.second.rawValue where self.topicImage == .cosmoc:
            self.imageView?.image = UIImage(named: "Mars")
        case ImageNumber.third.rawValue where self.topicImage == .luck:
            self.imageView?.image = UIImage(named: "MySalary")
        case ImageNumber.third.rawValue where self.topicImage == .cosmoc:
            self.imageView?.image = UIImage(named: "Venus")
        default:
            break
            
        }
        
    }
    
    //MARK: Segmented control topic
    
        @IBAction func selectedTopicImage(sender: UISegmentedControl) {
        print("selectedTopicImage")
            self.topicImage = sender.selectedSegmentIndex == 0 ? TopicImage.luck : .cosmoc
            
            switch sender.selectedSegmentIndex {
            case TopicImage.none.rawValue:
                self.topicImage = .none
                self.imageView?.image = UIImage(named: "none.jpeg")
                self.mainImageView?.image = UIImage(named: "colors")
                self.changeImageSegmentedControl.setTitle(titles.none, forSegmentAt: 0)
                self.changeImageSegmentedControl.setTitle(titles.none, forSegmentAt: 1)
                self.changeImageSegmentedControl.setTitle(titles.none, forSegmentAt: 2)
            case TopicImage.cosmoc.rawValue:
                self.topicImage = .cosmoc
                self.mainImageView?.image = UIImage(named: "Galaxy")
                self.changeImageSegmentedControl.setTitle(titles.land, forSegmentAt: 0)
                self.changeImageSegmentedControl.setTitle(titles.mars, forSegmentAt: 1)
                self.changeImageSegmentedControl.setTitle(titles.venus, forSegmentAt: 2)
            case TopicImage.luck.rawValue:
                self.topicImage = .luck
                self.mainImageView?.image = UIImage(named: "Money")
                self.changeImageSegmentedControl.setTitle(titles.myHome, forSegmentAt: 0)
                self.changeImageSegmentedControl.setTitle(titles.myCar, forSegmentAt: 1)
                self.changeImageSegmentedControl.setTitle(titles.mySalary, forSegmentAt: 2)
            default:
                break
            }
            
            self.actionChangeImageSegmentedControl(self.changeImageSegmentedControl)

    }
    
    //MARK: Help function
    
    
    //MARK: Translation func
    private func translationAnimationIn(view: UIView, forView: UIView, durationAnim: Float, activate: Bool) {
        print("translationAnimationIn")
        
        let rect = CGRect(x: view.bounds.minX + forView.bounds.maxX, y: view.bounds.minY + forView.bounds.maxY, width: view.bounds.width - forView.bounds.width, height: view.bounds.height / 2)
        let randomX = CGFloat.random(in: rect.minX...rect.width)
        let randomY = CGFloat.random(in: rect.minY...rect.height)
        let animationSpeed = Double(durationAnim / self.speedSlider.value)
        
        self.out(value: animationSpeed, on: self.translationValueLabel, namedAnimation: "Translation")
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: animationSpeed, delay: 0.0, options: .beginFromCurrentState, animations: {
                
                //forView.transform = CGAffineTransform(translationX: randomX, y: randomY) // animation bad
                forView.center = CGPoint(x: randomX, y: randomY)
             
            }) { (finished) in
                
                activate && self.translationSwitch.isOn ? self.translationAnimationIn(view: view, forView: forView, durationAnim: durationAnim, activate: activate) : print("self.makeAnimation == \(self.makeAnimation)")
                
            }
        }
    }
    
    //MARK: Scale
    
    private func scaleAnimationFor(view: UIView, durationAnim: Float, activate: Bool) {
        print("scaleAnimationFor")
        
        let randomScale = CGFloat.random(in: 0.1...1.5)
        let animationSpeed = Double(durationAnim / self.speedSlider.value)
        
        self.out(value: animationSpeed, on: self.scaleValueLabel, namedAnimation: "Scale")
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: animationSpeed, delay: 0, options: .beginFromCurrentState, animations: {
                view.transform = CGAffineTransform(scaleX: randomScale, y: randomScale)
            }) { (finished) in
                activate && self.scaleSwitch.isOn ? self.scaleAnimationFor(view: view, durationAnim: durationAnim, activate: activate) : print("self.makeAnimation == \(self.makeAnimation)")
            }
        }
    }
    
    //MARK: Rotation
    
    func rotationAnimationFor(view: UIView, durationAnim: Float, activate: Bool) {
        print("rotationAnimationFor")
        
        let lower: UInt32 = 360
        let upper: UInt32 = 720
        let randomRotate = CGFloat(arc4random_uniform(upper - lower) + lower)
    
        let animationSpeed = Double(durationAnim / self.speedSlider.value)
        
        self.out(value: animationSpeed, on: self.rotationValueLabel, namedAnimation: "Rotation")
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: animationSpeed, delay: 0, options: .beginFromCurrentState, animations: {
                view.transform = CGAffineTransform(rotationAngle: randomRotate)
            }) { (finished) in
                activate && self.rotationSwitch.isOn ? self.rotationAnimationFor(view: view, durationAnim: durationAnim, activate: self.makeAnimation) : print("self.makeAnimation == \(self.makeAnimation)")
            }
        }
    }
    
    private func out(value: Double, on label: UILabel, namedAnimation: String) {
        
        label.text = String(format: "\(namedAnimation) speed:  { %.2f }", value)
        
    }

}

