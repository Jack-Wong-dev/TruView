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
        tb.backgroundColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
        tb.isTranslucent = true
        tb.items = [cancelButton]
        tb.isHidden = true
        return tb
    }()
    
    lazy var editorView: EditorView = {
        let editorV = EditorView(frame: view.frame, graph: selectedGraph, room: selectedRoom)
        return editorV
    }()
    
    lazy private var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        button.isEnabled = false
        button.tintColor = .systemGreen
        return button
    }()
        
    var fab = Floaty()
    
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
        layoutFAB()
        addSubviews()
        setConstraints()
        editorView.toolbar = toolbar
//        fab.addDragging()
    }
    
    private func addSubviews(){
        view.addSubview(editorView)
        view.addSubview(toolbar)
        view.addSubview(fab)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

}

//MARK:- Panoramic Methods
extension TourEditorVC{
    
    @objc private func cancelButtonTapped(){
        editorView.hideToast()
        editorView.hudToggle = .hide
        editorView.tapPurpose = .selectNode
        self.view.makeToast("Canceled")
    }
    
    @objc func exitEditor(){
        self.dismiss(animated: true, completion: nil)
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
            toolbar.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.toolbar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.toolbar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.toolbar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}

extension TourEditorVC: FloatyDelegate {
    
    func layoutFAB() {
        fab.buttonColor = .green
        fab.selectedColor = .yellow
        fab.hasShadow = true
        
        fab.addItem(title: "Add Hotspot") { (item) in
            self.editorView.displayRoomList()
        }
        
        fab.addItem(title: "Change Camera Position") { (item) in
            
        }
        
        fab.addItem(title: "Exit Editor") { (item) in
            self.dismiss(animated: true, completion: nil)
        }
        
        fab.fabDelegate = self
    }
    
    // MARK: - Floaty Delegate Methods
    func floatyWillOpen(_ floaty: Floaty) {
        print("Floaty Will Open")
    }
    
    func floatyDidOpen(_ floaty: Floaty) {
        print("Floaty Did Open")
    }
    
    func floatyWillClose(_ floaty: Floaty) {
        print("Floaty Will Close")
    }
    
    func floatyDidClose(_ floaty: Floaty) {
        print("Floaty Did Close")
    }
    
}


