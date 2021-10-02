import ArgumentParser
import Darwin

// A great way to manage what the string arguments are.. with enums
enum Placement: String, ExpressibleByArgument {
    case face = "face"
    case forearm = "forearm"
    case waist = "waist"
    case bicep = "bicep"
    
}

struct Bodymap: ParsableCommand {
    @Option(help: "Where on the body the augmentation should be placed.")
    var placement: Placement
    
    @Option(help: "Weight of the augmentation in lbs.")
    var weight: Float

    mutating func run() throws {
        
        switch placement {
        case .forearm :
            switch weight {
            case 0..<0.5:
                print("Wearable of " + weight.description + " lbs fits on the " + placement.rawValue);
                Bodymap.exit(withError: nil)
            default :
                print("No data supporting placement of the wearable so heavy on that location. Weight: " + String(weight) + " Placement: " + placement.rawValue);
                _exit(1)
            }
        case .face :
            if (weight < 0.5) {
                Bodymap.exit(withError: nil)
            }
            else {
                _exit(1)
            }
        case .bicep :
            switch weight {
            case 0..<5:
                print("Wearable of " + weight.description + " lbs fits on the " + placement.rawValue);
                Bodymap.exit(withError: nil)
            default :
                print("No data supporting placement of the wearable so heavy on that location. Weight: " + String(weight) + " Placement: " + placement.rawValue);
                _exit(1)
            }
        case .waist :
            Bodymap.exit(withError: nil)
        }
    }
}

Bodymap.main()
