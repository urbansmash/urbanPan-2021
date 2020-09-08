//
//  Document.swift
//  urbanPan
//
//  Created by Evan Murray on 6/10/20.
//  Copyright © 2020 Play it on Pan. All rights reserved.
//

import UIKit

class Document: UIDocument {
    
    override func contents(forType typeName: String) throws -> Any {
        return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        //Load your document from contents
    }
}
