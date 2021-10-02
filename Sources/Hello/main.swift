import ArgumentParser
import Darwin

// A great way to manage what the string arguments are.. with enums
enum Placement: String, ExpressibleByArgument {
    case forearm = "forearm"
    case waist = "waist"
    
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
            case 0..<51:
                print("Wearable of " + weight.description + " lbs fits on the " + placement.rawValue);
                Bodymap.exit(withError: nil)
            default :
                print("No data supporting placement of the wearable so heavy on that location. Weight: " + String(weight) + " Placement: " + placement.rawValue);
                _exit(1)
            }
        case .waist :
            switch weight {
            case 50:
                print("Wearable fits on the " + placement.rawValue);
            default :
                print("No data supporting placement of the wearable so heavy on that location. Weight: " + String(weight) + " Placement: " + placement.rawValue);
            }
        default:
            print("Placement unsupported. Placement " + placement.rawValue);
            break
            
        }
    }
}

Bodymap.main()
