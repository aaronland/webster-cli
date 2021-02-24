import Foundation
import ArgumentParser
import Webster

public enum Errors: Error {
    case invalidURL
}

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

    @Option(help: "The bleed (in inches) for each page in your document.")
    var bleed: Double = 0.0
    
    func run() {
        
        var source_url: URL!
        var target_url: URL!
        
        let source_result = newURL(url: source)
        
        switch source_result {
        case .failure(let error):
            fatalError(error.localizedDescription)
        case .success(let u):
            source_url = u
        }
        
        let target_result = newURL(url: destination)
        
        switch target_result {
        case .failure(let error):
            fatalError(error.localizedDescription)
        case .success(let u):
            target_url = u
        }
        
        let w = Webster()
        
        w.dpi = dpi
        w.width = width
        w.height = height
        w.margin = margin
        w.bleed = bleed
	
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
    
    private func newURL(url: String) -> Result<URL, Error> {
        
        guard var u = URL(string: url) else {
            return .failure(Errors.invalidURL)
        }
        
        
        if u.scheme == nil {
            
            let new_url = "file://" + u.absoluteString
            
            guard let new_u = URL(string: new_url) else {
                return .failure(Errors.invalidURL)
            }
            
            u = new_u
        }
        
        return .success(u)
    }
}

WebsterCLI.main()
