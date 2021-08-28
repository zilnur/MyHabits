
import UIKit

class TodayProgressCollectionViewCell: UICollectionViewCell {

    var everythingWillWorkOut: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Всё получится!"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor.systemGray
        return label
    }()
    
    let progress: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.tintColor = UIColor(named: "Color")
        progress.trackTintColor = .systemGray
        return progress
    }()
    
    let labelProgress: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor.systemGray
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviewsAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15
        labelProgress.text = "\(Int(HabitsStore.shared.todayProgress * 100))%"
        progress.setProgress(HabitsStore.shared.todayProgress, animated: true)
    }
}

extension TodayProgressCollectionViewCell {
    func addSubviewsAndConstraints() {
        [everythingWillWorkOut,progress,labelProgress] .forEach {contentView.addSubview($0)}
        
        let constraints = [
            everythingWillWorkOut.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            everythingWillWorkOut.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            progress.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progress.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 38),
            progress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            labelProgress.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            labelProgress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
