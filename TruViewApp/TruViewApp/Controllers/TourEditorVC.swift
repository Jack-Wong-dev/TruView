import UIKit

@objc public enum TapSelection: Int {
    case reposition
    case selectNode
    case createNode
    case createReverseNode
}

class TourEditorVC: UIViewController, UIToolbarDelegate {
    
    lazy private var toolbar: UIToolbar = {
        let tb = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
        tb.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        tb.backgroundColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
        tb.isTranslucent = true
        tb.items = [cancelButton, flexibleSpace, optionsButton]

        return tb
    }()
    
    lazy var editorView: EditorView = {
        let editorV = EditorView(frame: view.frame, graph: selectedGraph, room: selectedRoom)
        
        return editorV
    }()
    

        
    lazy private var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        button.isEnabled = false
        button.tintColor = .clear
        return button
    }()
    
    lazy private var flexibleSpace: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        return button
    }()
    
    lazy private var optionsButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(displayActionSheet(_:)))
           return button
    }()
 
    private var selectedGraph = Graph()
    var selectedRoom = Room()
    
    init(graph: Graph, room: Room) {
        print("super init")
        self.selectedGraph = graph
        self.selectedRoom = room
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func commonInit(){
        print("common init")
        addSubviews()
        setConstraints()
        editorView.toolbar = toolbar
    }
    
    private func addSubviews(){
        view.addSubview(editorView)
        view.addSubview(toolbar)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override var prefersStatusBarHidden: Bool {
      return true
    }
    
}

//MARK:- Panoramic Methods
extension TourEditorVC{

    @objc private func motionTypeTapped(){
        if editorView.controlMethod == .touch{
            editorView.controlMethod = .motion
        }else{
            editorView.controlMethod = .touch
        }
        editorView.hudToggle = .hide
    }
    
    @objc private func cancelButtonTapped(){
        editorView.hideToast()
        editorView.tapPurpose = .selectNode
        toolbar.items?[0].isEnabled = false
        toolbar.items?[0].tintColor = .clear
        editorView.makeToast("Cancelled")
    }
    
    @objc private func displayActionSheet(_ sender: UIBarButtonItem){

        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .alert)
  
        let addAction = UIAlertAction(title: "Add Hotspot", style: .default){
            (action) in
            self.editorView.displayRoomList()
        }
        
         let saveAction = UIAlertAction(title: "Save", style: .default)
         let exitAction = UIAlertAction(title: "Exit Editor", style: .destructive) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
         let cancel = UIAlertAction(title: "Cancel", style: .cancel)
  
         optionMenu.addAction(addAction)
         optionMenu.addAction(saveAction)
         optionMenu.addAction(exitAction)
        
         optionMenu.addAction(cancel)

         optionMenu.popoverPresentationController?.sourceView = self.view // works for both iPhone & iPad

         present(optionMenu, animated: true, completion: nil)
     }
    
}

//MARK:- Constraints
extension TourEditorVC {
    
    private func setConstraints() {
        setPanoViewConstraints()
        setToolbarConstraints()
    }
    
    private func setPanoViewConstraints(){
        self.editorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            editorView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.editorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.editorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.editorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
    }
    
    
    private func setToolbarConstraints(){
        self.toolbar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolbar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.toolbar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.toolbar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.toolbar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}


