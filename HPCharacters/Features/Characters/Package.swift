// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Characters",
    platforms: [.iOS(.v14)], // Minimum iOS version set to 14.0
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Characters",
            targets: ["Characters"]),
        
        .library(name: "CharactersRoute", targets: ["CharactersRoute"]),
        
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(path: "../Neu/Core"),
        .package(path: "../Neu/NetworkManager"),
        .package(path: "../Neu/NavigationManager"),
        .package(path: "../Shared"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", exact: "1.17.4"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Characters",
            dependencies: ["Shared" ,"Core", "CharactersMapper", "CharactersData", "CharactersDomain", "CharactersPresentation"]
        ),
        .testTarget(
            name: "CharactersTests",
            dependencies: ["Characters", "CharactersData", "CharactersDomain", "CharactersPresentation", "CharactersMapper", "Shared"]
        ),
        
        .testTarget(
            name: "CharactersUITests",
            dependencies: [
                "Characters", "CharactersData", "CharactersDomain", "CharactersPresentation", "CharactersMapper", "Shared",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ]
        ),
        
        .target(name: "CharactersData",
                dependencies: ["Core", "NetworkManager"],
                path: "Sources/Data"
        ),
        
        .target(name: "CharactersDomain",
                dependencies: ["Shared", "CharactersData"],
                path: "Sources/Domain"
        ),
        
        .target(name: "CharactersMapper",
                dependencies: ["Core", "Shared", "CharactersData", "CharactersDomain"],
                path: "Sources/Mapper"
        ),
        
        .target(
            name: "CharactersPresentation",
            dependencies: ["Core", "CharactersDomain", "CharactersUiKit", "NavigationManager"],
            path: "Sources/Presentation"
        ),
        
        .target(
            name: "CharactersRoute",
            dependencies: ["CharactersPresentation", "Shared" ,"Core"],
            path: "Sources/Route"
        ),
        
        .target(
            name: "CharactersUiKit",
            dependencies: ["Shared" ,"Core"],
            path: "Sources/UiKit"
        ),
    ]
)
