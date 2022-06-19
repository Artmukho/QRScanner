//
//  CaptureView.swift
//  QRScanner
//
//  Created by Artem Muho on 19.06.2022.
//

import UIKit
import AVFoundation

class CaptureView: UIView {
    private var borderView: UIView = {
        var view = UIView(frame: .zero)
        view.layer.borderColor = UIColor.systemYellow.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 6
        return view
    }()
    private var session = AVCaptureSession()
    private var capturePreview = AVCaptureVideoPreviewLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCapture()
        setupCaptureInput()
        setupCaptureOutput()
        addSubview(borderView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCapture() {
        capturePreview = AVCaptureVideoPreviewLayer(session: session)
        capturePreview.frame = layer.bounds
        layer.addSublayer(capturePreview)
        session.startRunning()
    }
    
    private func setupCaptureInput() {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func setupCaptureOutput() {
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: .main)
        output.metadataObjectTypes = [.qr]
    }
}

extension CaptureView: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        borderView.frame = .zero
        guard let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject else { return }
            if object.type == AVMetadataObject.ObjectType.qr {
                let qrObject = capturePreview.transformedMetadataObject(for: object)
                borderView.frame = qrObject?.bounds ?? .zero
        }
    }
}
