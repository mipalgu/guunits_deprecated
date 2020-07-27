import Foundation

let distanceGenerator = DistanceUnitsGenerator(unitDifference: [
    .millimetres: 10,
    .centimetres: 100
])
let timeGenerator = TimeUnitsGenerator(unitDifference: [
    .microseconds: 1000,
    .milliseconds: 1000
])
let angleGenerator = AngleUnitsGenerator()
let imageGenerator = ImageUnitsGenerator(unitDifference: [:])
let percentGenerator = PercentUnitGenerator(unitDifference: [:])

// C++ Variants
let cppHeaderDistanceGenerator = CPPDistanceUnitsGenerator()
let cppHeaderTimeGenerator = CPPTimeUnitsGenerator()
let cppHeaderAngleGenerator = CPPAngleUnitsGenerator()

let cppDistanceGenerator = CPPDistanceUnitsGenerator(definitionCreator: CPPFunctionDefinitionCreator(namespace: "GU::"))
let cppTimeGenerator = CPPTimeUnitsGenerator(definitionCreator: CPPFunctionDefinitionCreator(namespace: "GU::"))
let cppAngleGenerator = CPPAngleUnitsGenerator(definitionCreator: CPPFunctionDefinitionCreator(namespace: "GU::"))

let swiftFileCreator = SwiftFileCreator()

do {
    for unit in DistanceUnits.allCases {
        try swiftFileCreator.generate(for: unit).write(toFile: unit.description.capitalized + ".swift", atomically: true, encoding: .utf8)
    }
    for unit in TimeUnits.allCases {
        try swiftFileCreator.generate(for: unit).write(toFile: unit.description.capitalized + ".swift", atomically: true, encoding: .utf8)
    }
    for unit in AngleUnits.allCases {
        try swiftFileCreator.generate(for: unit).write(toFile: unit.description.capitalized + ".swift", atomically: true, encoding: .utf8)
    }
    for unit in ImageUnits.allCases {
        try swiftFileCreator.generate(for: unit).write(toFile: unit.description.capitalized + ".swift", atomically: true, encoding: .utf8)
    }
    for unit in PercentUnits.allCases {
        try swiftFileCreator.generate(for: unit).write(toFile: unit.description.capitalized + ".swift", atomically: true, encoding: .utf8)
    }
} catch let e {
    fatalError("Unable to write swift file: \(e)")
}

do {
    try HeaderCreator().generate(
            distanceGenerator: distanceGenerator,
            timeGenerator: timeGenerator,
            angleGenerator: angleGenerator,
            imageGenerator: imageGenerator,
            percentGenerator: percentGenerator
        ).write(
            to: URL(fileURLWithPath: "guunits.h", isDirectory: false),
            atomically: false,
            encoding: .utf8
        )
    try CFileCreator().generate(
            distanceGenerator: distanceGenerator,
            timeGenerator: timeGenerator,
            angleGenerator: angleGenerator,
            imageGenerator: imageGenerator,
            percentGenerator: percentGenerator
        ).write(
            to: URL(fileURLWithPath: "guunits.c", isDirectory: false),
            atomically: false,
            encoding: .utf8
        )
    /*try CPPHeaderCreator().generate(
        distanceGenerator: cppHeaderDistanceGenerator,
        timeGenerator: cppHeaderTimeGenerator,
        angleGenerator: cppHeaderAngleGenerator
    ).write(
        to: URL(fileURLWithPath: "guunits.hpp", isDirectory: false),
        atomically: false,
        encoding: .utf8
    )
    try CPPFileCreator().generate(
        distanceGenerator: cppDistanceGenerator,
        timeGenerator: cppTimeGenerator,
        angleGenerator: cppAngleGenerator
    ).write(
        to: URL(fileURLWithPath: "guunits_cpp.cc", isDirectory: false),
        atomically: false,
        encoding: .utf8
    )*/
} catch (let e) {
    fatalError("\(e)")
}
