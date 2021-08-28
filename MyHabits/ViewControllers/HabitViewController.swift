
import UIKit

class HabitViewController: UIViewController {

    private var  habit: Habit?
        
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var habitName: UILabel = {
       let label = UILabel()
        label.text = "Название"
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var habitNameEdit: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.text = nil
        return textField
    }()
    
    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Цвет"
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        return label
    }()
    
    private lazy var colorEditButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toColorPick), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.backgroundColor = .systemIndigo
        return button
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Время"
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        return label
    }()
    
    private lazy var timeCurentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        label.text = "Каждый день в "
        return label
    }()
    
    private lazy var timeEditLabel: UILabel = {
        let label = UILabel()
        label .translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "Color")
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        label.text = "17:00"
        return label
    }()
    
    private lazy var timeEdit: UIDatePicker = {
        let date = UIDatePicker()
        date.datePickerMode = .time
        date.locale = Locale(identifier: "ru_RU")
        date.preferredDatePickerStyle = .wheels
        date.translatesAutoresizingMaskIntoConstraints = false
        date.addTarget(self, action: #selector(toSetTime), for: .valueChanged)
        return date
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(tapDeleteButton), for: .touchUpInside)
        return button
    }()
    
    var habitRemove = {}
    
    
    init(habit: Habit?) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationConfig()
        addViewsAndConstraints()
        deleteButtonConfig()
        
        if let habit = habit {
            habitNameEdit.text = habit.name
            colorEditButton.backgroundColor = habit.color
            timeEdit.setDate(habit.date, animated: true)
            toSetTime()
        }
    }
    
    @objc func closeHdbitVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @ objc func saveHabit() {
        if habit == nil {
            if habitNameEdit.text != "" {
                let habit = Habit(name: habitNameEdit.text! , date: timeEdit.date, color: colorEditButton.backgroundColor!)
                let store = HabitsStore.shared
                store.habits.append(habit)
                self.dismiss(animated: true, completion: nil)
            } else {
                habitNameEdit.placeholder = "Введите название привычки"
                UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: []) {
                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                        self.habitNameEdit.backgroundColor = .red
                    }
                    UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.5) {
                        self.habitNameEdit.backgroundColor = .white
                    }
                }
            }
        } else {
            let index = HabitsStore.shared.habits.firstIndex(of: habit!)
            habit!.name = habitNameEdit.text!
            habit!.color = colorEditButton.backgroundColor!
            habit!.date = timeEdit.date
            HabitsStore.shared.habits[index!] = habit!
            dismiss(animated: true, completion: nil)
        }
        
    }
    @objc func toColorPick() {
        let colorPick = UIColorPickerViewController()
        colorPick.delegate = self
        colorPick.modalTransitionStyle = .coverVertical
        colorPick.modalPresentationStyle = .automatic
        self.present(colorPick, animated: true, completion: nil)
    }
    
    @objc func toSetTime() {
        let date = DateFormatter()
        date.timeStyle = .short
        date.locale = Locale(identifier: "Ru_ru")
        self.timeEditLabel.text = date.string(from: timeEdit.date)
    }
    
    @ objc func deleteHabit() {
        HabitsStore.shared.habits.removeAll{$0 == self.habit}
        self.dismiss(animated: true, completion: nil)
        habitRemove()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(scrollView.contentSize)
    }
}

extension HabitViewController {
    func navigationConfig() {
        if habit == nil {
            navigationItem.title = "Создать"
        } else {
            navigationItem.title = "Править"
        }
        let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(closeHdbitVC))
        cancelButton.tintColor = UIColor(named: "Color")
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveHabit))
        saveButton.tintColor = UIColor(named: "Color")
        self.navigationItem.rightBarButtonItem = saveButton
    }
}

extension HabitViewController {
    private func addViewsAndConstraints() {
        self.view.backgroundColor = .white
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        [habitName,habitNameEdit,colorLabel,colorEditButton,timeLabel,timeCurentLabel,timeEditLabel,timeEdit,deleteButton].forEach {self.contentView.addSubview($0)}
        
        let constraints = [
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),

            self.habitName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.habitName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 21),
            self.habitName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -285),
//            self.habitName.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -675),

            self.habitNameEdit.leadingAnchor.constraint(equalTo: self.habitName.leadingAnchor),
            self.habitNameEdit.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 46),

            self.colorLabel.leadingAnchor.constraint(equalTo: self.habitName.leadingAnchor),
            self.colorLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 83),

            self.colorEditButton.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16),
            self.colorEditButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 108),
            self.colorEditButton.widthAnchor.constraint(equalToConstant: 30),
            self.colorEditButton.heightAnchor.constraint(equalToConstant: 30),

            self.timeLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.timeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 153),
            self.timeLabel.widthAnchor.constraint(equalToConstant: 100),
            self.timeLabel.heightAnchor.constraint(equalToConstant: 18),

            self.timeCurentLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16),
            self.timeCurentLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 178),

            self.timeEditLabel.leadingAnchor.constraint(equalTo: self.timeCurentLabel.trailingAnchor),
            self.timeEditLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 178),

            self.timeEdit.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.timeEdit.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 215),
            self.timeEdit.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -259),

            self.deleteButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.deleteButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.deleteButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension HabitViewController {
    func deleteButtonConfig() {
        if habit == nil {
            deleteButton.isHidden = true
        } else {
            deleteButton.isHidden = false
        }
    }
     @objc func tapDeleteButton() {
        let alertVC = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \(habit!.name)?", preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let delete = UIAlertAction(title: "Удалить", style: .destructive) {UIAlertAction in self.deleteHabit()}
        alertVC.addAction(cancel)
        alertVC.addAction(delete)
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.colorEditButton.backgroundColor = viewController.selectedColor
    }
}


//Клавиатура:
private extension HabitViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
}

extension HabitViewController: UITextFieldDelegate {
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        habitName.resignFirstResponder()
        return true
    }
}
