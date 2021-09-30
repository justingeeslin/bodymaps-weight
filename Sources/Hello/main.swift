import ArgumentParser

struct Repeat: ParsableCommand {
    @Option(help: "Where on the body the augmentation should be placed. forearm")
    var placement: String?
    
    @Option(help: "Weight of the augmentation in lbs.")
    var weight: Float?

    mutating func run() throws {
        let theWeight = weight ?? 50;
        let thePlacement = placement ?? "forearm";
        
        if (theWeight < 0.5) {
            print("Wearable fits on the " + thePlacement);
        }
        else {
            print("No data supporting placement of the wearable so heavy on that location. Weight: " + String(theWeight) + " Placement: " + thePlacement);
        }
    }
}

Repeat.main()
