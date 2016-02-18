//
//  SSQRScanner.swift
//
//  Created by Susim Samanta on 26/08/15.
//  Copyright (c) 2015 Susim Samanta. All rights reserved.
//

import UIKit
import AVFoundation

public typealias SSQRScannerHandler = (obj : AnyObject? , error : NSError?) -> Void
class SSQRScanner: NSObject,AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession:AVCaptureSession?
    var scannerPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrScannerHandler: SSQRScannerHandler?
    
    func createQRScannerOnCompletion(inView: UIView?, scannerHandler :SSQRScannerHandler) {
        
        self.qrScannerHandler = scannerHandler
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error:NSError?
        let input: AnyObject!
        do {
            input = try AVCaptureDeviceInput(device: captureDevice!)
        } catch let error1 as NSError {
            error = error1
            input = nil
        }
        if (error != nil) {
            self.qrScannerHandler!(obj: nil, error: error)
            return;
        }
        captureSession = AVCaptureSession()
        captureSession?.addInput(input as! AVCaptureInput)
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        scannerPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        scannerPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        scannerPreviewLayer?.frame = inView!.layer.bounds
        inView!.layer.addSublayer(scannerPreviewLayer!)
        
        captureSession?.startRunning()

    }
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        if metadataObjects == nil || metadataObjects.count == 0 {
            self.qrScannerHandler!(obj: nil, error:nil)
        }
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            _ = scannerPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            self.qrScannerHandler!(obj: metadataObj.stringValue, error: nil)
        }
        captureSession?.stopRunning()
    }
}
