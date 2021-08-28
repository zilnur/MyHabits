
import UIKit

class InfoViewController: UIViewController {

    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .white
        return scroll
    }()
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    let titleInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Привычка за 21 день"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    let info: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =  """
            Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:
                    
            1. Провести 1 день без обращения
            к старым привычкам, стараться вести себя так, как будто цель, загаданная
            в перспективу, находится на расстоянии шага.

            2. Выдержать 2 дня в прежнем состоянии самоконтроля.

            3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче,
            с чем еще предстоит серьезно бороться.

            4. Поздравить себя с прохождением первого серьезного порога в 21 день.
            За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.

            5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.

            6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.

            """
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Информация"
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(info)
        contentView.addSubview(titleInfo)
        
        
        let constraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleInfo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            titleInfo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 22),
            titleInfo.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            
            info.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            info.topAnchor.constraint(equalTo: titleInfo.bottomAnchor, constant: 16),
            info.trailingAnchor.constraint(equalTo:scrollView.trailingAnchor, constant: -16),
            info.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

