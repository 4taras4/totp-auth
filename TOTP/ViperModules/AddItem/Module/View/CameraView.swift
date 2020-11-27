//
//  CameraView.swift
//  TOTP
//
//  Created by Taras Markevych on 10.10.2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

protocol CameraCaptureDelegate: class {
    func capture(string: String?)
}

final class CameraView: UIView {
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?

    private lazy var session: AVCaptureSession = {
        let s = AVCaptureSession()
        return s
    }()

    var delegate: CameraCaptureDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    deinit {
        captureSession?.stopRunning()
    }
    
    private func commonInit() {
        contentMode = .scaleAspectFit
        beginSession()
    }

    private func beginSession() {
            captureSession = AVCaptureSession()

            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
            let videoInput: AVCaptureDeviceInput

            do {
                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            } catch {
                return
            }

            if ((captureSession?.canAddInput(videoInput)) != nil) {
                captureSession?.addInput(videoInput)
            } else {
                return
            }

            let metadataOutput = AVCaptureMetadataOutput()

            if ((captureSession?.canAddOutput(metadataOutput)) != nil) {
                captureSession?.addOutput(metadataOutput)

                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417, .qr]
            } else {
                return
            }
            guard let session = captureSession else {
                return
            }
            previewLayer = AVCaptureVideoPreviewLayer(session: session)
        
            previewLayer?.frame = self.layer.bounds
            previewLayer?.videoGravity = .resizeAspectFill
            guard let previewLayer = previewLayer else {
                return
            }
            self.layer.addSublayer(previewLayer)
            session.startRunning()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer?.frame = bounds
    }
}

extension CameraView: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession?.stopRunning()
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            delegate?.capture(string: stringValue)
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
}
