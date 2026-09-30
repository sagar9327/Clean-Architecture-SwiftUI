# DocumentReaderSDK

A Swift Package Manager-based iOS SDK that provides a guided identity-verification capture flow.

## Features

- Consent before identity capture
- First name and last name collection
- Front-camera selfie capture
- Face detection with Vision
- Fixed centered selfie capture guide
- Automatic selfie capture after stable face detection
- Selfie preview with Retake / Confirm
- Selfie crop to capture region
- Document rectangle detection with Vision
- Automatic document capture after stable detection
- Document preview with Retake / Confirm
- SDK-owned navigation and dismissal
- Swift Package Manager
- No third-party dependencies

## Requirements

| Requirement | Version |
|---|---|
| Platform | iOS |
| Minimum iOS | 16.0 |
| Language | Swift |
| Distribution | Swift Package Manager |
| External dependencies | None |

The minimum deployment target should match `Package.swift`.

## Installation

Add the package to your Xcode project and import:

```swift
import DocumentReaderSDK
```

The library product is:

```text
DocumentReaderSDK
```

## Basic Usage

The host application only needs to start the SDK:

```swift
import UIKit
import DocumentReaderSDK

final class ViewController: UIViewController {

    func startVerification() {
        let reader = DocumentReader()

        Task { @MainActor in
            do {
                let result = try await reader.start(from: self)

                print("First Name:", result.firstName)
                print("Last Name:", result.lastName)
                print("Selfie:", result.selfie)
            } catch {
                print("Document Reader failed:", error)
            }
        }
    }
}
```

The SDK owns the complete flow:

```text
Host App
   |
   v
Consent
   |
   v
User Details
   |
   v
Selfie Capture
   |
   v
Selfie Confirmation
   |
   v
Document Capture
   |
   v
Document Confirmation
   |
   v
SDK Dismissed
   |
   v
DocumentReaderResult
```

## Public API

### DocumentReader

Main SDK entry point:

```swift
public final class DocumentReader
```

```swift
@MainActor
public func start(
    from viewController: UIViewController
) async throws -> DocumentReaderResult
```

### DocumentReaderResult

Current result:

```swift
public struct DocumentReaderResult {
    public let firstName: String
    public let lastName: String
    public let selfie: UIImage
}
```

The document image is currently handled internally. It can be added to the public result model when required.

### DocumentReaderError

SDK flow failures are represented by `DocumentReaderError` and are returned through the thrown error from `start()`.

## Verification Flow

### 1. Consent

The SDK asks the user to agree before collecting identity information, a selfie, and an identity document.

### 2. User Details

The user enters first name and last name. `Next` becomes enabled only when both fields contain values.

### 3. Selfie Capture

The SDK starts the front camera and displays a fixed centered capture box.

Vision detects the face. The SDK waits for a correctly positioned, stable face and automatically captures the selfie.

### 4. Selfie Validation

The current implementation includes:

- Face detection
- Single-face validation
- Brightness analysis
- Blur/sharpness analysis
- Stable-position detection

### 5. Selfie Confirmation

The captured selfie is shown for confirmation.

- Red X = Retake
- Green check = Continue to document capture

The returned selfie is cropped to the capture region.

### 6. Document Capture

Vision rectangle detection is used to detect document-like rectangular regions. The SDK waits for a stable document detection and automatically captures it.

### 7. Document Confirmation

- Red X = Retake
- Green check = Complete

After confirmation, the SDK dismisses its navigation controller and returns the result.

## Internal Apple Frameworks

The SDK currently uses Apple's native frameworks only.

### UIKit

Used for UI and navigation:

```swift
import UIKit
```

Examples:

- `UIViewController`
- `UINavigationController`
- `UILabel`
- `UIButton`
- `UITextField`
- `UIImage`
- Auto Layout

### AVFoundation

Used for camera capture:

```swift
import AVFoundation
```

Examples:

- `AVCaptureSession`
- `AVCaptureDevice`
- `AVCaptureDeviceInput`
- `AVCaptureVideoDataOutput`
- `AVCapturePhotoOutput`
- `AVCaptureVideoPreviewLayer`
- `AVCaptureConnection`

### Vision

Used for computer-vision detection:

```swift
import Vision
```

Face detection:

```swift
VNDetectFaceRectanglesRequest
```

Document detection:

```swift
VNDetectRectanglesRequest
```

### Core Image

Used for image processing and quality analysis:

```swift
import CoreImage
```

Examples:

- `CIImage`
- `CIContext`

### Swift Concurrency

Used for sequential SDK orchestration:

```swift
async
await
Task
withCheckedContinuation
```

The public API therefore exposes one asynchronous operation while the SDK internally coordinates multiple screens.

## Recommended Folder Structure

```text
DocumentReaderSDK/
├── Package.swift
├── README.md
│
├── Sources/
│   └── DocumentReaderSDK/
│       ├── Public/
│       │   ├── DocumentReader.swift
│       │   ├── DocumentReaderError.swift
│       │   └── DocumentReaderResult.swift
│       │
│       ├── Flow/
│       │   ├── ConsentViewController.swift
│       │   ├── UserDetailsViewController.swift
│       │   ├── SelfieViewController.swift
│       │   └── DocumentScannerViewController.swift
│       │
│       ├── Camera/
│       │   ├── CameraManager.swift
│       │   ├── AVCaptureCameraManager.swift
│       │   ├── FaceCameraManager.swift
│       │   ├── DocumentCameraManager.swift
│       │   └── SimulatorCameraManager.swift
│       │
│       ├── Detection/
│       │   ├── FaceDetector.swift
│       │   ├── DocumentDetector.swift
│       │   └── ImageQualityAnalyzer.swift
│       │
│       └── Models/
│           ├── UserDetails.swift
│           └── CapturedDocument.swift
│
└── Tests/
    └── DocumentReaderSDKTests/
        └── DocumentReaderSDKTests.swift
```

## Why This Structure?

### Public

Only types that consumers need:

```text
DocumentReader
DocumentReaderResult
DocumentReaderError
```

### Flow

All SDK screens and flow-specific UI.

### Camera

Camera session, preview and capture implementations.

### Detection

Vision and image-quality logic.

### Models

Internal data structures shared between SDK components.

## Simulator Support

`SimulatorCameraManager` provides a development/test implementation for simulator use.

For realistic camera behavior, test on a physical iPhone.

## Camera Permission

The host application must provide a camera usage description in `Info.plist`:

```text
Privacy - Camera Usage Description
```

Example:

```text
Camera access is required to capture your selfie and identity document.
```

## Current Scope and Limitations

This is a learning/reference implementation of an identity-capture SDK. It should not be presented as a production identity-verification system.

It currently does **not** implement:

- OCR/data extraction
- MRZ parsing
- Barcode decoding
- NFC document reading
- Face recognition/matching
- Active/passive liveness detection
- Document authenticity verification
- Server-side identity verification
- Fraud detection
- Production PII lifecycle management
- Encryption-at-rest

These would require additional implementation, backend integration and security review.

## Testing Areas

Recommended tests include:

- Consent acceptance
- User details validation
- Selfie capture and retake
- Document capture and retake
- No face / multiple faces
- Face outside / inside capture region
- No document / document detected
- Dark image
- Blurry image
- Camera unavailable
- Camera permission denied
- Capture failure
- Complete end-to-end flow

## Architecture Goal

The host application's integration point should remain simple:

```swift
try await reader.start(from: self)
```

All camera, Vision, UI navigation, validation and capture orchestration should remain internal to the SDK.

## License

Add the project's chosen license before publishing the repository publicly.
