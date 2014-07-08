# DRProducerConsumerQueue

[![CI Status](http://img.shields.io/travis/danra/DRProducerConsumerQueue.svg?style=flat)](https://travis-ci.org/danra/DRProducerConsumerQueue)
[![Version](https://img.shields.io/cocoapods/v/DRProducerConsumerQueue.svg?style=flat)](http://cocoadocs.org/docsets/DRProducerConsumerQueue)
[![License](https://img.shields.io/cocoapods/l/DRProducerConsumerQueue.svg?style=flat)](http://cocoadocs.org/docsets/DRProducerConsumerQueue)
[![Platform](https://img.shields.io/cocoapods/p/DRProducerConsumerQueue.svg?style=flat)](http://cocoadocs.org/docsets/DRProducerConsumerQueue)

## About

DRProducerConsumerQueue implements a queue with an attached producer block, which runs automatically until the queue has at least a specified number of items ready to consume.
                       
The queue is synchronized on the main thread, while the production work itself can be done in the background.

## Installation

DRProducerConsumerQueue is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod 'DRProducerConsumerQueue'

## Author

Dan Raviv, dan.raviv@gmail.com

## License

DRProducerConsumerQueue is available under the MIT license. See the LICENSE file for more info.
