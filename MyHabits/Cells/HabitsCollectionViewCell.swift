
import UIKit

class HabitsCollectionViewCell: UICollectionViewCell {
    
     var habit: Habit? {
        didSet {
            habitName.text = habit?.name
            habitName.textColor = habit?.color
            habitTime.text = habit?.dateString
            takenHabits.text = "Счётчик: \(String(describing: habit!.trackDates.count))"
            check.layer.borderColor = habit?.color.cgColor
            switch habit?.isAlreadyTakenToday {
            case true:
                self.check.backgroundColor = habit?.color
            default:
                self.check.backgroundColor = . white
            }
        }
    }
    
    var habitInCollection = {}
    
    var habitName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    var habitTime: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.systemGray2
        return label
    }()
    
    var takenHabits: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor.systemGray2
        return label
    }()
    
    var check: UIButton = {
        let image = UIButton()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.setImage(UIImage(systemName: "checkmark"), for: .normal)
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        image.layer.cornerRadius = 19
        image.layer.borderWidth = 2
        image.tintColor = .white
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = .white
        
        addSubviewsAndConstraints()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapCheck) )
        check.addGestureRecognizer(gesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
    }
    
    @objc func tapCheck() {
        switch habit!.isAlreadyTakenToday {
        case false:
            self.check.backgroundColor = habit?.color
            HabitsStore.shared.track(habit!)
            takenHabits.text = "Счётчик: \(String(describing: habit!.trackDates.count))"
            habitInCollection()
        case true:
            print("Привычка выполнена")
        }
    }
}

extension HabitsCollectionViewCell {
    func addSubviewsAndConstraints() {
        [habitName,habitTime,takenHabits,check] .forEach {contentView.addSubview($0)}
        
        let constraints = [
            habitName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            habitName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            habitName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -103),
            
            habitTime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            habitTime.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: 5),
            
            takenHabits.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            takenHabits.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 92),
            
            check.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 46),
            check.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            check.widthAnchor.constraint(equalToConstant: 38),
            check.heightAnchor.constraint(equalToConstant: 38)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
