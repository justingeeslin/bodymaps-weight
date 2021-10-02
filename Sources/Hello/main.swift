import ArgumentParser
import Darwin

// A great way to manage what the string arguments are.. with enums
enum Placement: String, ExpressibleByArgument {
    case forearm = "forearm"
    case waist = "waist"
    
}

struct Bodymap: ParsableCommand {
    @Option(help: "Where on the body the augmentation should be placed.")
    var placement: Placement?
    
    @Option(help: "Weight of the augmentation in lbs.")
    var weight: Float?

    mutating func run() throws {
        let theWeight = weight ?? 50;
        let thePlacement = placement ?? Placement.forearm;
        
        switch thePlacement {
        case .forearm :
            
            switch theWeight {
            case 0..<51:
                print("Wearable of " + theWeight.description + " lbs fits on the " + thePlacement.rawValue);
                Bodymap.exit(withError: nil)
            default :
                print("No data supporting placement of the wearable so heavy on that location. Weight: " + String(theWeight) + " Placement: " + thePlacement.rawValue);
                _exit(1)
            }
        case .waist :
            switch theWeight {
            case 50:
                print("Wearable fits on the " + thePlacement.rawValue);
            default :
                print("No data supporting placement of the wearable so heavy on that location. Weight: " + String(theWeight) + " Placement: " + thePlacement.rawValue);
            }
        default:
            print("Placement unsupported. Placement " + thePlacement.rawValue);
            break
            
        }
        
        if (theWeight < 0.5) {
            
        }
        else {
            
        }
    }
}

Bodymap.main()
