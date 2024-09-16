---
title: "Getting Started with CoreML"
description: "Building an object detection application"
date: 2018-05-24T21:32:03-05:00
draft: false
author: Kyle Haptonstall
---

![Image via Apple](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*HOmbarPbQeI2NqTVk6Z1Jw.png)

In iOS 11, Apple introduced the CoreML framework, which enables developers to leverage the power of machine learning on our devices. While we are limited to using trained models in iOS, there are numerous pretrained models available for use to begin integrating with today — the largest collection of models being object detection models, which I will run through an example of integrating below.

Note that if you do find yourself in a situation where some of the Apple provided models just aren’t working for the application you’re trying to build, I’ve outlined alternatives at the end of my post.

Also, if you really want to take a deep dive into the science of machine learning for a richer understanding, I can personally recommend [Andrew Ng’s Coursera course](https://www.coursera.org/learn/machine-learning) on the subject, which is available for free.

Let’s get started in building an object detection application!

A Little Bit of Setup
=====================

Since we’re are walking through the basics of setting up an image object detection application, there is a little bit of setup required to get images to our model. I won’t go over in high detail since this post is about CoreML, but I will provide the code to get you started.

First you will need to add the `Privacy — Camera Usage Description` and `Privacy — Photo Library Usage Description` keys to your `info.plist` file.

Then add the following code to present an action sheet that will allow the user to bring photos into your app.

```swift
class ViewController: UIViewController {
	
	//Setup button in IB and drag touchUpInside action here
   @IBAction func pickImageButtonPressed(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            DispatchQueue.main.async {
                self.presentImagePicker(withType: .camera)
            }
        }
        
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            DispatchQueue.main.async {
                self.presentImagePicker(withType: .photoLibrary)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(libraryAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
        
    private func presentImagePicker(withType type: UIImagePickerControllerSourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = type
        present(pickerController, animated: true)
    }
}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true)
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Couldn't load image picked image")
        }
        
        imageView.image = image
        
        guard let ciImage = CIImage(image: image) else {
            fatalError("Couldn't convert UIImage to CIImage")
        }
        
	detectObjects(from ciImage)
    }
    
}
```

Choosing the right model
========================

Apple has already converted many popular trained models and made them available for download [here](https://developer.apple.com/machine-learning/). In order to choose the right model for your application, you can view the original model details, which provides multiple sources of information on the creation and application of each model, including the labels for which the model attempts to categorize images into.

All you need to do is download the model you’d like to use, then drag-and-drop it into your Xcode project.

For a quick example of the output from each model provided by Apple, I’ve also made a [project](https://github.com/khaptonstall/CoreML-Model-Comparer) that will allow you to upload a photo and see how each model classifies the main object.

Generate a Vision CoreML Model From Your Imported Model
=======================================================

In this step you’ll begin using Apple’s Vision framework to create a container for your imported model file. This container, a `VNCoreMLModel`, is what we’ll use to perform our image classification requests on.

```swift
func generateVisionModel(from model: MLModel) -> VNCoreMLModel {
  guard let visionModel = try? VNCoreMLModel(for: model) else {
    fatalError("Failed to load CoreML model")
  }      
  
  return visionModel
}
```

Note that the`VNCoreMLModel` initializer throws an error if the passed in model is unsupported. This can occur when the imported model does not accept images as input.

Create a Vision CoreML Request
==============================

In this step you define the actual request which will be invoked in the next step. Here you’re just writing a completion block to be executed when the model evaluates your image, and what to do with the output. We will be printing it to the console.

```swift
func generateVisionRequest(with model: VNCoreMLModel) -> VNCoreMLRequest {
	let visionRequest = VNCoreMLRequest(model: model) { (request, error) in
		if let error = error {
			print(error)
		} else {
			guard let results = request.results as? [VNClassificationObservation],
				let topResult = results.first else {
				fatalError("Unexpected result type from VNCoreMLRequest")
			}
                
            print("Prediction: \(topResult.identifier). Confidence: \(topResult.confidence)")
        }
    }

    return visionRequest
}
```

Perform the Request and Classify the Image
==========================================

The last step is to pass the request off to a `VNImageRequestHandler` which will actually kick off the request and call your completion handler.

```swift
func handleImageRequest(_ request: VNCoreMLRequest, withImage image: CIImage) {

	let handler = VNImageRequestHandler(ciImage: image)
		DispatchQueue.global(qos: .userInteractive).async {
			do {
				try handler.perform([request])
			} catch {
				print(error)
			}
	}
	
}
```

Note that the DispatchQueue.global(qos: .userInteractive).async `DispatchQueue.global(qos: .userInteractive).async` just means that we are moving the work off of the main thread, and by providing the Quality of Service level of `.userInteractive` we are increasing it’s priority in the queue.

Then you can put it all together.

```swift
func detectObjects(from image: CIImage) {
    let visionModel = generateVisionModel(from: MobileNet().model)
    let visionRequest = generateVisionRequest(with: visionModel)
    handleImageRequest(visionRequest, withImage: image)
}
```

And that’s it! You should be seeing the model’s prediction and it’s confidence printing to the console. Now you can easily swap out the model we used for another one listed on Apple’s website, or even look into alternatives below.

# Alternatives to Apple’s Provided Models

## Open Source Converted Models

Here’s an open source list of already converted models that are ready to be pulled into Xcode!

[likedan/Awesome-CoreML-Models](https://github.com/likedan/Awesome-CoreML-Models)

## Convert a custom model

Apple provides directions and points to tools that will allow you to convert trained models into the proper CoreML file type.

[Converting Trained Models to Core ML | Apple Developer Documentation](https://developer.apple.com/documentation/coreml/converting_trained_models_to_core_ml)

## Clarifai

Clarifai provides an easy-to-use API that allows developers to send images to their service and have one of their trained models determine what your image contains. There is a fee associated past 5,000 requests/month, but it a simple tool to use for fun or at a hackathon.

[Models clarifai.com](https://clarifai.com/models)

## IBM Watson

You could also integrate with IBM Watson services to continuously train and redeploy your models in the cloud.

[IBM Watson - Apple Developer](https://developer.apple.com/ibm/)

## Lobe.ai

Lobe.ai was recently brought to my attention by a co-worker and looks like a simple and fun-to-use tool for creating CoreML models. While I personally have not had the chance to use it, it may be worth investigating.

[Lobe | Deep Learning Made Simple lobe.ai](https://lobe.ai/)