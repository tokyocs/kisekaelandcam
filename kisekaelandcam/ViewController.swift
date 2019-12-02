//
//  ViewController.swift
//  kisekaelandcam
//
//  Created by tcs15059 on 2019/07/11.
//  Copyright © 2019 tcs15059. All rights reserved.
//

import UIKit
import AVFoundation

//My name is harunori



class ViewController: UIViewController {
 
    var audioPlayer: AVAudioPlayer!
    var haritsukeImage:String!
    

    
    @IBOutlet weak var cameraButton: UIButton!
    var captureSession = AVCaptureSession()
    
    func setupCaptureSession(){
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func styleCaptureButton() {
        cameraButton.layer.borderColor = UIColor.white.cgColor
        cameraButton.layer.borderWidth = 5
        cameraButton.clipsToBounds = true
        cameraButton.layer.cornerRadius = min(cameraButton.frame.width, cameraButton.frame.height) / 2
    }
        
        // メインカメラの管理オブジェクトの作成
        var mainCamera: AVCaptureDevice?
        // インカメの管理オブジェクトの作成
        var innerCamera: AVCaptureDevice?
        // 現在使用しているカメラデバイスの管理オブジェクトの作成
        var currentDevice: AVCaptureDevice?
        
         var photoOutput : AVCapturePhotoOutput?
        
        func setupInputOutput() {
            do {
                // 指定したデバイスを使用するために入力を初期化
                let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice!)
                // 指定した入力をセッションに追加
                captureSession.addInput(captureDeviceInput)
                // 出力データを受け取るオブジェクトの作成
                photoOutput = AVCapturePhotoOutput()
                // 出力ファイルのフォーマットを指定
                photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
                captureSession.addOutput(photoOutput!)
            } catch {
                print(error)
            }
        }

        
    // デバイスの設定
    func setupDevice() {
            // カメラデバイスのプロパティ設定
            let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
            // プロパティの条件を満たしたカメラデバイスの取得
            let devices = deviceDiscoverySession.devices
            
            for device in devices {
                if device.position == AVCaptureDevice.Position.back {
                    mainCamera = device
                } else if device.position == AVCaptureDevice.Position.front {
                    innerCamera = device
                }
            }
            // 起動時のカメラを設定
            currentDevice = mainCamera
        }
    
    // 必要なライブラリをインポートします
    
    @IBAction func touchKuro(_ sender: Any) {
        self.haritsukeImage = "fuku1"
        self.kisekaeLayer?.contents = UIImage(named: self.haritsukeImage)?.cgImage
    }
    
    @IBAction func tuchNewyork(_ sender: Any) {
        self.haritsukeImage = "ILOVENEWYORK"
        self.kisekaeLayer?.contents = UIImage(named: self.haritsukeImage)?.cgImage
    }
    
    @IBAction func touchAo(_ sender: Any) {
        self.haritsukeImage = "fukuG"
        self.kisekaeLayer?.contents = UIImage(named: self.haritsukeImage)?.cgImage
    }
   
    @IBAction func NEWYORKYANKY(_ sender: Any) {
        self.haritsukeImage = "NEWYORK yannki-"
        self.kisekaeLayer?.contents = UIImage(named:
            self.haritsukeImage)?.cgImage
    }
    
    
    @IBAction func Nwawoko1(_ sender: Any) {
        self .haritsukeImage = "Nawokosuka"
        self.kisekaeLayer?.contents = UIImage(named:
            self.haritsukeImage)?.cgImage
    }
    
    
    
    var cameraPreviewLayer : AVCaptureVideoPreviewLayer?
    var kisekaeLayer : CALayer?
    func setupPreviewLayer() {
        // 指定したAVCaptureSessionでプレビューレイヤを初期化
        self.cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.kisekaeLayer = CALayer()
        // let water_image = UIImage(named: "water")!
        self.kisekaeLayer?.frame = self.view.bounds
        // self.kisekaeLayer?.frame.size = water_image.size
        // self.kisekaeLayer?.frame.size = self.view.frame.size
        self.kisekaeLayer?.contents = UIImage(named: self.haritsukeImage)?.cgImage
        //self.kisekaeLayer?.transform = CATransform3DMakeScale(0.045, 0.045, 1.5);
        // self.kisekaeLayer?.contents = water_image
        // プレビューレイヤが、カメラのキャプチャーを縦横比を維持した状態で、表示するように設定
        self.cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        // プレビューレイヤの表示の向きを設定
        self.cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        
        
        
        self.cameraPreviewLayer?.frame = view.frame
        self.view.layer.insertSublayer(self.cameraPreviewLayer!, at: 0)
        self.view.layer.insertSublayer(self.kisekaeLayer!,at: 1)
        // 必要なライブラリをインポートします
       
           
    }
   

    
    
    @IBAction func tuchshutter(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        
      
        // カメラの手ぶれ補正
        settings.isAutoStillImageStabilizationEnabled = true
        // 撮影された画像をdelegateメソッドで処理
        self.photoOutput?.capturePhoto(with: settings, delegate: self as AVCapturePhotoCaptureDelegate)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        randomImage()
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        captureSession.startRunning()
        playSound(name: "Seven_Twenty")
    }
    func randomImage(){
        let randomInt = Int.random(in: 0..<3)
        if (randomInt == 0){
            self.haritsukeImage = "fuku1"
        } else if (randomInt == 1){
            self.haritsukeImage = "fukuG"
        }
        else if (randomInt == 2) {
            self.haritsukeImage = "twoshot"
        }
        self.kisekaeLayer?.contents = UIImage(named: self.haritsukeImage)?.cgImage
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//HELLO MY NAME IS HARUNORI MIYAJI


extension ViewController: AVCapturePhotoCaptureDelegate{
    // 撮影した画像データが生成されたときに呼び出されるデリゲートメソッド
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            // Data型をUIImageオブジェクトに変換
            let uiImage = UIImage(data:imageData)?.composite(image: (UIImage(named:self.haritsukeImage)?.scaleImage(scaleSize: 1.5))!)
            
            // 写真ライブラリに画像を保存
            UIImageWriteToSavedPhotosAlbum(uiImage!, nil,nil,nil)
        }
        randomImage()
    }
}





extension UIImage {
    
    func composite(image: UIImage) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        
        // 画像を真ん中に重ねる
        let rect = CGRect(x: (self.size.width - image.size.width)/2,
                          y: (self.size.height - image.size.height)/2,
                          width: image.size.width,
                          height: image.size.height)
        image.draw(in: rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
        let reSizeImage:UIImage! = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    func scaleImage(scaleSize:CGFloat)->UIImage {
        let reSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        return reSizeImage(reSize: reSize)
    }
}



extension ViewController: AVAudioPlayerDelegate {
    func playSound(name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            print("音源ファイルが見つかりません")
            return
        }
        
        do {
            // AVAudioPlayerのインスタンス化
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            
            // AVAudioPlayerのデリゲートをセット
            audioPlayer.delegate = self
            
            // 音声の再生
            audioPlayer.play()
        } catch {
        }
    }
}
