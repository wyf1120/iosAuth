//
//  QRScannerViewController.swift
//  iOSAuth
//
//  Created by Aran on 2017/3/6.
//  Copyright © 2017年 Aran. All rights reserved.
//

import UIKit
import AVFoundation

protocol QRScannerViewControllerDelegate {
    func qrScanningDidFinish(controller: QRScannerViewController, url: String)
}

class QRScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    var delegate: QRScannerViewControllerDelegate? = nil
    var isCodeGot: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isCodeGot = false
        
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        let input: AnyObject!
        
        do {
            input = try AVCaptureDeviceInput.init(device: captureDevice)
        } catch {
            print("\(error.localizedDescription)")
            return
        }
        
        captureSession = AVCaptureSession()
        captureSession?.addInput(input as! AVCaptureInput)
        
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        captureSession?.startRunning()
        
        qrCodeFrameView = UIView()
        qrCodeFrameView?.layer.borderColor = UIColor.green.cgColor
        qrCodeFrameView?.layer.borderWidth = 2
        view.addSubview(qrCodeFrameView!)
        view.bringSubview(toFront: qrCodeFrameView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = barCodeObject.bounds
            
            if metadataObj.stringValue != nil && isCodeGot == false{
                if !checkUrl(url: metadataObj.stringValue) {
                    return
                }
                guard let delegate = self.delegate else {
                    fatalError("Delegate for QRScannerViewController is not set")
                }
                isCodeGot = true
                delegate.qrScanningDidFinish(controller: self, url: metadataObj.stringValue)
            }
        }
    }
    
    func checkUrl(url: String) -> Bool {
        print(url)
        if(!url.hasPrefix("Auth://")) {
            return false
        }
        
        let strArray = url.characters.split(separator: "-")
        if(strArray.count != 3) {
            return false
        }
        
        return true
    }
    
    
}
