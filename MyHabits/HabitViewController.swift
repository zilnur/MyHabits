//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Ильнур Закиров on 20.08.2021.
//

import UIKit

class HabitViewController: UIViewController {

    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let habitName: UILabel = {
       let label = UILabel()
        label.text = "Название"
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let habitNameEdit: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        return textField
    }()
    
    let colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Цвет"
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        return label
    }()
    
    let colorEditLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .orange
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Время"
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        return label
    }()
    
    let timeCurentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        return label
    }()
    
    public let timeEdit: UIDatePicker = {
        let dateFormatter = UIDatePicker()
        dateFormatter.translatesAutoresizingMaskIntoConstraints = false
        dateFormatter.datePickerMode = .time
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.backgroundColor = .white
        dateFormatter.tintColor = UIColor(named: "Color")
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Создать"
        
        self.timeCurentLabel.text = "Каждый день в "
        
        let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(closeHdbitVC))
        cancelButton.tintColor = UIColor(named: "Color")
        self.navigationItem.leftBarButtonItem = cancelButton
        
        addViewsAndConstraints()
    }
    
    @objc func closeHdbitVC() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension HabitViewController {
    private func addViewsAndConstraints() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        [habitName,habitNameEdit,colorLabel,colorEditLabel,timeLabel,timeCurentLabel,timeEdit].forEach {self.contentView.addSubview($0)}
        
        let constraints = [
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            self.contentView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            
            self.habitName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.habitName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 21),
            self.habitName.widthAnchor.constraint(equalToConstant: 200),
            self.habitName.heightAnchor.constraint(equalToConstant: 18),
            
            self.habitNameEdit.leadingAnchor.constraint(equalTo: self.habitName.leadingAnchor),
            self.habitNameEdit.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 46),
            self.habitNameEdit.widthAnchor.constraint(equalToConstant: 295),
            self.habitNameEdit.heightAnchor.constraint(equalToConstant: 22),
            
            self.colorLabel.leadingAnchor.constraint(equalTo: self.habitName.leadingAnchor),
            self.colorLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 83),
            self.colorLabel.widthAnchor.constraint(equalToConstant: 100),
            self.colorLabel.heightAnchor.constraint(equalToConstant: 18),
            
            self.colorEditLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.colorEditLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 108),
            self.colorEditLabel.widthAnchor.constraint(equalToConstant: 30),
            self.colorEditLabel.heightAnchor.constraint(equalToConstant: 30),
            
            self.timeLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.timeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 153),
            self.timeLabel.widthAnchor.constraint(equalToConstant: 100),
            self.timeLabel.heightAnchor.constraint(equalToConstant: 18),
            
            self.timeCurentLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.timeCurentLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 178),
            self.timeCurentLabel.widthAnchor.constraint(equalToConstant: 194),
            self.timeCurentLabel.heightAnchor.constraint(equalToConstant: 22),
            
            self.timeEdit.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.timeEdit.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 215),
            self.timeEdit.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.timeEdit.heightAnchor.constraint(equalToConstant: 216)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
