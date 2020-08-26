import Foundation
import ArgumentParser
import Webster

struct WebsterCLI: ParsableCommand {
    
    @Argument(help: "The URL you want to generate a PDF from.")
    var source: String
       
    @Argument(help: "The path where your PDF document will be created.")
    var destination: String
    
    @Option(help: "The DPI (dots per inch) of your output document.")
    var dpi: Double = 72.0
    
    @Option(help: "The width (in inches) of your document.")
    var width: Double = 8.5
    
    @Option(help: "The height (in inches) of your document.")
    var height: Double = 11.0
    
    @Option(help: "The margin (in inches) for each page in your document.")
    var margin: Double = 1.0
    
    func run() {
                
        guard let source_url = URL(string: source) else {
            fatalError("Invalid source URL.")
        }
          
        guard var target_url = URL(string: destination) else {
              fatalError("Invalid destination URL.")
        }

        if target_url.scheme == nil {
            
            let new_destination = "file://" + target_url.absoluteString
                        
            guard let new_target = URL(string: new_destination) else {
                fatalError("Invalid destination URL.")
            }
            
            target_url = new_target
        }
                
        let w = Webster()

        w.dpi = dpi
        w.width = width
        w.height = height
        w.margin = margin
        
        func on_complete(result: Result<Data, Error>) -> Void {
            
            switch result {
            case .failure(let error):
                fatalError("Failed to generate PDF file, \(error.localizedDescription)")
            case .success (let data):
     
                do {
                    try data.write(to: target_url)
                } catch (let error) {
                    fatalError("Failed to save PDF file, \(error.localizedDescription)")
                }
            }
        }
        
        w.render(source: source_url, completionHandler: on_complete)
    }
}

WebsterCLI.main()
