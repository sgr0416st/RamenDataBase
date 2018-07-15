import UIKit
import SnapKit

class AddRamenDataViewController: UIViewController, UITextFieldDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate  {
    
    var shopName: String? = nil
    let titleName: String? = nil
    var image: UIImage? = nil
    var noImage: UIImage? = nil
    
    var contentView: UIView! = nil
    var NoodleNameTF: UITextField! = nil
    var imageBtn: UIButton! = nil
    var commentBtn: UIButton! = nil
    var OKBtn: UIButton! = nil
    
    //var addRamenDataView: AddRamenDataView!
    var pickerView: UIImagePickerController?
    
    var nextBtn: UIBarButtonItem!
    var backBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        //set up navigation bar
        self.navigationItem.title = titleName
        self.nextBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.onClick))
        self.backBtn = UIBarButtonItem(title: "back", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = self.backBtn
        self.navigationItem.rightBarButtonItem = nextBtn
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(view) // => IMPORTANT: this makes the width of the contentview static (= size of the screen), while the contentview will stretch vertically
        }
        
        NoodleNameTF = UITextField()
        contentView.addSubview(NoodleNameTF)
        NoodleNameTF.placeholder = "商品名を入力してください"
        self.NoodleNameTF.textAlignment = .center
        
        NoodleNameTF.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentView).inset(20) // left/right padding 20pt
            make.top.equalTo(contentView).offset(20) // attached to the top of the contentview with padding 20pt
        }
        
        self.imageBtn = UIButton()
        self.noImage = UIImage(named: "NoImage.jpg")
        self.imageBtn.setImage(self.noImage, for: .normal)
        self.imageBtn.imageView?.contentMode = .scaleAspectFit
        self.imageBtn.contentHorizontalAlignment = .fill
        self.imageBtn.contentVerticalAlignment = .fill
        contentView.addSubview(self.imageBtn)
        imageBtn.snp.makeConstraints { (make) in
            make.height.equalTo(self.imageBtn.snp.width)
            make.left.right.equalTo(contentView).inset(20) // left/right padding 20pt
            make.top.equalTo(self.NoodleNameTF.snp.bottom).offset(20) // attached to the top of the contentview with padding 20pt
        }
        
        self.commentBtn = UIButton()
        self.commentBtn.setTitle("コメントを入力してください", for: .normal)
        self.commentBtn.backgroundColor = UIColor.yellow
        contentView.addSubview(self.commentBtn)
        commentBtn.snp.makeConstraints { (make) in
            make.height.equalTo(self.commentBtn.snp.width).multipliedBy(1.25)
            make.left.right.equalTo(contentView).inset(20) // left/right padding 20pt
            make.top.equalTo(self.imageBtn.snp.bottom).offset(20) // attached to the top of the contentview with padding 20pt
        }
        
        self.OKBtn = UIButton()
        self.OKBtn.setTitle("OK", for: .normal)
        self.OKBtn.backgroundColor = UIColor.black
        contentView.addSubview(self.OKBtn)
        OKBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentView).inset(20) // left/right padding 20pt
            make.top.equalTo(self.commentBtn.snp.bottom).offset(20) // attached to the top of the contentview with padding 20pt
            make.bottom.equalTo(contentView).offset(-20) // attached to the bottom of the contentview with padding 20pt

        }
        
        self.imageBtn.addTarget(self, action: #selector(self.choosePicture), for: .touchUpInside)
        self.commentBtn.addTarget(self, action: #selector(self.setComment), for: .touchUpInside)
        
        self.pickerView = UIImagePickerController()
        scrollView.delegate = self
        self.pickerView?.delegate = self
        self.NoodleNameTF.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func choosePicture(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.pickerView?.sourceType = .photoLibrary
            self.present(self.pickerView!, animated: true)
        }
    }
    // 写真を選んだ後に呼ばれる処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.imageBtn.setImage(self.image, for: UIControlState())
        self.dismiss(animated: true)
    }
    
    @objc func setComment(_ sender: UIButton) {
        
    }
    
    @objc func onClick() {
        // confirm using alert view
        let alert = UIAlertController(title: "確認", message: "この内容で登録してもよろしいですか？", preferredStyle: .alert)
        //ok -> add data and move list view
        let okButton = UIAlertAction(title: "OK", style: .default, handler:{(action: UIAlertAction) -> Void in
            //add data
            
            
            //move view
            self.navigationController?.popToRootViewController(animated: false)
        })
        let cancelButton = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        //make button for alert
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        
        //move to alert view
        present(alert, animated: true, completion: nil)
        
        
        
    }
}
