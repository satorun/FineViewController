# FineViewController
 FineViewController is a micro library that lets you know the screen display timing in a simple way.
 
# Usage
## Extends FineViewController and Override methods
```
import FineViewController

class ViewController: FineViewController {

    override func viewDidShow(timing: FineViewController.ShowTiming) {
        print("\(self) did show: \(timing)")
    }
    
    override func viewDidHide(timing: FineViewController.HideTiming) {
        print("\(self) did hide: \(timing)")
    }
}
```
## Timings
```
    public enum ShowTiming {
        case firstTime
        case normal // pushViewController, presenteViewController etc.
        case fromBackground
        case fromModalDismissing
    }
    
    public enum HideTiming {
        case coverredWithModal
        case normal // dismissViewController, popViewController etc.
        case enterBackground
    }
```

# License
FineViewController is released under the MIT license. See LICENSE for details.
